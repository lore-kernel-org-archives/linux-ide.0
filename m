Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E71C695
	for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2026 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401187; cv=none; b=Ql2lvGRq89cWpJ4L6Ij8LnrRfqE/9lMwdsvo3YrjHt/5I3M07UvIqIO38Y0J546mmS0rj5a2J0WOgy2I+iOePIneb7HGMjmdHXclrpHvpE9HtCKEkmIi/IDl2TFKU0SkDC/r4BJpQEJz0DqxjfZY+ZlhvaYGz+ercnkBW6mVgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401187; c=relaxed/simple;
	bh=IJpSv02/PKexFup/YK/stEXCviwP42nkm9IefLeXeKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPMvKwZF8wmLmZAwOAYLJbNuXL/MhEYERZNaMvWplwCZdL//250Ti8VkAdN1nFRAUe+9r+we6tWgfCHIDuP330fKcRrlyWQZuPstaqi/RgElhdEwSBORbfyusM7/yEqhdgU+FKuBK2akYX5WW1mX09GL+2TlJPviIZfSE0c41l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=tbKnwUnW; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="tbKnwUnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1776400704; bh=IJpSv02/PKexFup/YK/stEXCviwP42nkm9IefLeXeKw=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=tbKnwUnWsBnlzz+xHXmV7aHkQt03rjOUsqq4Ll7CWhLUMkoYTZyKKQJX+pHnRkZRY
	 p8/hhq6P2V0IwbOtDMcyckvEHE9EW9DHPtQ40W6TAHlMB5/g7wl7u1aggZIxaZ9rxw
	 /IGkk0gjB0jXOuzfTc1ORy/DVXMRLX7ZADhGKkIC8jfvrKu1VbAdNeLetUxWWlY4Gl
	 /JGR603e3Ol9ctTo34EwfIXq/ywqVzPI5xuLem1GhYkMLsjQBSvMMCtqcw9AWOuonV
	 EYQfMwFrGm509Z2iNVESpPdEZ5FnY5xQJ/0i8oySHMb1952QvPuQDxVfkI1qr/vlwA
	 sjXm0TA3ClU3w==
Message-ID: <f93c6f1a-ea5b-46cb-b9a5-cf88bac453cf@tkel.ly>
Date: Thu, 16 Apr 2026 21:38:21 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
To: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly> <advi1OGShxsjdrCL@ryzen>
Content-Language: en-US
From: Tommy Kelly <linux@tkel.ly>
In-Reply-To: <advi1OGShxsjdrCL@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 11:22, Niklas Cassel wrote:
> On Thu, Apr 02, 2026 at 02:22:49AM -0700, Tommy Kelly wrote:
>> On 2/20/26 14:14, Damien Le Moal wrote:
>>> The first patch addresses a use-after-free issue when a deferred qc
>>> times out. The second patch avoids a call to a potentially sleeping
>>> function while a port spinlock is held.
>>>
>>> Changes from v1:
>>>  - Corrected typo in patch 1 message, improved comment in code and added
>>>    a WARN_ON_ONCE() call to verify that a timed out qc is not active.
>>>  - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
>>>    port lock held. This call is in fact removed: it is not needed as
>>>    ata_scsi_requeue_deferred_qc() is called in EH, which is always run
>>>    when removing a port.
>>>
>>> Damien Le Moal (2):
>>>   ata: libata-eh: correctly handle deferred qc timeouts
>>>   ata: libata-core: fix cancellation of a port deferred qc work
>>>
>>>  drivers/ata/libata-core.c |  8 +++-----
>>>  drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
>>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>>
>>
>>
>> Hello, this is my first message on the LKML so please forgive me for
>> likely not following etiquette.
>>
>> I have what might be a regression from somewhere in the recent series of
>> NCQ / QC patches.
>>
>> I have a peculiar setup that might reveal the source of the bug. I'm
>> using a SATA Port Multiplier (PMP), powered by JMB575, which expands 1
>> SATA port to 5 drives.
>> The device/driver/subsystem tree looks like rk3568-dwc-ahci -> scsi -> sda.
>> The platform does not (yet) support FIS-Based Switching (FBS), so it is
>> using Command-Based Switching (CBS). FBS support may land in Linux 7.1.
>>
>>> kernel: ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst
>>> kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
>>
>> When switching from kernel 6.18.13 to 6.19.7, drive access became
>> extremely slow, causing lock timeouts at the filesystem level. I solved
>> the problem by changing /sys/block/sd*/device/queue_depth from 32 to 1.
>>
>> I also looked through the recent LPM patches, but the drives'
>> performance didn't improve after changing LPM settings for the scsi host
>> in sysfs.
>>
>> Let me know if I need to provide more details or logs. I can see
>> COMRESET a lot in each device's SMART logs but they aren't timestamped
>> so I haven't proved that they are recent. Perhaps the slow drive
>> switching is causing command starvation.
> 
> Hello Tommy,
> 
> Igor recently found a bug in the deferred QC feature:
> https://lore.kernel.org/linux-ide/20260412153637.475606-1-ipylypiv@google.com/
> 
> His fix patch has been queued up on libata/for-next, so perhaps you could try
> the libata/for-next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-next
> 
> And see if you can still reproduce the problem there.
> 
> 
> Kind regards,
> Niklas

Hi Niklas and Damien,

Thanks for the responses.
I managed to build libata/for-next into rpms for my Fedora CoreOS system.
Which includes Igor's "fix requeue of deferred ATA PASS-THROUGH commands".
But unfortunately, the NCQ problem remains.
Drive access is extremely slow, and on this test boot 3 out of 5 drives failed to even be initialized by the system.
`lsblk -f` only printed fstype for sda+b, none for sdc+d+e.
It is fixed by this udev rule which sets queue_depth on each drive to 1.

> SUBSYSTEM=="scsi", DRIVERS=="sd", ATTR{queue_depth}="1"

Here are some error logs, though I don't think they are particularly illuminating.

> (udev-worker)[549]: sdb: Spawned process 'ata_id --export /dev/sdb' [635] is taking longer than 59s to complete.
> systemd-udevd[473]: sda: Worker [551] processing SEQNUM=3406 is taking a long time.
> systemd-udevd[473]: sdd: Worker [542] processing SEQNUM=3414 is taking a long time.
> systemd-udevd[473]: sdc: Worker [562] processing SEQNUM=3408 is taking a long time.
> systemd-udevd[473]: sde: Worker [550] processing SEQNUM=3412 is taking a long time.
> systemd-udevd[473]: sdb: Worker [549] processing SEQNUM=3410 is taking a long time.
> systemd[1]: dev-sdc.device: Job dev-sdc.device/start timed out.
> systemd[1]: Timed out waiting for device dev-sdc.device - /dev/sdc.
> systemd[1]: dev-sdc.device: Job dev-sdc.device/start failed with result 'timeout'.
> systemd[1]: Unnecessary job was removed for dev-sda.device - /dev/sda.
> systemd[1]: Unnecessary job was removed for dev-sdd.device - /dev/sdd.
> systemd[1]: Unnecessary job was removed for dev-sdb.device - /dev/sdb.
> systemd[1]: Unnecessary job was removed for dev-sde.device - /dev/sde.
> systemd[1]: dev-sde.device: Job dev-sde.device/start timed out.
> systemd[1]: Timed out waiting for device dev-sde.device - /dev/sde.
> systemd[1]: dev-sde.device: Job dev-sde.device/start failed with result 'timeout'.
> systemd-udevd[856]: sde: Worker [869] processing SEQNUM=3696 killed.
> systemd-udevd[856]: sdd: Worker [871] processing SEQNUM=3693 killed.
> systemd-udevd[856]: sdc: Worker [875] processing SEQNUM=3690 killed.
> systemd-udevd[856]: sdc: Worker [875] terminated by signal 9 (KILL).
> systemd-udevd[856]: sde: Worker [869] terminated by signal 9 (KILL).

There is one line from pcp-pmie which is interesting:

> pcp-pmie[1784]: High per disk average queue length 6280%await[sdd]@hostname

Some info about sdd and the port multiplier, if it is relevant. sdd is the only drive without HIPM

> kernel: ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> kernel: ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> kernel: ahci-dwc fc800000.sata: supply target not found, using dummy regulator
> kernel: ahci-dwc fc800000.sata: PMPn is limited up to 5 ports
> kernel: ahci-dwc fc800000.sata: forcing port_map 0x0 -> 0x1
> kernel: ahci-dwc fc800000.sata: AHCI vers 0001.0300, 32 command slots, 6 Gbps, platform mode
> kernel: ahci-dwc fc800000.sata: 1/1 ports implemented (port mask 0x1)
> kernel: ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst 
> kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> kernel: scsi host0: ahci-dwc
> kernel: ata1: SATA max UDMA/133 mmio [mem 0xfc800000-0xfc800fff] port 0x100 irq 77 lpm-pol 0
> kernel: ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> kernel: ata1.15: Port Multiplier 1.2, 0x197b:0x5755 r0, 5 ports, feat 0x5/0xf
> kernel: ata1.03: hard resetting link
> kernel: ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> kernel: ata1.03: ATA-10: ADATA SU655, V8X01c62, max UDMA/133
> kernel: ata1.03: 468862128 sectors, multi 1: LBA48 NCQ (depth 32)
> kernel: ata1.03: Features: DIPM
> kernel: ata1.03: configured for UDMA/133
> kernel: scsi 0:3:0:0: Direct-Access     ATA      ADATA SU655      1c62 PQ: 0 ANSI: 5
> kernel: sd 0:3:0:0: Attached scsi generic sg3 type 0
> kernel: sd 0:3:0:0: [sdd] 468862128 512-byte logical blocks: (240 GB/224 GiB)
> kernel: sd 0:3:0:0: [sdd] Write Protect is off
> kernel: sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
> kernel: sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> kernel: sd 0:3:0:0: [sdd] Preferred minimum I/O size 512 bytes
> kernel: sd 0:3:0:0: [sdd] Attached SCSI disk

ADATA SU680 was quirked with ATA_QUIRK_NOLPM recently. My sdd is ADATA SU655.
But changing link_power_management_policy to max_performance had no effect so I don't think LPM is the culprit here.

I am new to this, but perhaps linux is misunderstanding the queue depth. 
There are "32 command slots" for the PMP, but each drive advertises "NCQ (depth 32)" as well, but perhaps there is only actually 32/5=6 slots per drive.
Not sure if that matters wrt the bug.

Thanks for your time and energy,
Tommy

