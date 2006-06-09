From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 9 Jun 2006 12:47:59 +0200 (CEST)
Message-ID: <20060609104759.26001.qmail@web26913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:61081 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932310AbWFIKsA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 06:48:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jeff@garzik.org

Jeff Garzik wrote:
> libata should -- like drivers/ide -- call the ATA "set max" command t=
o=20
> fully address the hard drive, including the special "host-protected=20
> area" (HPA).  We should do this because the Linux standard is to expo=
rt=20
> the raw hardware directly, making 100% of the hardware capability=20
> available to the user (and, in this case, Linux-based BIOS and recove=
ry=20
> tools).
> .....
> Comments?  Questions?  Am I completely insane?  ;-)

  Your hard disk is a lot more powerfull than what you think, only very=
 old
 hard disks only have ATA set max command. Nowadays, you can not only s=
et the
 maximum size of the hard disk by HPA, but you can also protect the cha=
nge of
 the HPA by password and even freeze the HPA (i.e. unmodifiable without=
 power
 cycle).
  Changing the accessible size of the disk using the HPA is relatively =
safe
 because the disk is still reporting it complete size, so the BIOS and =
Linux
 do not have disks changing their size during use.

  You can also read and write the configuration of the hard disk, and s=
o hide
 the fact that your hard disk has the HPA feature, change the real size=
 of
 the hard disk (so hide the end, and none of Linux or the BIOS will kno=
w the
 hidden part) independantly of the HPA, make the HPA area appear as a c=
omplete
 hard disk by offseting the LBA (for a safety recovery), manage the noi=
se
 level and protect the content of the disk by password.

  All this is documented in the ATA specification, available for free a=
t least
 at http://www.t13.org/. If you want a (GPL only) source code showing h=
ow to
 use it, have a look at the Gujin bootloader at http://gujin.org : in t=
he way
 I am using it, the bootloader installs itself into an HPA and keep a c=
opy of
 the current MBR in the HPA so is nearly indestructible, if the MBR is
 overwritten another floppy or CDROM booting with Gujin will propose to=
 restore
 the MBR. You may want to run a DOS floppy, run the gujin provided dbgd=
isk.exe,
 go to the setup menu and enable IDE probing, go back to the kernel sel=
ection,
 and exit the dbgdisk.exe software by ^C. Then, have a look at the "A:\=
DBG" file
 created to see what your hard disk is reporting.
 Gujin can also install in a partition if there is no unused space afte=
r your
 extended partition at the end of the disk to create a HPA.

 Gujin also do the absolutely needed setup of the IDE hard disk which i=
s to freeze
 the password system _and_ the config system of all the IDE hard disks =
present, so
 that no virus can put a random password and send you an E-mail with th=
e address
 where to send the money to get the password to unlock the hard disk an=
d so access
 again your data. Again, freezing means no more modifiable until next p=
ower cycle,
 so IMO it is the job of the bootloader to setup the hard disk, before =
running
 anything like Linux, a commercial OS, a bootable CDROM...

 Gujin is assuming that your hard disk are accessible by the documented=
 ATA ide
 system, and some (or all?) IDE SATA interface have (volumtary?) broken
 implementation: they are not IDE register compatible.
 If you buy broken hardware, Gujin will not help you and cannot take ca=
re of the
 details for you - it is another win{modem,video,sensor} device.

 Etienne.

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection p=
ossible contre les messages non sollicit=E9s=20
http://mail.yahoo.fr Yahoo! Mail=20
