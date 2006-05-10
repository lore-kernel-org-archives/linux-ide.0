From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] libata EH/NCQ/hotplug/PM git tree
Date: Wed, 10 May 2006 10:44:50 +0900
Message-ID: <44614592.7080301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:11419 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751105AbWEJBpV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 May 2006 21:45:21 -0400
Received: by nz-out-0102.google.com with SMTP id 13so1611869nzn
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 18:45:20 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, Edward Falk <efalk@google.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, all.

It took a lot longer than I thought, but it's ready now.

http://htj.dyndns.org/git/?p=libata-tj.git
git://htj.dyndns.org/libata-tj

The git tree contains ~120 commits from #upstream[1] and tagged as follows.

#libata-eh-prep		various prep patches for things to follow
#libata-eh-fw		new EH framework
#libata-eh		new EH
#libata-eh-merge-irq-pio merge irq-pio
#libata-ncq		NCQ support
#libata-hp-prep		prep for hotplug
#libata-hp-LLDD-prep	prep LLDDs for hotplug
#libata-hp		hotplug
#libata-link		introduce ata_link
#libata-pm-prep		prep for Port Multiplier support
#libata-pm		Port Multiplier support

I'll post above as patchsets later today with descriptions about what 
has changed since last post.

The following drivers support new features.

ata_piix:		new EH, warmplug
sata_sil:		new EH, hotplug
ahci:			new EH, NCQ, hotplug
sata_sil24:		new EH, NCQ, hotplug, Port Multiplier

The only Port Multiplier I've got is sil4726 and thus it's the only one 
tested.  I implemented AHCI PM support half-way but then realized I 
don't have any AHCI controller which supports PM (I have ICH7R).  Is 
there any AHCI controller which reports PM support?

In general, EH, NCQ and hotplug work great with Port Multiplier. 
However, there are some hardware issues.

* sil3124/32 don't have SNotification, so if devices with active 
commands are yanked out.  There's no way to abort the commands directly. 
  We have to wait till timeout.  Not so great but not so bad either.

* some drives lock up completely if it gets reset while commands are in 
progress.  Due to PM DMA CS errata, sometimes the controller is forced 
to reset the whole controller/PM on error detection causing this 
problem.  Well, nothing much can be done about it and recent drives 
don't seem to have such problems.

* sil3124 doesn't seem to detect R_ERR on command issue as well as 
sil3132.  If somethings goes wrong during EH, 3124 tends to timeout 
rather than quickly fail as 3132 does resulting in much longer recovery 
time.  However, I think this can be resolved by tuning timeouts used 
during EH.

* sil3124/32 reacts weirdly on ATAPI CHECK SENSE if the device is 
attached via PM and commands are active to other devices on the PM.  It 
seems that PM DMA CS errata doesn't cover all.  Problems occur even if 
only one other device is active.  This is worked around by executing all 
ATAPI commands by themselves.  So, if you connect ATAPI device to PM and 
access it, other devices sharing the PM will suffer.

I complained a lot but, all in all, sil3124/32 + sil4726 work greatly.

Albert, can you please verify that I didn't screw up during irq-pio 
merge?  It's done in the following two commits.

516fb4d37fa8648d4f7c9358c7dca22758a49c55 (actual merge)
1bb4c2efb606a5b746997b0ceabbdadbda5d3f26 (followup fixes)

Thanks.

-- 
tejun
