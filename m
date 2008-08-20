From: Tejun Heo <tj@kernel.org>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Wed, 20 Aug 2008 16:39:04 +0900
Message-ID: <48ABCA18.6060800@kernel.org>
References: <48A35FE6.1080903@tlinx.org> <20080814115005.1495a0b1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60992 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688AbYHTHkJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 03:40:09 -0400
In-Reply-To: <20080814115005.1495a0b1@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> 13 10:12:20 kern: res ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x12 
>> (ATA bus error)
> 
> Splat
> 
>> 13 10:12:20 kern: ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x19 0002 
>> action 0xa frozen
>> 13 10:12:20 kern: ata4.00: hotplug_status 0x4
>> 13 10:12:20 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar }
> 
> SATA link dies
> 
>> 13 10:13:25 kern: ata4: limiting SATA link speed to 1.5 Gbps
> 
> We try 1.5GBit
> 
>> 13 10:14:30 kern: ata4: SError: { RecovComm PHYRdyChg 10B8B Dispar DevExch }
>> 13 10:14:37 kern: ata4: port is slow to respond, please be patient 
>> (Status 0xff)
> 
> First guess would be a dud drive but it could be power or cabling or
> firmware or ...
> 
> In all the sane cases I would have expected it to recover, particularly
> if it was cabling.

Hmm... this could be either the drive or the controller.  After that
happens, can you please plug the power line off the drive, wait a few
tens of secs and plug in again and see whether the drive comes back?
Even if the drive was serving root fs, you should still be able to see
whether libata can converse with the device.  Just don't unplug and
replug while libata is still trying to recover the device.  Unwritten
data in the disk buffer will be lost when you unplug the power and
libata would think it was just transmission glitch and the fs will just
continue as if nothing happened which could result in massive filesystem
corruption.

-- 
tejun
