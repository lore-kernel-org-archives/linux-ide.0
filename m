From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 09:37:53 +0900
Message-ID: <485EF061.3010601@kernel.org>
References: <20080617093602.GA28140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52292 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbYFWAiI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 20:38:08 -0400
In-Reply-To: <20080617093602.GA28140@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Pavel Machek wrote:
> I see strange problems on machine with sata_svw. The machine seems to
> corrupt data every few days (ext3 error, dir index corrupted), and has
> some other very strange problems (keyboard misbehaves, pulling out
> SATA disk cures it, see
> https://bugzilla.novell.com/show_bug.cgi?id=400772 ).
> 
> Then I got to the comment 
> 
>         writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
>         /* There is a race condition in certain SATA controllers
> that can be seen when the r/w command is given to the controller
> before the host DMA is started. On a Read command, the controller
> would initiate the command to the drive even before it sees the DMA
> start. When there are very fast drives connected to the controller,
> or when the data request hits in the drive cache, there is the
> possibility that the drive returns a part or all of the requested
> data to the controller before the DMA start is issued.  In this
> case, the controller would become confused as to what to do with the
> data.  In the worst case when all the data is returned back to the
> controller, the controller could hang. In other cases it could
> return partial data returning in data corruption. This problem has
> been seen in PPC systems and can also appear on an system with very
> fast disks, where the SATA controller is sitting behind a number of
> bridges, and hence there is significant latency between the r/w
> command and the start command. */
>         /* issue r/w command if the access is to ATA*/
>         if (qc->tf.protocol == ATA_PROT_DMA)
> 
> ...and that would certainly explain what we are seeing. Are
> serverworks controllers broken by design?

The comment looks like a warning to me as the DMA engine is started
before the command is issued to the drive as explained in the next
comment.

-- 
tejun
