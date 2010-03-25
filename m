From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: ata2.00: failed to set xfermode (err_mask=0x100),ata2.00: disabled,
 CD-ROM drive dead
Date: Thu, 25 Mar 2010 04:19:16 -0500
Message-ID: <4BAB2A94.8010001@hardwarefreak.com>
References: <4B9EA02F.2070704@hardwarefreak.com> <4B9EC67A.3020201@gmail.com> <4B9ED027.30800@hardwarefreak.com> <4BAAB080.3010401@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:42123 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0CYJTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 05:19:17 -0400
In-Reply-To: <4BAAB080.3010401@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo put forth on 3/24/2010 7:38 PM:
> Hello,
> 
> On 03/16/2010 09:26 AM, Stan Hoeppner wrote:
>> ata2.00: ATAPI: Pioneer CD-ROM ATAPI Model DR-A24X  0102, E1.02, max MWDMA2
>> ata2.00: failed to set xfermode (err_mask=0x100)
>> TCP cubic registered
>> NET: Registered protocol family 17
>> Using IPI Shortcut mode
>> rtc_cmos rtc_cmos: setting system clock to 2010-03-10 20:53:54 UTC (1268254434)
>> ata2.00: failed to set xfermode (err_mask=0x100)
>> ata2.00: limiting speed to MWDMA2:PIO3
>> ata2.00: failed to set xfermode (err_mask=0x100)
> 
> AC_ERR_OTHER on SETXFER, that's rare.  Maybe the drive needs
> ATA_HORKAGE_NOSETXFER?  Can you please post boot log with ide driver?

Hello Tejun,

Here is the relevant dmesg output for my kernel with the PIIX IDE driver:

Linux version 2.6.32.9 (root@greer) (gcc version 4.3.2 (Debian 4.3.2-1.1) )
#1 SMP Wed Mar 17 20:21:58 CDT 2010
...
Uniform Multi-Platform E-IDE driver
piix 0000:00:07.1: IDE controller (0x8086:0x7111 rev 0x01)
piix 0000:00:07.1: IDE port disabled
piix 0000:00:07.1: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf008-0xf00f
Probing IDE interface ide0...
hda: Pioneer CD-ROM ATAPI Model DR-A24X 0102, ATAPI CD/DVD-ROM drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: MWDMA2 mode selected
ide0 at 0x170-0x177,0x376 on irq 15
ide-cd driver 5.00
ide-cd: hda: ATAPI 20X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20

I must admit the CD-ROM drive is rather old, a late 90's model slot loading
Pioneer drive, but it works fine with the PIIX IDE driver.  If it is needed
for success under libata, where would I set ATA_HORKAGE_NOSETXFER?

I have no problem continuing to use the PIIX IDE driver, but I understand
all of the old IDE drivers are or will be deprecated in the not to distant
future.  This is why I tried to get the drive working under libata.

Thanks.

-- 
Stan
