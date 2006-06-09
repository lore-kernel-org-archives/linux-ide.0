From: Tejun Heo <htejun@gmail.com>
Subject: Re: Seagate SATA 3GB/s drive connected to via vt8251 using ahci module
Date: Fri, 09 Jun 2006 14:44:42 +0900
Message-ID: <44890ACA.5070504@gmail.com>
References: <1149787827.4180.8.camel@anja>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:54394 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965217AbWFIFos (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 01:44:48 -0400
Received: by py-out-1112.google.com with SMTP id c39so733845pyd
        for <linux-ide@vger.kernel.org>; Thu, 08 Jun 2006 22:44:47 -0700 (PDT)
In-Reply-To: <1149787827.4180.8.camel@anja>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: aalderd.boac@wanadoo.nl
Cc: linux-ide@vger.kernel.org

Hello, Aalderd.

Aalderd Bouwman wrote:
> Hello,
> 
> I am running Gentoo Linux on a Asus A8V-MX mainboard with the Via VT8251
> southbridge chipset. The sata-controller is configured as AHCI.
> Bios version is 0210.
> 
> The drive is working properly with the drivers of VIA.
> 
> A Maxtor drive works correct on this controller but this seagate drive
> (ST3808110AS) fails on both modes (1.5Gb/s or 3.0Gb/s).
> 
> Here you can find the log-results after doing some actions on this
> drive. After the sector errors the drive could not be accessed by fdisk.
> 
> # uname -a
> Linux server 2.6.17-rc5-mm2 #2 Wed Jun 7 22:18:57 CEST 2006 i686 AMD
> Opteron(tm) Processor 144 AuthenticAMD GNU/Linux
> 
> Kernel log:
[--snip--]
> Jun  8 18:52:19 server ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x2)

One spurious interrupt here and then device reports error after ~20 secs 
which triggers libata to read log page 10h.

> Jun  8 18:53:09 server ata1.00: qc timeout (cmd 0x2f)
> Jun  8 18:53:09 server ata1: failed to read log page 10h (errno=-5)

Which timed out here.

> Jun  8 18:53:09 server ata1.00: exception Emask 0x1 SAct 0x7fffffff SErr 0x0 action 0x2 frozen
> Jun  8 18:53:09 server ata1.00: (irq_stat 0x40000000)
> Jun  8 18:53:09 server ata1.00: tag 0 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
[--snip--]
> Jun  8 18:53:09 server ata1.00: tag 30 cmd 0x61 Emask 0x1 stat 0x41 err 0x4 (device error)
> Jun  8 18:53:09 server ata1: soft resetting port
> Jun  8 18:53:09 server ata1: softreset failed (1st FIS failed)
> Jun  8 18:53:09 server ata1: softreset failed, retrying in 5 secs
> 
> Jun  8 18:53:14 server ata1: hard resetting port
> Jun  8 18:53:22 server ata1: port is slow to respond, please be patient
> Jun  8 18:53:45 server ata1: port failed to respond (30 secs)
> Jun  8 18:53:45 server ata1: COMRESET failed (device not ready)
> Jun  8 18:53:45 server ata1: hardreset failed, retrying in 5 secs
> Jun  8 18:53:50 server ata1: hard resetting port
> Jun  8 18:53:57 server ata1: port is slow to respond, please be patient
> 
> Jun  8 18:54:20 server ata1: port failed to respond (30 secs)
> Jun  8 18:54:20 server ata1: COMRESET failed (device not ready)
> Jun  8 18:54:20 server ata1: reset failed, giving up
> Jun  8 18:54:20 server ata1.00: disabled
> Jun  8 18:54:20 server ata1: EH complete

And the drive and/or port is completely deaf.

Can you please unplug power to the drive and replug it while EH is in 
progress, umm.. say during the first hardreset?

-- 
tejun
