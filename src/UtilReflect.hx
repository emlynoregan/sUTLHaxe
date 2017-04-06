class UtilReflect
{
    public static function fields(obj: Dynamic): Array<Dynamic> 
    {
    	return Reflect.fields(obj);
    }

    public static function hasField(obj: Dynamic, fieldname: String): Bool
    {
        return Reflect.hasField(obj, fieldname);
    }

    public static function field(obj: Dynamic, fieldname: String): Dynamic
    {
        return Reflect.field(obj, fieldname);
    }

    public static function setField(obj: Dynamic, fieldname: String, value: Dynamic)
    {
        return Reflect.setField(obj, fieldname, value);
    }

    public static function deleteField(obj: Dynamic, fieldname: String)
    {
        return Reflect.deleteField(obj, fieldname);
    }
}