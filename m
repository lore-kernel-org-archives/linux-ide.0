From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: siimage and two nics
Date: Fri, 26 Dec 2003 05:42:20 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FEBCA3C.5000803@clanhk.org>
References: <20031226085450.A4045@nettis.grimsta> <34449.209.163.161.49.1072444479.squirrel@mail.clanhk.org> <20031226195705.B4045@nettis.grimsta> <3FEBAFA5.8020604@clanhk.org> <20031226232826.A7057@nettis.grimsta>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palace.clanhk.org ([64.5.48.96]:23204 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265272AbTLZXrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Dec 2003 18:47:11 -0500
In-Reply-To: <20031226232826.A7057@nettis.grimsta>
List-Id: linux-ide@vger.kernel.org
To: Daniel Brahneborg <basic@wtnord.net>
Cc: Daniel Brahneborg <daniel.com@wtnord.net>, linux-ide@vger.kernel.org

Daniel Brahneborg wrote:

>I guess I could, I just needed something to install to.
>It's a file server, so it's the SATA disks that will take
>the biggest hit.
>  
>
You should put your busiest disks on the southbridge (via_sata).

>I wouldn't mind using something else, but then I must first
>understand how to get it to stop messing with my PATA hda.
>Would that driver make the SATA disk suddenly appear as IDE
>disks instead of SCSI?
>  
>
I don't understand why that matters.

>Checking... oh, it's 1.06 in Linus 2.4.23 kernel.  The diff
>doesn't seem to be very much, just a check for 3114 and a fix
>for Seagate drives.
>  
>
Have you considered 2.6?  It's looking pretty stable with great hardware 
support.  I'm putting 2.6.0-mm1 on a production server using a RAID1 
setup over the SI3112.  There's also this patch: 
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/ide-siimage-stack-fix.patch 
which I have found to be vital for stable operation.  If you read back 
on the archives I included a diff for 2.4.23_pre8

> scsi3 : sata_via
>
>  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 0.81
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
>Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
>Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
> sda: sda1 sda2
>SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
> sdb: sdb1 sdb2
>SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
> sdc: sdc1 sdc2
>SCSI device sdd: 312581808 512-byte hdwr sectors (160042 MB)
> sdd: sdd1 sdd2
>  
>

OK.  So you have a 4 160GB SATA drives that show up as sda-sdd using 
libata.  That's cool.  I had problems with the sata_sil driver though, 
it wasn't stable for me.  I'd suggest using the IDE driver until it's 
been worked on more.  It's alpha right now, but the IDE driver is 
production ready by my testing anyway.  You just have to modify your 
raidtab to account for the new device location (hda/hdc or hde/hdg) of 
using the IDE driver.

-ryan



