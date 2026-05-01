Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FD34D4FE
	for <linux-ide@vger.kernel.org>; Fri,  1 May 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660966; cv=none; b=lb8n/CY4u1b0C5dojzMGntwyRPwVuqCjhYztIE5qkCCMpm5WEpXjFZfOw2OWLEAXRNV8uGs66lhWfEfmzCsnK2/JqCR9Q1y+ylZGlC0aYtLrO1L5DiYxVXIz8ogrHj7scP7gZEvRsASjH1TTuP5QaRmy5Es/viMooub56EklcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660966; c=relaxed/simple;
	bh=S/u4KZO1AO9TH54BDWTok7pWhcLnHgz22mW0i3pJN1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/gAyLlBZ4ouZrmexVGbEUvz7QI3afus/7uSVtLdXIrCT4jHwcl+X6y0i4RbhfvAZDEEZ5LsfxuXgxwbkhHEyrJuh/Z6yKOe7qSNTO32C8YgE1BKC43iTw3yIdVqxm6ALq4yFxLCcCUwzlJDccu1Ioc34ts7Adx61yQuj78Zf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELOXszeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELOXszeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B39C2BCB4;
	Fri,  1 May 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777660965;
	bh=S/u4KZO1AO9TH54BDWTok7pWhcLnHgz22mW0i3pJN1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELOXszeS74053cVL3VmdlvLVrG36eoWbBFYrL3aBcPSnOc4CoYaG2mXkUWn9qBLWs
	 VaC11U1mhYxoazOddPe7jaE31bxbdfzOAiz6n7HGrbikbH7Iag80a23XsCWvviZAnD
	 HMjaXeTqw10l7E5kqAB+iWC5dPUxuNvaVOKqrhHlflxWvKcnj1vJMIDnnCebCUsun9
	 Jmo0IJz9iNX5rt6LWxhsnTAWncgOxsV8JHk0k1P2HT6gVKimSfIHfgXE2Pa6mIhhuy
	 FDcQmnMr2SJqzAEoA5Qg6JvoUPgP6vmYjHYC2+sOCqJBwjuuOTDpC1pc2Is6Dc4xc8
	 G1VjUCRxBoHvQ==
Date: Fri, 1 May 2026 20:42:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Tommy Kelly <linux@tkel.ly>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org, hare@suse.de
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Message-ID: <afT0INMUg7scssxk@fedora>
References: <20260501125410.1204490-5-cassel@kernel.org>
 <4be77745-2b7d-416c-b01a-88669d9bbeb8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be77745-2b7d-416c-b01a-88669d9bbeb8@oracle.com>

On Fri, May 01, 2026 at 03:19:03PM +0100, John Garry wrote:
> On 01/05/2026 13:54, Niklas Cassel wrote:
> 
> As I understand, this deferred QC scheme was intended to solve starvation
> problems for multiqueue SAS HBAs (using libsas-based drivers). libsas has no
> port multiplier support, so I wonder why we make deferred QC scheme work for
> port multiplier, i.e. non-libsas scenario.

Are you certain that there are no libsas HBAs that support port
multipliers?


Basically, before commit:
0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")

We always aborted a new command, if that would have caused NCQ and non-NCQ
commands to be mixed on the same device.
Regardless if libsas driver or any other SATA driver, e.g. AHCI.


After commit:
0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
If sending a non-NCQ command while NCQ commands are in flight,
we instead save the non-NCQ command and issue it as soon all NCQ
commands are finished, from a workqueue.

This commit changed the behavior both for libsas based drivers and
all other SATA drivers, including AHCI, which does support Port
Multipliers.

As you might now, Port Multipliers are not that common, and I think
simply no one tested the change on Port Multipliers before the change
was included.


As you can see in patch 2/3, we basically stop using this deferred QC
issuing via workqueue for Port Multipliers with CBS - when sending
commands to different devices.

For Port Multipliers with FBS support, or PMPs with CBS support where
issuing commands within the same drive, we are still using it.

For PMPs with FBS, I don't see any problem of keep using the workqueue
to issue a deferred QC. It should basically be the same as if directly
connected on the port. (There is no extra logic to handle ap->excl_link.)


For PMPs with CBS, we could keep the same behavior as before, and just
abort the command, if NCQ and non-NCQ are mixed.

The advantage is that the workqueue issuing would not be able to somehow
collide with the ap->excl_link handling for CBS PMPs. Looking at the code,
it "should work", because we always will always have ATA_QCFLAG_CLEAR_EXCL
set on the QC issued by the workqueue.

This would require that we know that PMPs (with CBS) can't be used on
libsas based HBAs. Hell, we could probably do that if we wanted to, since
I don't think that people using an expense SAS HBA with a cheap CBS PMP
(does not not even support FBS) is very common in practice.,,


Kind regards,
Niklas
