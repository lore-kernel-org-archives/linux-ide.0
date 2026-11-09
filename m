Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259966;
	b=LzvV84VVUnc/uzdXCh5iR3JpIF5kfj0d/qAjq4/abGZ7wmSjPZAh1EtemN9dZvjosq6k
	 KYXhWosQQBDmU3UGltqTUL4QlEOl9z5CR/T2i6fBs3TjgatdzHz2+E2ZAsHeQWhhttn/w
	 4QfydaRdS+0i7Z0ysq5g6Xslyd+tee/i3yzedqbydcgCuCVq/NGX52I4L7W0a61KGBpbt
	 oOv1MT/sfNFHmtzpmSPqfnDzu7kyYqO4URNKZeYTm2UQVop8AyJ6X/z2HlaBAPnBNjIOr
	 vy7tAZ5KzWosD1WdtHaUMCYsrREFm0mlaqbQk2cQgunCVxtJsdHJzGoYz/gHuz5qEcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259966;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GFd9jcOewr5aTClo4x65TtIJf965U0JEI3fEAejLmgg=;
	b=LBPdrlzMAkq+6Wb1ujgPSwncMc1X2/8nReFjC+EhKeX2KYnOl5KQ/mBCYONPTLhJQbqq
	 GzQWvAmO/DktjLZJXWRjx7MGn3xtSs4/IPmL1USODyNoTanakSboighZXYofMrfwcSn4d
	 Yqyda+/BCcj6IAcU6m1kGOsLnhPS9YrhZ1W1Y66gWBzcyCcd3OV2epzSXLSr1bvjw13+U
	 9LkqYI/5KC9xhkCikuC2j8HZBIAljaLp7R8zNCj2qyUtJtI9w0VE9LtL9H8U0DZG9amRa
	 wJX4Rn45JLlpPouiNZ149fMz+SwomrDMh/iwIhY/12gtNfJTtom6kIT8chrttodirRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGqcNw30;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E1606A321
	for <linux-ide@vger.kernel.org>; Mon,  9 Nov 2026 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGqcNw30
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16361F0089F;
	Mon,  9 Nov 2026 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259965;
	bh=GFd9jcOewr5aTClo4x65TtIJf965U0JEI3fEAejLmgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nGqcNw30GanJ7sF2aIlopvUi4vnm3OAwpw/qRyTklkuLZRNBTZ22O+LwTpOG6QoxA
	 1KWbHalMGWOXQxpbDLssdMrhQhl1HwgCnWhnCl9a/BJ+4zShNGMegpH+I/NRbOOVWC
	 75/J04YlGhsQJJI78ViX4YFF9FAOxWpEb4FZR70fy0AQOCuMVGC9Y1VipI7+WBGGQt
	 Vso1SBxRudN8h7une06WrLASslgOo/gxRsmlZm3SX4w+f4ecXz+vNpi/XstnUX98rf
	 0wZEuDpNGjjS7ZbSRZuYUQ7uxF8g3mm0qsxW/gYYaAh+XejDQEk87Txl1romxaFA5z
	 EYapD7pmUhGzg==
Date: Mon, 9 Nov 2026 22:32:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 0/3] ata: libata-scsi: fix ATA PASS-THROUGH(32) handling
Message-ID: <avI7-lrzsRL_Gz75@ryzen>
References: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104220832716LXKf7OaS9dt1VJ8Q959AG@zte.com.cn>

On Wed, Nov 04, 2026 at 10:08:32PM +0800, shao.mingyin@zte.com.cn wrote:
> ATA PASS-THROUGH(32) uses the variable length CDB opcode 7Fh with
> service action 1FF0h.  Commit b1ffbf854e08 added support for it, but
> three paths still use the offsets of the 12- and 16-byte CDBs, or do
> not recognize the 32-byte form at all.
> 
> Patch 1 fixes the PIO multi-sector sanity check and the multi_count
> computation, which read cdb[1] instead of cdb[1 + cdb_offset], and
> reports the field pointer for the same byte.
> 
> Patch 2 makes an unsupported service action fail with INVALID FIELD IN
> CDB.  It currently returns 1 without setting sense data, so the command
> completes with SAM_STAT_GOOD even though no ATA command was issued.
> 
> Patch 3 teaches the completion path to recognize ATA PASS-THROUGH(32)
> and to read CK_COND from byte 11.  Without it, CK_COND is ignored and
> the ATA Status Return sense descriptor is not built.
> 
> The three patches are independent and can be applied in any order.  All
> were tested with a 32-byte CDB sent through SG_IO to a QEMU IDE disk;
> the per-patch test descriptions are included after the --- line.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

Hello Shao,


LLM found some review comments.

I looked at the SAT specs, and the comments appears to be valid:



commit d693212f2d5e4f09a56a4883db4172f7b5892673
Author: Shao Mingyin <shao.mingyin@zte.com.cn>

ata: libata-scsi: fix the multi_count check for 32-byte passthru

This patch makes the PIO multi-sector sanity check and the multi_count
computation in ata_scsi_pass_thru() read byte 1 + cdb_offset of the CDB
instead of byte 1, and reports the field pointer for the same byte.

> For a 32-byte CDB, cdb[1] is the variable length CDB control byte and
> its bits 7:5 do not carry MULTIPLE_COUNT.

[ ... ]

> Read the count field from cdb[1 + cdb_offset], matching the rest of the
> function, and report the field pointer relative to the same byte so that
> a rejected multi-sector count points at the MULTIPLE_COUNT field instead
> of byte 1.

Does the ATA PASS-THROUGH (32) CDB have a MULTIPLE_COUNT field at all?

The ATA PASS-THROUGH (32) CDB defined in SAT-4, SAT-5 and SAT-6 (table 210
in SAT-6 r02) has:

  10 | Reserved (7:5) | PROTOCOL (4:1) | EXTEND (0)

so bits 7:5 of byte 10 are reserved, not a count. The 32-byte CDB was added
in SAT-4, where bits 7:5 of byte 1 of the 12 and 16-byte CDBs, the former
MULTIPLE_COUNT field, are already obsolete.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb0331279..927e75b7498d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3574,13 +3574,13 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  	}
>  
>  	/* sanity check for pio multi commands */
> -	if ((cdb[1] & 0xe0) && !is_multi_taskfile(tf)) {
> +	if ((cdb[1 + cdb_offset] & 0xe0) && !is_multi_taskfile(tf)) {
> -		fp = 1;
> +		fp = 1 + cdb_offset;

[Severity: Low]
Was this field pointer change part of the patch that was tested?

The index line of this patch records 927e75b7498d as the resulting
libata-scsi.c, but applying the posted diff to next-20261030 results in
20ba572c0e37. 927e75b7498d is what the diff gives without this change, so
it looks like the change was added after the patch was generated. That
would also explain the interleaved - and + lines above, which git does not
produce.

The test results below the --- line only list the sense key and the
additional sense code, not the field pointer.

>  		goto invalid_fld;
>  	}
>  
>  	if (is_multi_taskfile(tf)) {
> -		unsigned int multi_count = 1 << (cdb[1] >> 5);
> +		unsigned int multi_count = 1 << (cdb[1 + cdb_offset] >> 5);

[Severity: Low]
With a 32-byte CDB that leaves the reserved bits zero, doesn't this still
compute multi_count = 1 << 0 = 1 for READ MULTIPLE and WRITE MULTIPLE?

ata_scsi_pass_thru() {
    ...
	if (is_multi_taskfile(tf)) {
		unsigned int multi_count = 1 << (cdb[1 + cdb_offset] >> 5);
    ...
		if (multi_count != dev->multi_count)
			ata_dev_warn(dev, "invalid multi_count %u ignored\n",
				     multi_count);
	}
    ...
}

So the "invalid multi_count 1 ignored" warning that the commit message
describes is still emitted for devices with dev->multi_count != 1. Only an
initiator that sets the reserved bits gets a different multi_count.

The change that does take effect is that the CONTROL byte, whose bits 7:6
are vendor specific, is no longer interpreted as a multiple count.

Would it be more accurate to treat bits 7:5 of byte 10 as reserved, and to
skip the multi_count comparison for the 32-byte CDB, which cannot specify
a multiple count?


commit 5bd933578ed43952ff6544aadda2394a021acb83
Author: Shao Mingyin <shao.mingyin@zte.com.cn>

ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)

This patch makes ata_scsi_qc_complete() recognize ATA PASS-THROUGH (32)
commands by their service action, and read CK_COND from byte 11 of the
32-byte CDB, so that CK_COND is honored and the ATA Status Return sense
descriptor is built for these commands.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index a61fb0331279..97adeecc7736 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c

[ ... ]

> @@ -3389,6 +3392,6 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  	tf->protocol = ata_scsi_map_proto(cdb[1 + cdb_offset]);
>  	if (tf->protocol == ATA_PROT_UNKNOWN) {
> -		fp = 1;
> +		fp = 1 + cdb_offset;
>  		goto invalid_fld;
>  	}

[Severity: Low]
This isn't a bug, but this hunk changes the field pointer that
ata_scsi_pass_thru() reports for an invalid PROTOCOL field, and the commit
message only describes ata_scsi_qc_complete().

Would this fit better in the first patch of the series, which changes the
field pointer for the same byte, or in a patch of its own?

[Severity: Low]
Was this hunk part of the patch that was tested?

As with the first patch, the index line records 97adeecc7736 as the
resulting libata-scsi.c, which is what this patch gives without this hunk.
Applying the posted diff to next-20261030 results in c23b110dae63, so it
looks like the hunk was added after the patch was generated.

[Severity: Low]
Should the remaining field pointers in ata_scsi_pass_thru() also take
cdb_offset into account? They still use the offsets of the 12 and 16-byte
CDBs:

ata_scsi_pass_thru() {
    ...
		if (tf->protocol != ATA_PROT_PIO || tf->nsect != 1) {
			fp = 1;
			goto invalid_fld;
		}
    ...
	if (tf->protocol == ATA_PROT_DMA && !ata_dma_enabled(dev)) {
		fp = 1;
		goto invalid_fld;
	}
    ...
	if (ata_is_ncq(tf->protocol) && !ata_ncq_enabled(dev)) {
		fp = 1;
		goto invalid_fld;
	}
    ...
	    tf->feature == SETFEATURES_XFER) {
		fp = (cdb[0] == ATA_16) ? 4 : 3;
    ...
	if (tf->command >= 0x5C && tf->command <= 0x5F && !libata_allow_tpm) {
		fp = (cdb[0] == ATA_16) ? 14 : 9;
    ...
}

In the 32-byte CDB, PROTOCOL is in byte 10, FEATURES (7:0) in byte 21 and
COMMAND in byte 25. The cover letter says "three paths still use the
offsets of the 12- and 16-byte CDBs", but these five still do after the
series.




Kind regards,
Niklas
