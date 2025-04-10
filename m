Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61947285404
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290157; cv=none; b=Y3tic6aKGr0r0AQE3Y5mQJZD81aRVfK2vt7Wxf/C8DnQzCHOxOBzdzPskBvEagy3/D3WrQQv3BqO83ZymJN8tgHCFP2JMIgYaBoCuSYwOOWVHMBNVHA9hL5cBxxUNKYIOa4rAxuDEiH6y5Ux1nkKCPG6Jw6eodjiKWJ3BYKz85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290157; c=relaxed/simple;
	bh=/G4H12N8I8alKHHmwaKUoyh6O1KhIGRquQwp3x87k8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDNnMc2GQ441n+xrMK60l1xOLp4zQKNg9cFsxWp++skwBwDGhbescRcRqT1XWclqgmYKFafOGmrdwI6vEb91cRBrtWsR4DItw+FX36RKHOv9zpheXpxWmMaTa8cliOhkyCgyN2o4v1i0GW1U8lWNuJ0aTAeEFtFrMDmLC7Nw3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRn05Uj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRn05Uj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2ECC4CEDD;
	Thu, 10 Apr 2025 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744290156;
	bh=/G4H12N8I8alKHHmwaKUoyh6O1KhIGRquQwp3x87k8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRn05Uj3Yvrri0zSCwRPeD72FbYkZntVeyiuzuEQAbRmXb0a8SCVSpJNZXAyYzOqu
	 onSND9va8zET7FwUssiDiEv680HRUnVRp2aqMoY3aPnCU5UvpeTDrr84iQNnBbUUjz
	 wQW8C/K+YlOu/4aLpMZdDdA6jq7Ffr2Ket38ct+zh0mwfG/66u27oogJfAnjTiRvd6
	 G3ZsG4WakbsTFVpXnZesYWYDB2fiwPzar2QKGpb2uvAmGD9RNCKB6sd7r4B9mx17BG
	 5TUqQsU7Y9UpB5YZoUlGWT0Pfa+O94A4DWtAAP7hHvZvsKVL48tfG+IQMKd9w7Avvc
	 4gHV7vbFW1u0g==
Date: Thu, 10 Apr 2025 15:02:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-sata: Use LBA from sense data descriptor
Message-ID: <Z_fBaVZkcD9AtTaR@ryzen>
References: <20250409084546.121694-2-cassel@kernel.org>
 <Z_aul100eqb2-naM@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aul100eqb2-naM@google.com>

On Wed, Apr 09, 2025 at 10:29:59AM -0700, Igor Pylypiv wrote:
> On Wed, Apr 09, 2025 at 10:45:47AM +0200, Niklas Cassel wrote:
> > The definition of the LBA field in the sense data descriptor is:
> > 
> > "If definition of the sense data to be returned when a command completes
> > without an error includes an LBA value, then the LBA field contains the
> > defined value. Otherwise, the LBA field contains a copy of the LBA field
> > in the command inputs for the command that completed without an error
> > and returned sense data."
> > 
> > Thus, the LBA field in the sense data descriptor can contain a LBA value
> > that is different from the LBA field in the command input.
> > 
> > Therefore, just like how ata_eh_read_log_10h() overrides qc->result_tf
> > with the LBA in the NCQ Command Error log, override qc->result_tf with
> > the LBA in the Successful NCQ Commands log.
> 
> Hi Niklas,
> 
> Should we also override other fields e.g. COMMAND, FEATURE, COUNT, AUXILIARY?
> I understand that per current SAT spec those fields contain data from command
> inputs so we can get the same data directly from qc->tf and technically don't
> need to fill qc->result_tf with the same.
> 
> If I understand correctly, qc->result_tf contains data filled from a shared
> FIS so it is likely that it contains data that belongs to some other command,
> is that true? If that's true, should we clear the qc->result_tf before filling
> the fields with data from the Successful NCQ Commands log?

For AHCI, for a successful NCQ command, we will fill the result TF from the
SDB FIS in the FIS Receive Area, and will set ATA_QCFLAG_RTF_FILLED:
https://github.com/torvalds/linux/blob/v6.15-rc1/drivers/ata/libahci.c#L2153-L2158

The FIS Receive Area will get overwritten with each new received SDB FIS,
as it can only hold one SDB FIS.
(For libsas drivers, usually each completion can access the exact FIS that
completed the IO.)


A CDL command will set ATA_QCFLAG_RESULT_TF, but since ATA_QCFLAG_RTF_FILLED
is already set, fill_result_tf() will be a no-op.

If it was an NCQ error, ata_eh_read_log_10h() will set/overwrite qc->result_tf
with the information from the NCQ Command Error log, but for an NCQ error
there can be only one tag that caused the error:
https://github.com/torvalds/linux/blob/v6.15-rc1/drivers/ata/libata-sata.c#L1472-L1482

Both for a failed and a successful command qc->result_tf should be cleared
for a new QC, so I don't think we need to clear anything.
(And as you saw, ahci_qc_ncq_fill_rtf() only fills status, error, and flags.)


I chose to only fill LBA from the sense data descriptor, because, as you
said, "9.29.3 Successful Sense Data descriptor" says that:
COMMAND field, FEATURE field, and COUNT field are copies of the input command.

Sure, ata_eh_read_log_10h() does fill in all these fields, so strictly
speaking, we probably should fill qc->result_tf with COMMAND, FEATURE,
and COUNT, even if they will always have the same values as qc->tf...

But... even for a NCQ QC with ATA_QCFLAG_RESULT_TF, we have so far only
been filling STATUS, ERROR and flags, basically because that is the only
information that is available in the Set Device Bits (SDB) FIS that is
received on NCQ completion (and no one has complained yet...)

I guess now when we do have access to the information, the most consistent
thing would be to fill all field we can in qc->result_tf... but, to do this
for every IO might slow things down.

So is there perhaps some logic to only filling LBA (in addition to STATUS
and ERROR, which are filled for all NCQ commands), since that is the only
field that can change, as per the specs.

Damien, thoughts?


Kind regards,
Niklas
