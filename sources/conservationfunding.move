module ConservationFunding {
    use 0x1::Address;
    use 0x1::Signer;
    use 0x1::Vector;
    use 0x1::Option;
    use 0x1::Debug;

    struct Project {
        id: u64,
        name: string,
        description: string,
        funds_raised: u64,
        target_amount: u64,
    }

    struct FundingPlatform {
        projects: Vector::Vector<Project>,
    }

    public fun new_platform(): FundingPlatform {
        FundingPlatform {
            projects: Vector::empty<Project>(),
        }
    }

    public fun create_project(platform: &mut FundingPlatform, id: u64, name: string, description: string, target_amount: u64) {
        let project = Project {
            id,
            name,
            description,
            funds_raised: 0,
            target_amount,
        };
        Vector::push_back(&mut platform.projects, project);
    }

    public fun donate(platform: &mut FundingPlatform, project_id: u64, amount: u64) {
        // Find the project index and the updated vector
        let (found, updated_projects) = update_project(&platform.projects, project_id, amount);

        if (found) {
            platform.projects = updated_projects;
        } else {
            Debug::debug(&format!("Project with ID {} not found", project_id));
        }
    }

    fun update_project(projects: &Vector::Vector<Project>, project_id: u64, amount: u64): (bool, Vector::Vector<Project>) {
        let mut updated_projects = Vector::empty<Project>();
        let mut found = false;

        // Iterate through the vector to find and update the project
        let length = Vector::length(projects);
        let mut index = 0;
        
        while (index < length) {
            let project = Vector::borrow(projects, index);
            if (project.id == project_id) {
                found = true;
                let updated_project = Project {
                    id: project.id,
                    name: project.name.clone(),
                    description: project.description.clone(),
                    funds_raised: project.funds_raised + amount,
                    target_amount: project.target_amount,
                };
                Vector::push_back(&mut updated_projects, updated_project);
            } else {
                Vector::push_back(&mut updated_projects, project);
            }
            index += 1;
        }
        
        (found, updated_projects)
    }





    public fun get_project(platform: &FundingPlatform, project_id: u64): Project {
        Vector::borrow(&platform.projects, project_id)
    }
}