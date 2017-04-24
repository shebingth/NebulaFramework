public without sharing class DescribeUtils {
    public static SObjectType getSObjectType(Schema.SObjectField field) {
        //There is supposed to be a built in Salesforce getDescribe() result for Schema.SObjectField, getReferenceTo()
        //that should return a list of objects that field is associated with, but it has been broken for several years.
        //This is a solution that was proposed on the Salesforce stack exchange and is the only work-around to a native lookup
        //that I have been able to find.
        Integer fieldHash = ((Object)field).hashCode();

        // Build a map of hashcodes for each fieldDescribe taken from Schema Global Describe
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        Map<Integer,Schema.SObjectType> fieldHashCodeToSObjectTypeMap = new Map<Integer,Schema.SObjectType>();
        for (String sobjname: globalDescribe.keySet()) {
            for (Schema.SObjectField sobjField : globalDescribe.get(sObjName).getDescribe().fields.getMap().values())
                fieldHashCodeToSObjectTypeMap.put(((Object) sObjField).hashCode(), globalDescribe.get(sobjName));
        }

        return fieldHashCodeToSObjectTypeMap.get(fieldHash);
    }
}