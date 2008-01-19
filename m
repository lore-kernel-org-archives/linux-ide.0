From: rgheck <rgheck@bobjweil.com>
Subject: Re: SATA timeouts on two disks
Date: Sat, 19 Jan 2008 11:50:11 -0500
Message-ID: <47922A43.5080409@bobjweil.com>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>	 <18313.65287.290482.369023@harpo.it.uu.se> <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:49446
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754590AbYASQuN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 11:50:13 -0500
In-Reply-To: <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jim MacBaine <jmacbaine@gmail.com>, Mikael Pettersson <mikpe@it.uu.se>

Jim MacBaine wrote:
> On Jan 13, 2008 1:07 PM, Mikael Pettersson <mikpe@it.uu.se> wrote
>> The fact that the problems occur on different disks on
>> different controllers driven by different drivers indicates
>> that it's not a disk, controller, or driver problem.
>>
>> I strongly suspect an underdimensioned or failing PSU.
>>     
> Thanks a lot for your clues.
>
> I bought a new PSU on Monday and didn't get any new disk failures for
> days.  But last night the same time-outs occurred again on two disks.
> I guess I will try to replace the motherboard including the two SATA
> controllers next.
>   
I don't know if your problems are similar to mine or not. But I have 
been having extensive problems for quite some time now. Do you get these 
timeouts when using optical drives? That's what seems to trigger it in 
my case: If I'm using the optical drives, I'll often see the errors with 
them first, and then the whole ATA subsystem seems to go down. Then I 
get journal commit errors, general read errors, etc, until the system 
basically locks up. Worst case, it all happens very suddenly, and 
there's not even anything in the logs. Just a couple messages to the 
terminal, usually a journal commit error.

In my case, the opticall drives are a brand new Pioneer DVD-RW on SATA 
and an old Plextor on PATA. I mostly see the errors with the latter but 
have also seen them with the former. I'd thought I'd fixed it by adding 
pnpacpi=off and pci=nomsi,nommconf to the kernel boot options, as well 
as libata noacpi=1 to modules.conf, but now I've just had the problem 
again. I'm now thinking I should try eliminating the Plextor drive. It 
may be that it's the PATA drive that is causing all the trouble. I'll 
report if so.

FYI, here are the relevant modules being loaded:
[root@rghquad rgheck]# lsmod | grep ata
pata_amd               20293  0
pata_pdc2027x          17477  0
sata_nv                25157  8
ata_generic            14405  0
libata                114673  4 pata_amd,pata_pdc2027x,sata_nv,ata_generic
scsi_mod              145657  5 sr_mod,sg,usb_storage,libata,sd_mod
The IDE interface is an nVidia MCP55, apparently, on an ASUS P5N32-E mb.

I doubt very much it's a PS issue in my case. There's not that much in 
the box.

Richard

