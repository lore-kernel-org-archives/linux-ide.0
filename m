From: Tejun Heo <htejun@gmail.com>
Subject: Re: Kernel driver for Sil 3112 (sata_sil.c) problems
Date: Sat, 25 Feb 2006 21:25:43 +0900
Message-ID: <44004CC7.8040207@gmail.com>
References: <20060224194919.6B81F37B09@relay.netbox.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:18889 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932688AbWBYMZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Feb 2006 07:25:48 -0500
Received: by zproxy.gmail.com with SMTP id 16so581859nzp
        for <linux-ide@vger.kernel.org>; Sat, 25 Feb 2006 04:25:47 -0800 (PST)
In-Reply-To: <20060224194919.6B81F37B09@relay.netbox.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kacer <kacerxy@seznam.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

kacer wrote:
> Dear Jeff,
> sorry for disturbing you, but I tried nearly everything to get this SATA
> controller (Silicon Image Sil 3112) working, but it always crashes while
> writing data (few hundred MBs or few GBs). In dmesg I can see something like
> that:
> 
> end_request: I/O error, dev sdb, sector 459620760 
> Buffer I/O error on device dm-3, logical block 155125763 
> lost page write due to I/O error on dm-3 
> ATA: abnormal status 0xD8 on port 0xE08180C7 
> ATA: abnormal status 0xD8 on port 0xE08180C7 
> ATA: abnormal status 0xD8 on port 0xE08180C7 
> 
> ata2: command 0x35 timeout, stat 0x58 host_stat 0x0 
> ata2: status=0x58 { DriveReady SeekComplete DataRequest } 
> SCSI error : <1 0 0 0> return code = 0x8000002 
> sdb: Current: sense key=0xb 
>     ASC=0x47 ASCQ=0x0 
> end_request: I/O error, dev sdb, sector 459620744 
> Buffer I/O error on device dm-3, logical block 155125761 
> lost page write due to I/O error on dm-3 
> ATA: abnormal status 0x58 on port 0xE08180C7 
> ATA: abnormal status 0x58 on port 0xE08180C7 
> ATA: abnormal status 0x58 on port 0xE08180C7
> 
> And same problems with /dev/sda. In this moment system is locked and nearly
> not working, the only thing what I can do is HW reset...
> 
> I have Sil 3112 in Asus TUSL2-C (i815) motherboard, 2x256 MB RAM, there are
> 2 WD Raid Edition 400 GB drives on controller (2 of 4 ports used), BIOS of
> controller is 4.2.0, I tried several kernels from 2.6.12 up to 2.6.15.4.
> Nothing changed and I'm still getting same error messages. If you need some
> other additional info or cooperation, just write me, I'm feeling desperate,
> I don't know that to do to get that working. I tried to search the internet
> for some suggestions, but I was not able to fix the the problems.
> 

Hello, Jiri.

'lspci -n' please.

-- 
tejun
