package projectzulu.common.mobs.entitydefaults;

import java.io.File;

import net.minecraftforge.common.Configuration;
import projectzulu.common.core.DefaultCreature;
import projectzulu.common.mobs.entity.EntityFollower;
import projectzulu.common.mobs.models.ModelFollower;

public class FollowerDefault extends DefaultCreature{

	public FollowerDefault(){
		super("Follower", EntityFollower.class);		
		setRegistrationProperties(128, 3, true);
		setModelAndRender(ModelFollower.class, "projectzulu.common.mobs.renders.RenderGenericLiving");

	}
	
	@Override
	public void loadCreaturesFromConfig(Configuration config) {}
	
	@Override
	public void outputDataToList(File configDirectory) {}
}