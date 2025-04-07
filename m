Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02035968;
	Mon,  7 Apr 2025 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013038; cv=none; b=k7pNCJvkLAjoA9e0Pj71IYaX8XWPw2qEMQ/To3dh0ZxvMQ7OxrynJkvH0xJAeUJ0m6/ThPqDrKq6k8vS8fd+Yv8JChYXW0rnXOaqJViMXh+4nPMV/IHYQMCisAuxMYsgmzMh/WxmmGj9P5KJn4dbkXSfam0Dc2q7S3CSMkvusrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013038; c=relaxed/simple;
	bh=PcyczffQmyxkIS/mnKLqEhn2IuZ1HMm8KdQ1jktoTRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8/9rEPFBtJLA6mUU4PdOegXjqUdULbP+oiNOvhmxEQkwlPiIWTP2EVlmSpK9iZHRGxp5DvLbqFBjv908Vr/25Y3BDq2eD3dDDFkorN5xfa3qpjXejYagWgAEY1f1Z7GdnAR2G25jyDZ3SCca2Ri4lcXrVN+3goJzcBJ/A86GsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5BJ/hok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5BJ/hok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE55EC4CEDD;
	Mon,  7 Apr 2025 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744013038;
	bh=PcyczffQmyxkIS/mnKLqEhn2IuZ1HMm8KdQ1jktoTRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5BJ/hok+xXOM+t6+/FjVBnLukZ1RoLa4vb+39rSBapez7jv91gdH0wmGtj4XW116
	 8zD9scX3rn404hc9GbXuNkC5KbPsZoI2uMBIveyEqYLSY0NyjKluWoBxFhUv2f1Gr3
	 MZmo/9otey12resc9152JxmaQ8VO7am8IjVlcgUcPOKZ8uo/8ZTtH9ARfGRCGrjWyB
	 Vb448b8pik/SWcpoj5HcczTBvQtIj9JT+woEFb+MiwTqHaJMc6sHPGlu0nyheUu5od
	 RVT1dm9+dN1JWxQphhV7QYJ0SEFPwBHtYvFJNgw0TS4aS3NnKmMAIK+NSD1g9ej2Sb
	 2gsc+4sa578WA==
Date: Mon, 7 Apr 2025 10:03:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: Set INFORMATION sense data field
 consistently
Message-ID: <Z_OG6jdsX0_uar2a@ryzen>
References: <20250403212924.306782-1-ipylypiv@google.com>
 <Z-_JExGDyO9pVTON@ryzen>
 <Z_AweMPLRJgBIBF3@google.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_AweMPLRJgBIBF3@google.com>

Hello Igor,

On Fri, Apr 04, 2025 at 12:18:16PM -0700, Igor Pylypiv wrote:
> > 
> > I'm missing the bigger picture here.
> > 
> > Are we violating the spec? If so, please reference a specific
> > section in the specs.
> 
> Hi Niklas,
> 
> Thank you for the thorough review!
> 
> I'm using the SAT-6 (revision 2) spec:
> 
> 11 Translation of ATA errors to SCSI errors
> 11.7 INFORMATION field
> 
>              Table 201 — Contents of the INFORMATION field
>  +---------------------------+------------------------------------------+
>  | ATA command               | INFORMATION field                        |
>  +---------------------------+------------------------------------------+
>  | FLUSH CACHE               |                                          |
>  | FLUSH CACHE EXT           |                                          |
>  | READ DMA                  |                                          |
>  | READ DMA EXT              |                                          |
>  | READ FPDMA QUEUED         |                                          |
>  | READ SECTORS              |                                          |
>  | READ SECTORS EXT          |                                          |
>  | READ VERIFY SECTOR(S)     | ATA LBA field ᵃ                          |
>  | READ VERIFY SECTOR(S) EXT |                                          |
>  | WRITE DMA                 |                                          |
>  | WRITE DMA EXT             |                                          |
>  | WRITE DMA FUA EXT         |                                          |
>  | WRITE FPDMA QUEUED        |                                          |
>  | WRITE SECTOR(S)           |                                          |
>  | WRITE SECTOR(S) EXT       |                                          |
>  +---------------------------+------------------------------------------+
>  | All others                | Unspecified                              |
>  +---------------------------+------------------------------------------+
>  | ᵃ From ATA error outputs (non-NCQ) or ATA NCQ Command Error log      |
>  +----------------------------------------------------------------------+
> 

Please send a V3 where you include a reference to SAT-6 (revision 2),
"11 Translation of ATA errors to SCSI errors" in the commit message.


> > If a command attempts to access or reference an invalid LBA, then the device
> > server shall report the first invalid LBA (e.g., lowest numbered LBA) in the
> > INFORMATION field of the sense data (see SPC-6). If a recovered read error is
> > reported, then the device server shall report the last LBA (e.g., highest
> > numbered LBA) on which a recovered read error occurred for the command in the
> > INFORMATION field of the sense data.
> > """
> > 
> > Since we are generating this, it makes me thing that perhaps we should not
> > set the INFORMATION field unconditionally? I guess it makes sense for e.g.
> > REQ_OP_READ/READ_OP_WRITE commands, but probably does not make sense for e.g.
> > REQ_OP_FLUSH commands?
> >
> 
> SAT-6 specifies that we should set ATA LBA for FLUSH CACHE [EXT] as well.
> For "All others" commands (not explicitly listed in Table 201), the value
> in the INFORMATION field is "Unspecified". I think it should be fine to
> set ATA LBA for other commands as well.

Agreed, let's just set it unconditionally for now, and if there ever comes
a command that wants to use the INFORMATION field for something else
(which seems unlikely), we can simply special case that command.

However, please mention this in the commit message as well.


> > As you know, we also have successful commands with sense data
> > (CDL policy 0xD), see ata_eh_get_success_sense().
> > 
> > These commands will either fetch sense data using
> > ata_eh_get_ncq_success_sense() or using ata_eh_get_non_ncq_success_sense()
> > (the latter function will fetch sense data using ata_eh_request_sense()).
> > 
> > Regardless of the path taken, these commands will also end up in
> > ata_scsi_qc_complete(), so perhaps it is not enough for your patch to
> > modify ata_scsi_qc_complete() to simply set the INFORMATION field for
> > commands with ATA_ERR bit set (is_error) ? Perhaps you should also
> > consider commands with sense data (have_sense), but without is_error set?
> >
> 
> SAT-6 "11.7 INFORMATION field" has a footnote for the "ATA LBA field" as
> follows: "From ATA error outputs (non-NCQ) or ATA NCQ Command Error log".
> 
> I limited the change to commands with ATA_ERR bit set (is_error) because
> the spec explicitly mentions errors and the whole section 11 is dedicated
> to the translation of ATA errors.

We can have sense data for both SCSI status codes GOOD and CHECK CONDITION.
I'm not really a big fan that the sense data is not the same (does not
include the INFORMATION field) for these cases.

The logical thing would be, either we have sense data or not, and if we do,
the sense data has the same amount of information.

You do mention the footnote that the SCSI INFORMATION field should be set
to the ATA LBA field
"From ATA error outputs (non-NCQ) or ATA NCQ Command Error log"

If we look at the ATA NCQ Command Error log, it does have LBA field,
but no INFORMATION field.

If we look at the ATA Sense Data for Successful NCQ Commands log,
it has a bunch of Sense Data descriptors.

ACS-6, 9.29.3 Successful Sense Data descriptor,
does have the LBA field and an INFORMATION field.

The definition of the INFORMATION field in the Successful Sense Data
descriptor:

"""
9.29.3.5 INFORMATION field
If definition of the sense data to be returned when a command completes
without an error includes an information value, then the INFORMATION field
contains the defined value. Otherwise, the INFORMATION field is reserved.
"""

Thus, I do think that the most correct thing, for Successful NCQ commands
with sense data, is to fill in the SCSI INFORMATION field to the INFORMATION
field from the Successful Sense Data descriptor.

Not sure how to deal with non-NCQ Successful commands... The spec writers
do make our lives interesting by providing different amount of information
depending on the method used to get the sense data :)


Kind regards,
Niklas
