# health_demo

dbt project for the Health Demo warehouse. The project cleans raw Airbyte-loaded
Google Sheets data in `staging_health` and builds dashboard-ready marts.

### Using the starter project

Try running the following commands:
- `dbt deps`
- `dbt build --target dev`

The local profile name is `health_demo`. Raw sources are expected in the
`staging_health` schema.


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
