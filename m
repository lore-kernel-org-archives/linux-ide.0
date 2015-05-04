From: Jonathan Bagg <jbagg@lenbrook.com>
Subject: Re: imx6 sata cdrom driver issue
Date: Mon, 4 May 2015 12:15:02 -0400
Message-ID: <55479B06.7090006@lenbrook.com>
References: <5539101D.1020909@lenbrook.com> <15678294.L2fz4hMtva@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lenbrook.com ([206.191.95.214]:27961 "EHLO
	mail.lenbrook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbEDQPL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:15:11 -0400
In-Reply-To: <15678294.L2fz4hMtva@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org

On 15-04-24 03:58 AM, Arnd Bergmann wrote:
> On Thursday 23 April 2015 11:30:37 Jonathan Bagg wrote:
>> Spam Status: CRM114
>> On arm imx6, running mainline 3.19, mounting a SATA CDROM fails aprox
>> 1/20 times with this error....
>>
>> root@freescale /tmp$ mount /dev/sr0 test/
>> UDF-fs: warning (device sr0): udf_fill_super: No partition found (2)
>> mount: mounting /dev/sr0 on test/ failed: Invalid argument
>>
>> I've tried several disks and dvd drivers.  They all experience this
>> issue.  The same disks mount 100% of the time on an x86 machine.  Once
>> mounted, I can read data without issue.  Also tried a HDD on the same
>> SATA link, no issue.
>>
>> Sometimes the kernel will dump out the attached backtrace on the mount
>> command.
>>
> I think  you have a combination of two bugs:
>
> a) something that mount() does leads to the 'sd' device being unregistered
> b) something goes wrong in the cleanup of that device, which leads to
>     the messages you see.
>
> What is particularly strange here is the error about unregistering the
> /disk/ rather than the cdrom.
>
> Do you have two SATA ports on one controller, with the other one being
> conneced to a disk drive?
>
> My best guess is that something in the error handling of
> drivers/ata/ahci_imx.c causes a reset of the entire bus and that
> triggers the other bugs. Can you instrument that error handling to
> see what's going on?
>
> 	Arnd
How do I enable ATA error / debug messages?  I've tried adding

debug
ignore_loglevel
log_buf_len=10M

to my bootargs and confirmed they are added by checking /proc/cmdline?  
(I'm a userspace developer)

-- 
Jonathan Bagg
Embedded Systems Developer
NAD Electronics | Lenbrook Industries Limited
633 Granite Court, Pickering, Ontario, Canada L1W 3K1 | 905-831-0799 ext 4478 | http://www.nadelectronics.com

