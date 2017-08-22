#------------------------------------------------------------------------
# Copyright (C) 2000 Michael Grubits.
#
# This file is part of DHCPStatus.
#
# DHCPStatus is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# DHCPStatus is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with DHCPStatus; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#------------------------------------------------------------------------

sub display_html {

#
# Take a Display object, and print out the information as HTML.
#

   use CGI qw/:standard *table start_ul/;

   my $display = shift;

   my $q = new CGI;

   print $q->header;
   my $title = $display->title;
   print $q->start_html(-title=>"DHCPStatus",-style=>{'code'=>'
                                              body { 
                                                  font-family: Verdana,sans-serif;  
                                                  line-height: 1;
                                                  align: center;
                                                }
                                                table {
                                                  border: 1px solid #ccc;
                                                  border-right: 1px solid #ccc;
                                                  border-left: 1px solid #ccc;
                                                  border-collapse: collapse;
                                                  width: 85%;
                                                  margin-left: auto;
                                                  margin-right: auto;
                                                }
                                                table caption {
                                                  font-size: 1.5em;
                                                  margin: .5em 0 .75em;
                                                }
                                                table tr {
                                                  border: 1px solid #ddd;
                                                  padding: .35em;
                                                }
                                                table th,
                                                table td {
                                                  padding: .625em;
                                                  text-align: center;
                                                }
                                                table th {
                                                  font-size: .85em;
                                                  letter-spacing: .1em;
                                                  text-transform: uppercase;
                                                  background-color: #2E64FE;
                                                  color: white;
                                                  height: 25px;
                                                }
                                                a {
                                                    text-decoration:none;
                                                    color: #2E64FE;
                                                }
                                                td a {
                                                    display: block;
                                                    height: 20px;
                                                    background: #b0b0b0;
                                                    padding: 10px;
                                                    text-align: center;
                                                    border-radius: 5px;
                                                    color: #2E64FE;
                                                    font-weight: bold;
                                                    text-decoration:none;
                                                }

                                                #submit{
                                                    height: 40px;
                                                    background: #2E64FE;
                                                    padding: 10px;
                                                    margin-left: 10px;
                                                    text-align: center;
                                                    border-radius: 5px;
                                                    color: white;
                                                    font-weight: bold;
                                                    text-decoration:none;
                                                    border:0 none;
                                                }

                                                #mainBar {
                                                    background-color: #b0b0b0;
                                                    color: white;
                                                    font-family: Verdana,sans-serif;
                                                    font-size: 12pt;
                                                    font-weight: normal;
                                                    margin-left: auto;
                                                    margin-right: auto;
                                                    padding: 10px;
                                                    text-align: right;
                                                    height: 70px;
                                                }
                                                #header {
                                                    background-color: #2E64FE;
                                                    color: white;
                                                    font-family: Verdana,sans-serif;
                                                    font-size: 22pt;
                                                    font-weight: bold;
                                                    height: 40px;
                                                    padding: 10px;
                                                    text-align: center;
                                                }
                                                .gris {
                                                    background-color: #d0d0d0;
                                                    color: #2E64FE;
                                                }
                                                [class^=arr-]{
                                                    border:       solid currentColor;
                                                    border-width: 0 .2em .2em 0;
                                                    display:      inline-block;
                                                    padding:      .20em;
                                                    float:left;
                                                    font-size: 80px;
                                                    margin-top: 10px;
                                                    margin-left: 10px;
                                                    background: #b0b0b0;
                                                }
                                                .arr-right {transform:rotate(-45deg);  -webkit-transform:rotate(-45deg);}
                                                .arr-left  {transform:rotate(135deg);  -webkit-transform:rotate(135deg);}
                                                .arr-up    {transform:rotate(-135deg); -webkit-transform:rotate(-135deg);}
                                                .arr-down  {transform:rotate(45deg);   -webkit-transform:rotate(45deg);}

                                                '});
   
   print "<div id='header'>".substr($title, 0, 41)."         
          </div>";
   

   my $parm_count = $display->parm_count;   # parms (if any) are
   if ($parm_count >= 0) {       
     print '<div id="mainBar"> 
                <a href="http://astprod.imm.gub.uy/cgi-bin/dhcpstatus.cgi"><i class="arr-left"></i></a>

            <img class="standard" src="https://www.isc.org/wp-content/uploads/2013/05/isc-logo.png" alt="Internet Systems Consortium">       
            </div>';
   } else {
     print '<div id="mainBar">
              <div style="float:left;clear: both;margin-top:15px">
                <form method=GET action="/cgi-bin/search.cgi"> 
                  <input style="float:left;clear: both;height:28px;clear: both" type=text name="host" size="25"/> 
                  <input type="submit" id="submit" value="BUSCAR"/>                               
                </form> 
              </div>    
              <img class="standard" src="https://www.isc.org/wp-content/uploads/2013/05/isc-logo.png" alt="Internet Systems Consortium">       
            </div>';
   }     

   print $q->p;      

   if ($parm_count >= 0) {        # printed first.
      print $q->start_table({-border=>1});
      print "<tr>
                <th class='gris' colspan='7'>DATOS DE LA RED: ".substr($title, 42, length($title))."</th>
             </tr>";
      print $q->Tr;       
      for (my $row = 0; $row <= $parm_count; $row++) {
         my @parm1 = $display->get_parm($row);
         print $q->th([$parm1[0]]);
      }  
      print $q->Tr;
      for (my $row = 0; $row <= $parm_count; $row++) {
         my @parm2 = $display->get_parm($row);
         print $q->td([$parm2[1]]);
      }      
      print $q->end_table;
               
   }  


   print $q->start_table({-border=>1});

  ########## STATICS IP ################

    my $static_display = $display->static_display;

    #use Data::Dumper;
    #print Dumper($static_display);

    if ($static_display){
     
       my $row_count_static = $static_display->row_count;

       if ($row_count_static >= 0){

          print "<tr>
                    <th class='gris' colspan='7'>DATOS DE LAS IPs EST&aacute;TICAS</th>
                  </tr>";

          my @static_headings = $static_display->headings; 
          print $q->Tr([th([@static_headings])]); 

          # muestro las ip static     
          for (my $i = 0; $i <= $row_count_static; $i++) { # print the tabular info row
            my @row = $static_display->get_row($i);    # by row.
            print $q->Tr;
            for (my $j = 0; $j <= $#row; $j++) {
               my $td;
               if (! defined($row[$j])) {
                  $row[$j] = "";
               }
               if (ref($row[$j]) eq "Formatted_text") { # if a row element
                  $td = $row[$j]->text;     # contains formatted
                  my $href = $row[$j]->href;      # text, then deal with
                  $href = $q->self_url if ($href eq "."); # it appropriately.
                  if ($href ne "") {
                     my $href_parm_count = $row[$j]->href_parm_count;
                     if ($href_parm_count >= 0) {
                        $href .= "\?";
                        for (my $p = 0; $p <= $href_parm_count; $p++) {
                           my $key;
                           my $value;
                           ($key, $value) = $row[$j]->get_href_parm($p);
                           $href .= "$key=$value";
                           $href .= "\&" if ($p < $href_parm_count);
                        }
                     }
                     $td = $q->a({href=>$href},$td)
                  }
                  if ($row[$j]->bold) {
                     $td = $q->b($td);
                  }
               }
               else {
                  $td = $row[$j];
               }
               $td = "&nbsp;" if ($td eq "");
               print $q->td([$td]);
            } 
          }        

       }else{
        print "<tr>
                    <th class='gris' colspan='7'>NO HAY IPs EST&aacute;TICAS</th>
                  </tr>";

       }

    } 
   ######################################

  
    if ($parm_count >= 0) {  
       print "<tr>
                <th class='gris' colspan='7'>DATOS DE LAS IPs DIN&aacute;MICAs</th>
              </tr>";

   }else{
          print "<tr>
                    <th class='gris' colspan='9'>DATOS DE LAS REDES CON DHCP</th>
                  </tr>";

   }   

   my @headings = $display->headings; 

   my $row_count = $display->row_count; 
   print $q->Tr([th([@headings])]);    
   for (my $i = 0; $i <= $row_count; $i++) {	# print the tabular info row
      my @row = $display->get_row($i);		# by row.
      print $q->Tr;
      for (my $j = 0; $j <= $#row; $j++) {
         my $td;
         if (! defined($row[$j])) {
            $row[$j] = "";
         }
         if (ref($row[$j]) eq "Formatted_text") {	# if a row element
            $td = $row[$j]->text;			# contains formatted
            my $href = $row[$j]->href;			# text, then deal with
            $href = $q->self_url if ($href eq ".");	# it appropriately.
            if ($href ne "") {
               my $href_parm_count = $row[$j]->href_parm_count;
               if ($href_parm_count >= 0) {
                  $href .= "\?";
                  for (my $p = 0; $p <= $href_parm_count; $p++) {
                     my $key;
                     my $value;
                     ($key, $value) = $row[$j]->get_href_parm($p);
                     $href .= "$key=$value";
                     $href .= "\&" if ($p < $href_parm_count);
                  }
               }
               $td = $q->a({href=>$href},$td)
            }
            if ($row[$j]->bold) {
               $td = $q->b($td);
            }
         }
         else {
            $td = $row[$j];
         }
         $td = "&nbsp;" if ($td eq "");
         print $q->td([$td]);
      }    
      if ($#row == 7){
        $usadas = 0;
        $libres = 100;
        if ($row[5]!=0){
          $regla3 =  $row[6]*100;
          $usadas = $regla3/$row[5];
          $libres = 100-$usadas;
        }          
        print '<td><div style="float:left;width:'.$usadas.'%;background-color:#FF0000;color:#FF0000">-</div><div style="float:left;width:'.$libres.'%;background-color:#2E64FE;color:#2E64FE">-</div></td>';
      }  

   }
   print $q->end_table;   
   print $q->end_html;
}

1;
