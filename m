Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EE28F5
	for <linux-ide@vger.kernel.org>; Fri, 17 Apr 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439152; cv=none; b=vCEPQmc79nRvkbc0E2uHhUxqpO/Cnu1+jO+2AWvHxfhFfefFLG00DELbIillPrv2PMOSH82KuCRWnwIp74RLcnoIt6p0dvITyF5yDbRiTemF044CqCvgF9wvTz93ZwBJzZ7ycDRdrEZS0w1cG6K3vb6kQ+4NKEWqhZAC0dS7+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439152; c=relaxed/simple;
	bh=nvCe1cgVxYpZcTOLU1cHje3Dtc3fqaiX5f/H4SHGhGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZDL4tgjqX7nDqb6hZrS9ZVefcKJNlrroXTX0SatE5pwUnjNBM6DNQrqVy9T2OBFAcxTSf2SrSVRFSg+6Mv+rM3mlyO1Y34o8f5P0IvvsEXAAzc8dwsZ0WLk64Z4RmvmQlyx3F1b4SgkgNaUcmcMdw5irdjRXIN0gEA836faHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW4H3m9x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW4H3m9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905D0C19425;
	Fri, 17 Apr 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776439151;
	bh=nvCe1cgVxYpZcTOLU1cHje3Dtc3fqaiX5f/H4SHGhGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW4H3m9x80Re4cPZcc+IIcnS04XPoMjUCmf2DyBXTgWTH9l5r7lEH55k/6VXzN8jt
	 AKePtafT4lL4CQdEzUrys7qLL8KM4G/fWc1zVH3q07RCGckBvIzgKP4rkWMsc6zeKh
	 YDUwXRY141TrXt+XeZglDUsreh4TP/0hLOZuV0XVuDumXlEve7V5OCjXSgNO9c3NdP
	 2P2zJLNXEDz91fbd94jhui3SO5RiuKa5vZXIJCYChDCxTt4aFk2kaluZz7bIXPoZ92
	 GhvKVo66QiiHfpIAQioKrIaRhKtoWqnHgAE2IaO7lOJ1cH2M251j7bF2ELTzjlvZ6M
	 bbuiNafnSct2A==
Date: Fri, 17 Apr 2026 17:19:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Tommy Kelly <linux@tkel.ly>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
Message-ID: <aeJPbLQ-WXCQMxC1@ryzen>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
 <advi1OGShxsjdrCL@ryzen>
 <f93c6f1a-ea5b-46cb-b9a5-cf88bac453cf@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f93c6f1a-ea5b-46cb-b9a5-cf88bac453cf@tkel.ly>

On Thu, Apr 16, 2026 at 09:38:21PM -0700, Tommy Kelly wrote:
> Hi Niklas and Damien,
> 
> Thanks for the responses.
> I managed to build libata/for-next into rpms for my Fedora CoreOS system.

Thank you for testing!
I was worth a shot.
We will need to dig deeper then.


> I am new to this, but perhaps linux is misunderstanding the queue depth. 
> There are "32 command slots" for the PMP, but each drive advertises "NCQ (depth 32)" as well, but perhaps there is only actually 32/5=6 slots per drive.
> Not sure if that matters wrt the bug.

For a PMP with FBS, the PMP can communicate with multiple drives simultaneously.
Thus, the commands in the 32 command slots can be for different drives.
There is no fixed limit on how much each one drive can occupy. E.g. one drive
use all 32 if there is only I/O going on to a single drive.

For a PMP without FBS (only CBS), the PMP can only communicate with one drive at
a time. Thus, the commands in the 32 command slots will belong to the same
drive.


I think the problem is that the patch that implements the deferred QC logic
forgot to think about port multipliers.

A PMP with FBS can mix NCQ and non-NCQ commands (to different drives of course).
The current deferred QC design stores a single deferred QC in struct ata_port...

This must instead be stored in struct ata_device, or struct ata_link, or have
an array of deferred QCs in struct ata_port.

This means that, for PMPs with FBS, if we defer a QC to one drive (because you
cannot mix NCQ and non-NCQ commands - within a single drive), we will currently
defer commands to all other drives on the PMP.

This is obviously very bad for PMPs with FBS, as commands to other drives will
be deferred for no reason (it will kill performance).



Your problem however, is with PMPs without FBS (only CBS).

Spawned process 'ata_id --export /dev/sdb' [635] is taking longer than 59s to complete.

https://github.com/systemd/systemd/blob/main/src/udev/ata_id/ata_id.c#L93-L115

ata_id seems to send a ATA PASSTHROUGH (12) non-NCQ command.
Presumably some command is already running on sda.

https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libahci.c#L1682-L1685
https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libata-pmp.c#L115-L120

For CBS, it appears that sata_pmp_qc_defer_cmd_switch() will set:
ap->excl_link and will set qc->flags |= ATA_QCFLAG_CLEAR_EXCL.

and then:
__ata_qc_complete() will clear ap->excl_link, but only if qc->flags
ATA_QCFLAG_CLEAR_EXCL was set.

Once a command is completed, ata_scsi_schedule_deferred_qc() will either:
call ata_scsi_requeue_deferred_qc() which will requeue it in SCSI ML, or:
will call ap->ops->qc_defer(qc) and schedule the deferred QC worker.

Considering that we don't see any actual timeouts from SCSI or ATA in your
dmesg, my best guess is that the command is infinitely getting requeued in
SCSI ML. (Possibly by ata_scsi_requeue_deferred_qc().)

I don't really see it. I guess someone with a PMP would need to debug.
(Should be trivial to force disable FBS for a PMP that supports FBS.)

One behavior change that I see from before with a PMP CBS:
if (ap->deferred_ap) is set, we will now return SCSI_MLQUEUE_DEVICE_BUSY,
while before, sata_pmp_qc_defer_cmd_switch() would cause us to return
either SCSI_MLQUEUE_HOST_BUSY - if there was a command excuting on another
drive, or SCSI_MLQUEUE_DEVICE_BUSY - if the same drive was busy executing
NCQ commands.


Kind regards,
Niklas
