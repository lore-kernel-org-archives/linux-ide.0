From: Douglas Gilbert <dougg@torque.net>
Subject: Re: libata transfer mode & FUA & mode sense page
Date: Fri, 18 Nov 2005 10:33:57 +1000
Message-ID: <437D2175.5050600@torque.net>
References: <437B649C.5080708@gmail.com>
Reply-To: dougg@torque.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zorg.st.net.au ([203.16.233.9]:21645 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1750770AbVKRAcz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Nov 2005 19:32:55 -0500
In-Reply-To: <437B649C.5080708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jens Axboe <axboe@suse.de>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, Jeff, Douglas and Jens.
> 
> I've been trying to port the ordered reimplementation patchset over to
> post-2.6.15 head of blk tree.  This tree now contains PIO and mode sense
> improvements for libata.
> 
> ATA FUA is interesting in that it's supported only for multisector PIO
> and DMA protocols.  There is no ATA_CMD_PIO_WRITE_FUA_EXT.  So, when
> generating mode sense page, the status of FUA supported bit is dependent
> on the configured transfer mode.  As there doesn't seem to be dynamic
> transfer mode configuration yet, I'm thinking of simply passing ap or
> device down to mode sense functions and use it to report FUA status. How
> does that sound?
> 
> If dynamic transport configuration is implemented in the future (from EH
> or explicit user input), this FUA bit will go on and off depending on
> transfer mode.  Ugh... It seems that we'll need a way to raise UA for
> configuration change and trigger revalidation of SCSI disk device.

Tejun,
The DPOFUA bit in the mode sense response header only
indicates capability and cannot be changed via a
MODE SELECT command. Individual READ and WRITE SCSI
commands (other than the 6 byte variants) have individual
FUA and DPO (disable page out) bits. Further, I have
asked for clarification as SBC and SAT say the the
DPOFUA bit implies that both the DPO _and_ FUA bits
are supported but the DPO bit is unspecified in sat-r07.

If the DPOFUA bit changes "on the fly" then a UA with
asc/ascq=0x3f/0x0 ["Target operating conditions have
changed"] may be appropriate (or 0x3f/0x2). The linux
scsi mid level (and sd driver) treat UAs as a nuisance
but this may need to change.

It seems that asynchronous notifications at the command
level are being deprecated across all t10 command sets
in favour of REQUEST SENSE polling and/or deferred
errors. There are still asynchronous notifications
around (SAS just added a few) but they are being
relegated to the transport level.

Doug Gilbert


