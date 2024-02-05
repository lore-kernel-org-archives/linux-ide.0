Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5CC482E4
	for <linux-ide@vger.kernel.org>; Mon,  5 Feb 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162730; cv=none; b=lZe3+ZdNQirDgtpG6TaebXFlOmAlFHnkGSoZU/awxCGSx2dUIMWwlHCC5wnJuPvbb+5TbeiwdQqrzIusfsNYfzmyi0g369rUvqsb34Lh3HNHYOJHra5M661hBmMMrTNlvBQ4TgH6rCAM0qJu0EF+h3sspt1L6gWZ2M/m6vmfy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162730; c=relaxed/simple;
	bh=JWJTkqKSUcYDl9NK3GHU9ZvNqL7gCyQI0I7BP/ElSok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qdHnibpe3aZANAou44VlPcwFGgsKUJAa6UKQnLZ+LnGTCo+CjfIXOcklbPSiYqZo+tTmohrRSl31V9tmPcengkQfT043D61q6TzkvMfvg8zxl8Ic+DqBvO26891iuTuNdQj+4v2VRsLHzjLxqyASGdCJ2lKmPSxuf0dRfq5Wo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=none smtp.mailfrom=vps.thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vps.thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id D934F223AC; Mon,  5 Feb 2024 14:52:01 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <c12cc683-1fbd-4f9b-92f4-dba01ae235bf@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net> <878r4l12c5.fsf@vps.thesusis.net>
 <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
 <875xziiuou.fsf@vps.thesusis.net>
 <7e324bce-9984-4291-8b5f-0907483e7bc1@kernel.org>
 <87sf2ct0ma.fsf@vps.thesusis.net>
 <58834dd7-0946-45ad-8ada-303c0d735164@kernel.org>
 <87fryafxs5.fsf@vps.thesusis.net>
 <c12cc683-1fbd-4f9b-92f4-dba01ae235bf@kernel.org>
Date: Mon, 05 Feb 2024 14:52:01 -0500
Message-ID: <87ttmmit9a.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> See ata_dev_revalidate() and ata_dev_configure() and all the drive features that
> are checked using the identify data. We need to preserve that to ensure that
> nothing changed on the drive so that its representation in libata is kept in
> sync with the drive config. That is why drive starting with PUIS and not giving
> full identify data *must* be woken up, which is the current libata behavior.

Yes, the information is needed to revalidate, but why must this
revalidation be done during system resume, rather than postponed until later?

> You do not need to change the hierarchy of devices. An ata_dev is already a
> child of its scsi_dev. So if you want to set the ata device to runtime
> suspend

How is an ata_dev a child of its own scsi_dev?  Or did you mean to say
the reverse: the scsi_dev is a child of the ata_dev?  But that isn't the
case either.  In sysfs, you have:

ata_port
 - scsi_host
   - scsi_target
     - scsi_lun
 - ata_link
   - ata_dev

The link and dev hang off to the side, not in the ancestry of the scsi
disk.

> state, you have to have the parent in the same state too. runtime suspend work
> top-to-bottom in the device chain. You cannot have random device in the middle
> of the chain going to suspend without the devices above it also being suspended.
>
> Also, the user does not use ata devices directly. They use the scsi device
> representing the ata device. You must thus have that in sync with the ata device
> state.

Right... so when the system is resumed, first the ata_port is resumed,
then it has to be on for the scsi host, target, and lun to resume.  At
that point sd could check if the disk is actually spinning, and if not,
force it to suspend, which then allows the target to suspend, wich then
allows the host to suspend, and finally the ata_port.
