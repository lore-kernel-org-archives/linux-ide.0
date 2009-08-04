From: Tejun Heo <tj@kernel.org>
Subject: Re: ahci sometimes fails to suspend controller
Date: Tue, 04 Aug 2009 16:02:52 +0900
Message-ID: <4A77DD1C.9010505@kernel.org>
References: <20090719220423.54e8c75d@uranus>	<4A683755.60909@kernel.org>	<20090727140612.27d176ca@pluto-lenny.milky.way>	<4A6E6774.6030909@kernel.org>	<C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com>	<20090728061033.56394c6e@pluto-lenny.milky.way>	<C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com>	<20090802190838.4a8bd3b8@pluto-lenny.milky.way>	<4A7629ED.4050103@kernel.org> <20090803103016.4305e098@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33511 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbZHDHDP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 03:03:15 -0400
In-Reply-To: <20090803103016.4305e098@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, rjw@suse.com

Hello, Benjamin.

Benjamin S. wrote:
>> Can you please attach full log?  I'm curious what exactly went down.
> 
> Sure. Do you think the system should still be able to resume although 
> the revalidation failed while suspending (see line [299208.016116])?

Interesting.  This is the first time I see it failing this way.

[--snip--]
> [299202.632167] ahci 0000:00:11.0: suspend
> [299203.016052] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [299208.016032] ata3.00: qc timeout (cmd 0xec)
> [299208.016078] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [299208.016116] ata3.00: revalidation failed (errno=-5)

This shouldn't have happened.  The kernel is visiting each device and
suspending it.  The process is ordered such that dependent devices
always go to sleep first.  For some reason, something bad happens to
the ATA controller while other parts of the system are going to sleep
and I don't think it's solely software given the problem happens only
after a lot of trials.

[--snip--]
> [299249.128051] ata2: SATA link down (SStatus 0 SControl 300)
> [299249.128117] ata4: SATA link down (SStatus 0 SControl 300)
> [299249.128183] ata1: SATA link down (SStatus 0 SControl 300)
> [299249.156033] sd 2:0:0:0: legacy resume
> [299249.156037] sd 2:0:0:0: [sda] Starting disk
> [299254.172018] ata3: link is slow to respond, please be patient (ready=0)
> [299255.964034] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

And it looks like the device could operate normally after resume.

The error messages are from SCSI layer which now realized that the ATA
device is gone.

>>> Does that mean the SATA MSI quirk won't solve my problem?
>> I think it's likely a different issue.  Can you please try to
>> reproduce the problem and see how many tries it usually takes?
> 
> This time it were 79 successful resumes and the 80th one did not
> succeed. 
> 
> Because I never shutdown my system I will reproduce it by force, 
> but I am going to try to script a little bit to automatically
> suspend and resume in order to get the next results faster.

Does irqpoll help?

cc'ing Rafael.  Rafael, is there any chance that we're suspending
things in the wrong order?

Thanks.

-- 
tejun
