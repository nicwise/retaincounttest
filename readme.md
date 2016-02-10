The output of this is


```
-[ViewController testWithStrongWeak]
-----------------
3		starting retain count
3		before calling with a local anon block
3		calling block
4		in block
3		after call
3		after calling with a local anon block
-----------------
3		before calling with a other anon block
4		in block
3		after calling with a other anon block
3		end retain count
-----------------
-[ViewController testWithoutStrongWeak]
-----------------
3		starting retain count
3		before local anon block
4		calling block
4		in block
4		after call
4		after local anon block
-----------------
4		before other class anon block
5		in block
5		after other class anon block
5		end retain count
-----------------
-[ViewController testWithStrongWeakWithLocalProperty]
-----------------
3		starting retain count
3		creating the block as property
3		after create block as property
-----------------
3		self with block property
3		calling block
4		in local prop block
3		after call
3		after self with block property
-----------------
3		other object with block property
4		in local prop block
3		after other object with block property
-----------------
3		calling local prop directly
4		in local prop block
3		end of calling local prop directly
-----------------
3		before setting block to nil
3		local block is now nil
3		end retain count
-----------------
-[ViewController testWithoutStrongWeakWithLocalProperty]
-----------------
3		starting retain count
3		creating the block as property
5		after create block as property
-----------------
5		self with block property
5		calling block
5		in local prop block
5		after call
5		after self with block property
-----------------
5		other object with block property
5		in local prop block
5		after other object with block property
-----------------
5		calling local prop directly
5		in local prop block
5		end of calling local prop directly
-----------------
5		before setting block to nil
4		local block is now nil
4		end retain count
-----------------
```
