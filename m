From: Uplink <advantis@gmx.net>
Subject: drive appears confused (ireason = 0x01)
Date: Sun, 02 Oct 2005 02:56:57 +0300
Message-ID: <433F2249.30707@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:47260 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750909AbVJAX5D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Oct 2005 19:57:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

This may concern you in part. Parts that you feel that don't concern 
IDE, please forward to the ones responsible.

Since kernel 2.6.13 I get a "cdrom_pc_intr: The drive appears confused 
(ireason = 0x01)" message when trying to access the DVD drive and I 
can't read any disks.

I just booted 2.6.14-rc3 and I still get it. I also get some weird 
things in syslog:

Oct  1 23:45:24 dcerouter kernel: hda: cde appears confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdroe appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdroe appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdre appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: The e appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: Te appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr:e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr:e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intre appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr:e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda:e appears confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: The appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdre appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cde appears confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdre appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdroe appears confused (ireason = 
0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_e appears confused (ireason 
= 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_inte appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: The appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: The appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: Te appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: Thee appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr: Te appears 
confused (ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_intr:e appears confused 
(ireason = 0x01)
Oct  1 23:45:24 dcerouter kernel: hda: cdrom_pc_inte appears confused 
(ireason = 0x01)

