From: "Steven Haigh" <netwiz@crc.id.au>
Subject: Adaptec 1210SA raid issues.
Date: Sat, 14 Aug 2004 01:45:00 +1000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <002201c4814c$7e1ace00$128b8ecb@enigma>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw.crc.id.au ([203.142.139.230]:8064 "EHLO zeus.crc.id.au")
	by vger.kernel.org with ESMTP id S266004AbUHMPpS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Aug 2004 11:45:18 -0400
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi all,

Firstly I'm sorry if this has been asked before - I've had a quick skim 
through the archives but with no joy.

I'm just moving away from the Adaptec drivers for the 1210SA SATA RAID 
adapter (urgh at being locked into kernel 2.4.20!) to the sata_sil driver - 
and am having much more luck that I have a few months ago when I tried...

It see's the two drives:

[netwiz@zeus netwiz]$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 6Y160M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05

It sees the correct partition size (via fdisk)
Disk /dev/sda: 163.9 GB, 163928604672 bytes
255 heads, 63 sectors/track, 19929 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1     39859 320167386   83  Linux

But I can't mount /dev/sda1... My guessing is that as it's seeing two 
drives, they're not being combined into one volume - however I could be 
completely off base here. Is there something else I need to do?

Thanks in advance,
Steven Haigh

