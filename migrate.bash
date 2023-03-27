# Set the variables
org_url="org"
project_name="name_project"
filter_name_start="IR2"

# Authenticate with Azure DevOps

# Define the PAT (replace "your-pat-here" with your actual token)
pat="yourPat"

# Set the authentication header
auth_header="Authorization: Basic $(echo -n :$pat | base64)"

repositories=$(az repos list --organization $org_url --project "$project_name" --query "[?starts_with(name, '$filter_name_start')].name" -o tsv | sed 's/ /%20/g')

for repository in $repositories
do
    # Define the clone URL for the repository
    clone_url="$org_our/$project_name/_git/$repository"
    
    # Replace spaces with % in the repository name
    repo_name=$(echo "$repository" | sed 's/ /%20/g')

    # Clone the repository.
    #echo "Cloning repository $repository"
    git clone "$clone_url" "$repository"
    echo $repository
done