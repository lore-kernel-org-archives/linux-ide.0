Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2A30568C;
	Thu,  2 Jul 2026 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003013; cv=none; b=vA6TgSd29sI3vEWu2sQfYEYw1ipNFDSwIWv2p8uehBqIHStQAtphdxHerwhUZT1/JWzyZl13vWrshk7FIXTg2SOURSfncBzXSpLWRLcjN7NEXbykvu9+S/ANyuILOJv9C4cyZWG/ZZAm6fvOwlrcUh+vNoEiwUWtPIBer3jUmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003013; c=relaxed/simple;
	bh=iMULdhbSztRZ/NZwxnlzwjoFvKTwp9OQVKZcn9ek53M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOroY3afFUJX6ByePsTTuwJVeCwi6fvQS57dr3uMDkg0vd2p0xz3ASUKC5vQlP0yUkSoVyLkny4hZIxPLABeH8Dvv/FpoLISEXS43a22JbWiqmpWehzjlUqvllE5mPOuaDD84md6xzDMkJKF7byaWxPyY4gmjtSrEITQ0fuKX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYXx6Wd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYXx6Wd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACF41F000E9;
	Thu,  2 Jul 2026 14:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003012;
	bh=InF2vPUvusXKVQIeSQc6QbxQcXfIg0lnmMW/ZMXW0RQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IYXx6Wd4/K49pLzE67LMyfyky/frEEW783Cra00kC9qvUzf18LG+SPj1f4w0OpwbO
	 HSkBcB8h4vantQ4N7++VizLbXGhQhjZJmaJ1E92FtKWz66qtkEvQ6X4kkc6sM2T09a
	 tiS/mX0Kzsh7O/xXgbo90DZunKKssp1pRWciBFMNcu1jFjuSCe4oQ6T/2UCWCigbKy
	 Pfew+KzhSwcOC73ThWPR+T0hz+REHVlaRAVmBYMLgz+F5mbJERGdLSG4fJJoAGT6OI
	 AyZe/zqYdPNdVDER+1sAaJAOjk9m5sIZaucQ2jD2DCqblgFOJOaw89nCVCuSwtQovN
	 Tfd/8RDjfBl0w==
Date: Thu, 2 Jul 2026 16:36:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/5] ata: libata-scsi: refactor
 ata_scsi_report_supported_opcodes()
Message-ID: <akZ3gQq8w57IWCIC@ryzen>
References: <20260702063412.1892584-1-dlemoal@kernel.org>
 <20260702063412.1892584-3-dlemoal@kernel.org>
 <20260702065321.07EB51F000E9@smtp.kernel.org>
 <akZmx5L1HLsb7-wk@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZmx5L1HLsb7-wk@ryzen>

I guess we could theoretically report WRITE SAME (16) support in
REPORTED SUPPORTED OPERATION CODES.

A WRITE SAME (16) command can either have the unmap bit set or not.

ata_scsi_write_same_xlat() already rejects a WRITE SAME (16) command that
does not have the unmap bit set:

        if (!unmap || (dev->quirks & ATA_QUIRK_NOTRIM) ||
            !ata_id_has_trim(dev->id)) {
                fp = 1;
                bp = 3;
                goto invalid_fld;
        }


I don't see anything in the SBC / SPC that forbids a device from acting
in this way. Some searching claims that some controllers do reject any
WRITE SAME (16) that does not have the unmap bit set.



To mark that we suport WRITE SAME (16) for deallocation, in the
Logical Block Provisioning VPD Page (0xB2), we currently set:

"
LBPWS (Logical Block Provisioning Write Same 16) Bit: This bit must be set
to 1 to indicate that the device explicitly supports setting the UNMAP bit
in a WRITE SAME (16) command to deallocate blocks.
"

This is done in ata_scsiop_inq_b2():
rbuf[5] = 1 << 6;



However, considering that we always reject a passthrough WRITE SAME (16),
I am not sure if we really want to report WRITE SAME (16) support in
REPORTED SUPPORTED OPERATION CODES.

If feels weird to report support for something, but if the user actually
tries to submit such a command via SG_IO, it would be rejected (even if
the unmap bit is set).

Perhaps it is best to just continue to using it internally as an
intermediate command/representation for REQ_OP_DISCARD ?



I did find this old series from Christoph, that adds a ATA_TRIM SCSI vendor
specific command to translate to DSM TRIM:
https://lore.kernel.org/all/20170320204319.12628-3-hch@lst.de/T/#u

I do like the idea, as we would no longer be limited by the sector size
(the SCSI Data-Out buffer), when issuing trims.

The downside is that it adds ATA specific code to sd.c (see
sd_setup_ata_trim_cmnd()), and I guess that is why the proposal was
NAKed by SCSI maintainers.

With the current solution, which is dependent on the sector size
(i.e. the WRITE SAME (16) Data-out buffer size), for a device with a
sector size of 512, we can issue TRIMs of size:

512 * 0xffff * 64 = 1 Gi + 1023 Mi + 992 Ki

A trim of 2 GB, so perhaps it is not so important to increase/migrate
away from the current solution (which is dependent on the sector size).

One of the biggest complaints Christoph had was the use of the ata_scsi_rbuf
and ata_scsi_rbuf_lock, and that concern seem to be addressed by my series:
https://lore.kernel.org/linux-ide/20260702105956.2058733-4-cassel@kernel.org/T/#u


Kind regards,
Niklas
