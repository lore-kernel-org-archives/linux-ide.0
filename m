From: Tejun <htejun@gmail.com>
Subject: Re: libata transfer mode & FUA & mode sense page
Date: Wed, 23 Nov 2005 17:25:46 +0900
Message-ID: <4384278A.5080703@gmail.com>
References: <437B649C.5080708@gmail.com> <437D2175.5050600@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:39153 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030363AbVKWI0D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Nov 2005 03:26:03 -0500
Received: by zproxy.gmail.com with SMTP id 14so227145nzn
        for <linux-ide@vger.kernel.org>; Wed, 23 Nov 2005 00:26:03 -0800 (PST)
In-Reply-To: <437D2175.5050600@torque.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dougg@torque.net
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>

Hi, Douglas.

Douglas Gilbert wrote:
> Tejun Heo wrote:
> 
>>Hello, Jeff, Douglas and Jens.
>>
>>I've been trying to port the ordered reimplementation patchset over to
>>post-2.6.15 head of blk tree.  This tree now contains PIO and mode sense
>>improvements for libata.
>>
>>ATA FUA is interesting in that it's supported only for multisector PIO
>>and DMA protocols.  There is no ATA_CMD_PIO_WRITE_FUA_EXT.  So, when
>>generating mode sense page, the status of FUA supported bit is dependent
>>on the configured transfer mode.  As there doesn't seem to be dynamic
>>transfer mode configuration yet, I'm thinking of simply passing ap or
>>device down to mode sense functions and use it to report FUA status. How
>>does that sound?
>>
>>If dynamic transport configuration is implemented in the future (from EH
>>or explicit user input), this FUA bit will go on and off depending on
>>transfer mode.  Ugh... It seems that we'll need a way to raise UA for
>>configuration change and trigger revalidation of SCSI disk device.
> 
> 
> Tejun,
> The DPOFUA bit in the mode sense response header only
> indicates capability and cannot be changed via a
> MODE SELECT command.

ATA devices may or may not support FUA depending on what protocol it 
uses to execute commands.  e.g. While using multisector PIO, in which 
mode ATA devices support FUA, if the user or EH decides to switch to 
singlesector PIO, the DPOFUA should be turned off as the device cannot 
execute FUA commands anymore.

This currently doesn't happen and even when advanced EH is implemented, 
the probability of this happening will be very low and the benefits of 
impelmenting all those might not justify the complexity....  I don't 
know.  I was just making note of the possibility.

> Individual READ and WRITE SCSI
> commands (other than the 6 byte variants) have individual
> FUA and DPO (disable page out) bits. Further, I have
> asked for clarification as SBC and SAT say the the
> DPOFUA bit implies that both the DPO _and_ FUA bits
> are supported but the DPO bit is unspecified in sat-r07.

ATA currently doesn't seem to have the facility matching DPO.  As 
ignoring DPO doesn't cause any correctness problem, I think the current 
implementation is okay for the time being until SAT comes up with 
something concrete.

> If the DPOFUA bit changes "on the fly" then a UA with
> asc/ascq=0x3f/0x0 ["Target operating conditions have
> changed"] may be appropriate (or 0x3f/0x2). The linux
> scsi mid level (and sd driver) treat UAs as a nuisance
> but this may need to change.
> 
> It seems that asynchronous notifications at the command
> level are being deprecated across all t10 command sets
> in favour of REQUEST SENSE polling and/or deferred
> errors. There are still asynchronous notifications
> around (SAS just added a few) but they are being
> relegated to the transport level.

Hmmm... So we ever get to implement this dynamic turning on/off of 
DPOFUA, we should do it by deferred errors.

Thanks a lot for the info.

-- 
tejun
