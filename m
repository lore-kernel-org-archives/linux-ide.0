From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 17:22:36 +0900
Message-ID: <485F5D4C.90609@kernel.org>
References: <20080617093602.GA28140@elf.ucw.cz> <485EF061.3010601@kernel.org> <20080623082055.GB1850@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54408 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbYFWIXs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jun 2008 04:23:48 -0400
In-Reply-To: <20080623082055.GB1850@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>

Pavel Machek wrote:
> Hi!
> 
>>> I see strange problems on machine with sata_svw. The machine seems to
>>> corrupt data every few days (ext3 error, dir index corrupted), and has
>>> some other very strange problems (keyboard misbehaves, pulling out
>>> SATA disk cures it, see
>>> https://bugzilla.novell.com/show_bug.cgi?id=400772 ).
>>>
>>> Then I got to the comment 
>>>
>>>         writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
>>>         /* There is a race condition in certain SATA controllers
>>> that can be seen when the r/w command is given to the controller
>>> before the host DMA is started. On a Read command, the controller
> ...
>>> ...and that would certainly explain what we are seeing. Are
>>> serverworks controllers broken by design?
>> The comment looks like a warning to me as the DMA engine is started
>> before the command is issued to the drive as explained in the next
>> comment.
> 
> Ok, what about this?
> 
> ---
> 
> Clarify data corruption comment.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
