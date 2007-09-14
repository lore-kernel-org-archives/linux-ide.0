From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: HSM violation on bootup,
	ICH7 + ata_piix 2.6.22
Date: Fri, 14 Sep 2007 08:56:56 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0709140853350.24438@trinity.phys.uwm.edu>
References: <46E254D7.5020902@gmail.com>
	<1189414783.13360.16.camel@ukabzc383.uk.saic.com>
	<46E998F2.8070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <46E998F2.8070301@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
To: Tejun Heo <htejun@gmail.com>
Cc: Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org, Douglas Gilbert <dougg@torque.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>, Bruce Allen <bruce.allen@aei.mpg.de>
List-Id: linux-ide@vger.kernel.org

Tejun: thanks for the CC.  I'm clueless about what is at fault here.

Eamonn: could you please build the latest version of smartmontools from 
CVS HEAD source and see if the problem exists in that version?  Then write 
back.  I don't think this will help but want to eliminate obvious things.

Cheers,
 	Bruce


On Thu, 13 Sep 2007, Tejun Heo wrote:

> Eamonn Hamilton wrote:
>> Thanks for that, I checked the disks and sure enough they were in an
>> extended self test, I aborted that and it's all back to normal.
>>
>> the only problem, however, is that the system is already running version
>> 5.37 of the smartmontools package, which is the most recent as I
>> understand it? I don't really want to leave the system with it's disks
>> unmonitored, is there anything I can be doing to prevent this behaviour?
>
> Hmmm... That gotta be a different issue then.  Cc'ing Bruce and quoting
> the original report.
>
> Eamonn Hamilton wrote:
>>> Hi,
>>>
>>> I'm looking ta a Dell SC440 system for a friend, and it's giving HSM
>>> violations at startup.
>>>
>>> The system itself has an ICH7 chipset, with two seagate ST3160812AS
>>> drives attached along with a single ST3400832AS, running kernel 2.6.22
>>> and the ata_piix driver.
>>>
>>> I'm guessing this isn't good  :(
>>>
>>> Anybody gt any suggestions?
>>>
>>> The violations are :
>>>
>>>
>>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
>>> ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
>>> 123392 in
>>>          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
>>> violation)
>
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
