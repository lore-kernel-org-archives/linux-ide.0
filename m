From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive
 0x0) r0xj0
Date: Wed, 03 Jan 2007 13:15:38 +0900
Message-ID: <459B2DEA.8080202@gmail.com>
References: <f4527be0612271812p7282de31j98462aebde16e5a1@mail.gmail.com> <45933A53.1090702@gmail.com> <loom.20070103T020347-255@post.gmane.org> <459B140C.1060401@gmail.com> <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.234]:30315 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbXACEP4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 23:15:56 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6298847wxd
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 20:15:55 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701030334460.12309@dolores.legate.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbee <bumble.bee@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

bbee wrote:
>> Yeap, I have major issues with SDB FISes which contains spurious
>> completions but most other spurious interrupts shouldn't be dangerous
>> and I haven't seen spurious completions for quite some time, so I was
>> thinking either removing the message or printing it only on SDB FIS
>> containing spurious completions.
>>
>> But, Andrew Lyon *is* reporting spurious completions.  Now I just wanna
>> update those printks such that more info is reported only on spurious
>> SDB FISes.
> 
> That would certainly help verify that I'm having the exact same problem,
> since Andrew didn't say anything about his drive going offline.

Okay.

[--snip--]
> I reverted the patch and am waiting for the exception while running
> "stress --io 2 --hdd 2". By past experience, it could take a while; I am
> already seeing the spurious iterrupt messages though.

Thanks, please keep me posted.

>> Can you post the results of 'dmesg' and 'hdparm -I /dev/sdX'?
> 
> Follows at end of message (md init snipped from dmesg for brevity).
> 
>> Yeap, I'm definitely interested in resolving this problem.  It's not
>> likely but possible that the *controller* is responsible for spurious
>> interrupts.
> 
> Unfortunately I don't have any other model of SATA drive to test it
> with, but Andrew by his dmesg seems to be using a different brand of drive.
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7, max UDMA/100, 586072368 sectors: LBA48 NCQ (depth 31/32)
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: configured for UDMA/100
> scsi 0:0:0:0: Direct-Access     ATA      Maxtor 6V300F0   VA11 PQ: 0
> ANSI: 5

Yeah, a different drive.  I'll ask around.  Thanks.

-- 
tejun
