From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: SATA intel High loads due to writes vs ata_piix switch
Date: Thu, 17 May 2007 12:50:11 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7033AB60A@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
References: <8E8F647D7835334B985D069AE964A4F7028FE7F0@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <20070516214236.08dd02c9@the-village.bc.nu> <8E8F647D7835334B985D069AE964A4F7033AB605@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:53651 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755809AbXEQQud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 12:50:33 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux IDE <linux-ide@vger.kernel.org>

> -----Message d'origine-----
> De : linux-ide-owner@vger.kernel.org 
> [mailto:linux-ide-owner@vger.kernel.org] De la part de 
> Fortier,Vincent [Montreal]
> 
> > -----Message d'origine-----
> > De : Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > 
> > > I made a fwe tests to try to point out when high loads happens 
> > > (which are not really scientific :).  Note that between each tests
I 
> > > made sure the load average got back below 0.15.
> > > 
> > > But first, here are my 2 questions:
> > > 1- Should I really expect loads that high using that driver?
> > 
> > Remember that uptime type load also measure system wait so high disk

> > I/O counts as load but not CPU usage. High CPU usage shouldn't be a 
> > problem for any DMA based disk
> > 
> > With the newer ICH controllers and especially if your disk does NCQ 
> > you should see better performance with libata as the libata drivers 
> > support AHCI and NCQ which allows multiple outstanding commands.
> 
> Maybie I should have explain that, I found this problem while 
> trying to compile a single kernel with -j1 or -j2 on this 
> dual core CPU and it made the load average climb to at least 
> 10.  Doing more testing revealed that most writes to disks 
> made the load average climb seriously (Just dragging 
> 400-500mb of MP3 made the load climb really heavilly making 
> my system unresponsive)...  Actually, just uncompressing 
> kernel sources makes my system unresponsive and that is not a 
> heavy task?
> 
> However on my AMD 4200+ system at home with libata driver on 
> a nforce chipset I can compile 5 kernels at once using -j4 
> for each compilation and I get a load of around 10-12 and 
> that is, I believe, a normal behaviour.
> 
> This is why I believe that there is a bug in the E-IDE driver 
> and that switching to libata would greatly improve performances.
>  
> > > "Multi-Platform E-IDE driver Revision: 7.00alpha2" and detected
both 
> > > my hd & dvdrw as scsi devices BUT finally ended up in a oops:
> > > pivot_root: No such file or directory
> > > /sbin/init: 432: Cannot open dev/console: No such file Kernel
panic 
> > > - not syncing: Attempted to kill init
> > 
> > Thats really for the Debian lists, it sounds as if Debian still
isn't 
> > using disk labels in the initrd.
> 
> Yeah, I'll try to dig some more info on this.  I tought it 
> would have been easier switching from one to the other... :(

I've found what I was missing... As usual it wasn't much... It only was
missing the proper loading of "sd_mod" module so that probed disk gets
an assign device file.

Here is my "howto for Debian Sarge 3.1" for any of you interested:
1- Added the "sd_mod" and "ata_piix" module to /etc/mkinitrd/modules
2- Recreated the appropriate initrd (In this case: mkinitrd -o
/boot/initrd.img-2.6.20.10-cfs-sarge-686-envcan
2.6.20.10-cfs-sarge-686-envcan)
3- Updated the /etc/fstab to switch from hda to sda
4- Updated the /boot/grub/device.map to -> (hd0)   /dev/sda  (instead
of: (hd0)   /dev/hda)
5- Updated the grub mmenu.lst to switch hda to sda like: kernel
/vmlinuz-2.6.20.10-cfs-sarge-686-envcan root=/dev/sda2 ro vga=0x305
6- Booted properly!

 
> > > TEST 2: 10000 1mb files (medium size files):
> > > Note that I stopped the test a the 4134th file)
> > > -----------------------------------------------
> > > Max load average (a simple while loop + sleep 5 + cat
/proc/loadavg)
> > > 16.36 12.64 7.86 2/122 3602
> > 
> > If you are doing all the I/O in parallel then that isn't unexpected
- 
> > disk performance is very very seek dependant snd a lot of parallel
I/O 
> > will cause a lot of seeking. If they are occuring in serial then
this 
> > is a bit odd and would warrant more investigating. I don't however 
> > think this is likely to be a disk layer problem so I doubt libata v 
> > oldIDE makes that much difference here - a bit because of NCQ but
not 
> > a lot.
> 
> This was serial testing (wich makes this odd):
> 
> while [ $i -lt $MAX ]
> do
>    declare TMP_FILE=`mktemp ${TEST_DIR}/${i}.XXXXXX` || exit 1
>    dd if=/dev/zero of=${TMP_FILE} bs=${BS} count=${COUNT} 2>/dev/null
>    let i++
> done

BTW, here is the hdparm using the old driver:
> 
> > Alan
> > 
> 
> Thnx for answering!
> 
> - vin
