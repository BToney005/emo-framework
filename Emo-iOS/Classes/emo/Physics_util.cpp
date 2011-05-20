#include "Box2D/Box2D.h"
#include "Squirrel.h"

#if __cplusplus
extern "C" {
#endif

#include "stdio.h"
#include "Physics_util.h"
#include "Constants.h"
#include "VmFunc.h"

extern void LOGI(const char* msg);
extern void LOGW(const char* msg);
extern void LOGE(const char* msg);
	
/*
 * Get b2Vec2 from emo.Vec2
 */
void getVec2Instance(HSQUIRRELVM v, int idx, b2Vec2* vec2) {
	getInstanceMemberAsFloat(v, idx, "x", &vec2->x);
	getInstanceMemberAsFloat(v, idx, "y", &vec2->y);
}

/*
 * Get b2Vec2 from emo.Vec2 of instance member
 */
void getVec2InstanceFromMember(HSQUIRRELVM v, int idx, const char* member, b2Vec2* vec2) {
	getInstanceMemberAsTable(v, idx, member, "x", &vec2->x);
	getInstanceMemberAsTable(v, idx, member, "y", &vec2->y);
}

/*
 * Push b2Vec2 as an array
 */
void pushVec2(HSQUIRRELVM v, b2Vec2 vec2) {
	sq_newarray(v, 0);
	
	sq_pushfloat(v, vec2.x);
	sq_arrayappend(v, -2);
	
	sq_pushfloat(v, vec2.y);
	sq_arrayappend(v, -2);
	
	sq_push(v, -1);
}	

/*
 * get b2BodyDef from emo.BodyDef instance
 */
void getBodyDefInstance(HSQUIRRELVM v, int idx, b2BodyDef* def) {
	SQInteger btype;
	getInstanceMemberAsInteger(v, idx, "type", &btype);
	switch(btype) {
		case PHYSICS_BODY_STATIC:
			def->type = b2_staticBody;
			break;
		case PHYSICS_BODY_KINEMATIC:
			def->type = b2_kinematicBody;
			break;
		case PHYSICS_BODY_DYNAMIC:
			def->type = b2_dynamicBody;
			break;
	}
	getVec2InstanceFromMember(v, idx, "position", &def->position);
	getInstanceMemberAsFloat(v,  idx, "angle",    &def->angle);
	getVec2InstanceFromMember(v, idx, "linearVelocity",  &def->linearVelocity);
	getInstanceMemberAsFloat(v,  idx, "angularVelocity", &def->angularVelocity);
	getInstanceMemberAsFloat(v,  idx, "linearDamping",   &def->linearDamping);
	getInstanceMemberAsFloat(v,  idx, "angularDamping",  &def->angularDamping);
	getInstanceMemberAsBool(v,   idx, "allowSleep",      &def->allowSleep);
	getInstanceMemberAsBool(v,   idx, "awake",           &def->awake);
	getInstanceMemberAsBool(v,   idx, "fixedRotation",   &def->fixedRotation);
	getInstanceMemberAsBool(v,   idx, "bullet",          &def->bullet);
	getInstanceMemberAsBool(v,   idx, "active",          &def->active);
	getInstanceMemberAsFloat(v,  idx, "inertiaScale",    &def->inertiaScale);
}

/*
 * Get b2FixtureDef from emo.FixtureDef instance
 */
void getFixtureDefInstance(HSQUIRRELVM v, int idx, b2FixtureDef* def) {
	getInstanceMemberAsFloat(v,  idx, "friction",    &def->friction);
	getInstanceMemberAsFloat(v,  idx, "restitution", &def->restitution);
	getInstanceMemberAsFloat(v,  idx, "density",     &def->density);
	getInstanceMemberAsBool(v,   idx, "isSensor",    &def->isSensor);
	
	SQUserPointer ptr_shape;
	if (getInstanceMemberAsInstance(v, idx, "shape", "id", &ptr_shape)) {
		def->shape = reinterpret_cast<b2Shape*>(ptr_shape);
	}
}

/*
 * Get b2DistanceJointDef from emo.DistanceJointDef instance
 */
void getDistanceJointDef(HSQUIRRELVM v, int idx, b2DistanceJointDef* def) {
	getInstanceMemberAsFloat(v, idx, "frequencyHz", &def->frequencyHz);
	getInstanceMemberAsFloat(v, idx, "dampingRatio", &def->dampingRatio);
}

/*
 * Get b2FrictionJointDef from emo.FrictionJointDef instance
 */
void getFrictionJointDef(HSQUIRRELVM v, int idx, b2FrictionJointDef* def) {
	getInstanceMemberAsFloat(v, idx, "maxForce", &def->maxForce);
	getInstanceMemberAsFloat(v, idx, "maxTorque", &def->maxTorque);
}
	
/*
 * Get b2GearJointDef from emo.GearJointDef instance
 */
void getGearJointDef(HSQUIRRELVM v, int idx, b2GearJointDef* def) {
	getInstanceMemberAsFloat(v, idx, "ratio", &def->ratio);
	
	SQUserPointer ptr_joint1;
	if (getInstanceMemberAsInstance(v, idx, "joint1", "id", &ptr_joint1)) {
		def->joint1 = reinterpret_cast<b2Joint*>(ptr_joint1); 
	}
	
	SQUserPointer ptr_joint2;
	if (getInstanceMemberAsInstance(v, idx, "joint2", "id", &ptr_joint2)) {
		def->joint2 = reinterpret_cast<b2Joint*>(ptr_joint2); 
	}
}

/*
 * Get b2LineJointDef from emo.LineJointDef instance
 */
void getLineJointDef(HSQUIRRELVM v, int idx, b2LineJointDef* def) {
	getInstanceMemberAsBool(v, idx, "enableLimit", &def->enableLimit);
	getInstanceMemberAsFloat(v, idx, "lowerTranslation", &def->lowerTranslation);
	getInstanceMemberAsFloat(v, idx, "upperTranslation", &def->upperTranslation);
	getInstanceMemberAsBool(v, idx, "enableMotor", &def->enableMotor);
	getInstanceMemberAsFloat(v, idx, "maxMotorForce", &def->maxMotorForce);
	getInstanceMemberAsFloat(v, idx, "motorSpeed", &def->motorSpeed);
}

/*
 * Get b2PrismaticJointDef from emo.PrismaticJointDef instance
 */
void getPrismaticJointDef(HSQUIRRELVM v, int idx, b2PrismaticJointDef* def) {
	getInstanceMemberAsBool(v, idx, "enableLimit", &def->enableLimit);
	getInstanceMemberAsFloat(v, idx, "lowerTranslation", &def->lowerTranslation);
	getInstanceMemberAsFloat(v, idx, "upperTranslation", &def->upperTranslation);
	getInstanceMemberAsBool(v, idx, "enableMotor", &def->enableMotor);
	getInstanceMemberAsFloat(v, idx, "maxMotorForce", &def->maxMotorForce);
	getInstanceMemberAsFloat(v, idx, "motorSpeed", &def->motorSpeed);
}

/*
 * Get b2PulleyJointDef from emo.PulleyJointDef instance
 */
void getPulleyJointDef(HSQUIRRELVM v, int idx, b2PulleyJointDef* def) {
	// no item to convert
}

/*
 * Get b2RevoluteJointDef from emo.RevoluteJointDe instance
 */
void getRevoluteJointDef(HSQUIRRELVM v, int idx, b2RevoluteJointDef* def) {
	getInstanceMemberAsBool(v, idx, "enableLimit", &def->enableLimit);
	getInstanceMemberAsFloat(v, idx, "lowerAngle", &def->lowerAngle);
	getInstanceMemberAsFloat(v, idx, "upperAngle", &def->upperAngle);
	getInstanceMemberAsBool(v, idx, "enableMotor", &def->enableMotor);
	getInstanceMemberAsFloat(v, idx, "maxMotorTorque", &def->maxMotorTorque);
	getInstanceMemberAsFloat(v, idx, "motorSpeed", &def->motorSpeed);
}

/*
 * Get b2WeldJointDef from emo.WeldJointDef instance
 */
void getWeldJointDef(HSQUIRRELVM v, int idx, b2WeldJointDef* def) {
	// no item to convert
}
#if __cplusplus
}   // Extern C
#endif
