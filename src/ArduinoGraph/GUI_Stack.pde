/*
  This Class handle the GUI Elements, such as Window (like Container)
  
  This is based on the Self-Pointing Structure but actual working is by Array
*/
class GUI_Stack
{
  // Private:
  GUI_Graph[] stack = new GUI_Graph[64];
  int size = 0;
  
  // Public:
  void push(GUI_Graph _data)
  {
    stack[size] = _data;
    ++size;
  }
  
  void pop()
  {
    if(size > 0)
    {
      --size;
    }
  }
  
  GUI_Graph top()
  {
    if(size == 0)
    {
      return null;
    }
    else
    {
      return stack[size-1];
    }
  }
  
  GUI_Graph getAt(int _index)
  {
    if(_index < 0 || _index >= size)
    {
      return null;
    }
    else
    {
      return stack[_index];
    }
  }
  
  void erase(int _index)
  {
    // Warning : This method is reaaalllllly slow because it moves every elements
    if(_index >= 0 && _index < size)
    {
      for(int i=_index; i<size-1; ++i)
      {
        stack[i] = stack[i+1];
      }
      --size;
    }
  }
  
  void empty()
  {
    size = 0;
  }
  
  boolean isEmpty()
  {
    if(size == 0)
    {
      return false;
    }
    else
    {
      return true;
    }
  }
  
  void render()
  {
    background(0);
    for(int i=0; i<size; ++i)
    {
      stack[i].render();
    }
  }
}
