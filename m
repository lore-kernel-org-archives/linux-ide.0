From: "Rafael J. Wysocki" <rjw@suse.com>
Subject: Re: ahci sometimes fails to suspend controller
Date: Tue, 4 Aug 2009 17:33:09 +0200
Message-ID: <200908041733.09707.rjw@suse.com>
References: <20090719220423.54e8c75d@uranus> <20090803103016.4305e098@pluto-lenny.milky.way> <4A77DD1C.9010505@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42445 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932839AbZHDPcM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 11:32:12 -0400
In-Reply-To: <4A77DD1C.9010505@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Benjamin S." <sbenni@gmx.de>, "Huang, Shane" <Shane.Huang@amd.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tuesday 04 August 2009, Tejun Heo wrote:
> Hello, Benjamin.
> 
> Benjamin S. wrote:
> >> Can you please attach full log?  I'm curious what exactly went down.
> > 
> > Sure. Do you think the system should still be able to resume although 
> > the revalidation failed while suspending (see line [299208.016116])?
> 
> Interesting.  This is the first time I see it failing this way.
> 
> [--snip--]
> > [299202.632167] ahci 0000:00:11.0: suspend
> > [299203.016052] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [299208.016032] ata3.00: qc timeout (cmd 0xec)
> > [299208.016078] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> > [299208.016116] ata3.00: revalidation failed (errno=-5)
> 
> This shouldn't have happened.  The kernel is visiting each device and
> suspending it.  The process is ordered such that dependent devices
> always go to sleep first.  For some reason, something bad happens to
> the ATA controller while other parts of the system are going to sleep
> and I don't think it's solely software given the problem happens only
> after a lot of trials.
> 
> [--snip--]
> > [299249.128051] ata2: SATA link down (SStatus 0 SControl 300)
> > [299249.128117] ata4: SATA link down (SStatus 0 SControl 300)
> > [299249.128183] ata1: SATA link down (SStatus 0 SControl 300)
> > [299249.156033] sd 2:0:0:0: legacy resume
> > [299249.156037] sd 2:0:0:0: [sda] Starting disk
> > [299254.172018] ata3: link is slow to respond, please be patient (ready=0)
> > [299255.964034] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> 
> And it looks like the device could operate normally after resume.
> 
> The error messages are from SCSI layer which now realized that the ATA
> device is gone.
> 
> >>> Does that mean the SATA MSI quirk won't solve my problem?
> >> I think it's likely a different issue.  Can you please try to
> >> reproduce the problem and see how many tries it usually takes?
> > 
> > This time it were 79 successful resumes and the 80th one did not
> > succeed. 
> > 
> > Because I never shutdown my system I will reproduce it by force, 
> > but I am going to try to script a little bit to automatically
> > suspend and resume in order to get the next results faster.
> 
> Does irqpoll help?
> 
> cc'ing Rafael.  Rafael, is there any chance that we're suspending
> things in the wrong order?

If the kernel is older than 2.6.30, that may be a manifestation of the issue
described in http://www.sisk.pl/kernel/LS/2009/pci_resume/ .

Unfortunately, the patches that fixed it and went into 2.6.29 and 2.6.30
caused some suspend-resume regressions that are still unresolved, mostly on
powerpc.

I'd recomment trying 2.6.30.y (from kernel org) to see if the issue is still
there.

Best,
Rafael
