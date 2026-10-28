Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188418;
	b=q0wVTObTMLozgANxmhwud3JM6CNGt8vj0j+GMhXeCrvEZMURFd/94TLjlkci9gTXsKsl
	 eoK3zClmU7OrD1nKfmRZYGJL44qkuSCM/AY2RTk7h2BLVPF9UCol5w+2tX5FIMlPUbKP5
	 ohcbZZdgORt+goqJuliaT0d9ak6RL0OketFYnJ07h3oogHtBJE4H1pQXfdmtELEWMKCvz
	 qqY++fkJGcYFH5tg13j2t2pAWU8S/s8f/BJh8FtMFDg/QtnXwjVFgUzLQaxKjd2vTWghS
	 gsTKCG7lndb4Bwmqr2tBnJqjEYuqxNSp9eVp5nV0v3G4sK1LURRRt8f/ABzp6FDJEvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xY/5bM4rnMmAe5PGTgfZ1C+5Na9dqVsgFUfPAzE/x/4=;
	b=oJdVNfZv530yLQErIphOCy82Sbmqhhu8xuPRROj1EDhxRtHfrz20/WRvmVvcqlmdPURQ
	 KPrDBceQ9spymz+UM//KpNtPgqFjue3qhHM7ghZBTVMLUopxDcDcNOgwtErtfzjWRa2FU
	 hqKILinjhHQFvecbt9rLnaI6pzEu/Uz4Mo7FoChwBxGIZM+d9gN3B5fmVNnLA8am7OGWj
	 yC2GXS+Gskhj4WzF1EHuzm3m70/7N/Y+Bg8BI1fUzwPiL9OqekR+js+WPDqB9gQCsZUUj
	 hhlFUSOnFu5hMwaZlmgvQAl1oBapNnUvX+Zg6haKKaM2jDg28I613Six9PGMbMb4KEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhrXtBfS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CF606A322
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhrXtBfS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E2C1F01825;
	Wed, 28 Oct 2026 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188417;
	bh=xY/5bM4rnMmAe5PGTgfZ1C+5Na9dqVsgFUfPAzE/x/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jhrXtBfSU0JTS+5fmQ0dFrqT7IoPNTzxShHgLfIn5OjymVewCHu5qFzUQWXKvU3bJ
	 hn4faUtptETIgYxle5tO3CPzrihet9pqSi1ZXUXUrTyqClXkZUwZFqRQWlxRhOVazL
	 WL/q9Owr8F8uTbnKCUfoHHEPtWHLZHgSlrM+n77ynPML4yuzyvMBohBrrSPYuMc9ea
	 8Ha4dNWSF8uF9B1TnX+MeA0wb37/AatADwvIDiE8CELIZGpMKJrgasm6r1tqxzkHSR
	 PCGKWXA/aN7nAce6VGJzYUqqEtam521b5OCnEsawN3VrO1VI/EwNFiGMB8NW2iRWyl
	 /l7JBUk+Zc+BA==
Message-ID: <sashiko-outbox-187849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: reject data-in commands with a
 data-out buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261028113903.19569-1-zhaogongyi@bytedance.com>
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
 <20261028113903.19569-1-zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:53:37 +0000
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ata: libata-scsi: ata_scsi_translate() direction check misses atap=
i_xlat()
- [Medium] ata: libata-scsi: missing ascq argument in ata_scsi_set_sense() =
calls
--

commit 876b457d8b81c6b456e4cdb4d8967b7f266646de
Author: Zhao Gongyi <zhaogongyi@bytedance.com>

ata: libata-scsi: reject data-in commands with a data-out buffer

This commit rejects simulated and translated data-in SCSI commands that are
submitted with a DMA_TO_DEVICE data direction to prevent writing replies in=
to
pages pinned without write access.

Link: https://lore.kernel.org/r/20261027090809.94126-1-zhaogongyi@bytedance=
.com

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 115b75a313bc5..6f1c0e6769bbf 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1978,6 +1978,19 @@ static int ata_scsi_translate(struct ata_device *d=
ev, struct scsi_cmnd *cmd,
>  	if (xlat_func(qc))
>  		goto done;
> =20
> +	/*
> +	 * A data-out request may contain pages pinned without write access.
> +	 * Reject a translated data-in command before issuing it, since its
> +	 * completion handler may write to the buffer even if the device fails.
> +	 */
> +	if (unlikely(cmd->sc_data_direction =3D=3D DMA_TO_DEVICE &&
> +		     ata_is_data(qc->tf.protocol) &&
> +		     !(qc->tf.flags & ATA_TFLAG_WRITE))) {

[Severity: High]
Does this direction check in ata_scsi_translate() catch ATAPI commands
translated via atapi_xlat()?

In drivers/ata/libata-scsi.c, atapi_xlat() unconditionally sets
ATA_TFLAG_WRITE whenever scmd->sc_data_direction is DMA_TO_DEVICE, without
checking whether the SCSI CDB is a data-in command:

drivers/ata/libata-scsi.c:atapi_xlat() {
	...
	qc->tf.flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
	if (scmd->sc_data_direction =3D=3D DMA_TO_DEVICE) {
		qc->tf.flags |=3D ATA_TFLAG_WRITE;
	}
	...
}

Because ATA_TFLAG_WRITE is set, the !(qc->tf.flags & ATA_TFLAG_WRITE) check
in ata_scsi_translate() evaluates to false for ATAPI commands.

If userspace submits an SG_IO request to an ATAPI device with
SG_DXFER_TO_DEV (DMA_TO_DEVICE), a non-empty buffer backed by read-only pag=
es
such as the shared zero page, and a standard INQUIRY CDB with allocation
length 0 (cmnd =3D {0x12, 0, 0, 0, 0, 0}), the device completes the PACKET
command without a data phase and without error.

On completion, atapi_qc_complete() invokes atapi_fixup_inquiry():

drivers/ata/libata-scsi.c:atapi_qc_complete() {
	...
	/* successful completion path */
	if (cmd->cmnd[0] =3D=3D INQUIRY && (cmd->cmnd[1] & 0x03) =3D=3D 0)
		atapi_fixup_inquiry(cmd);
	...
}

atapi_fixup_inquiry() then writes modified INQUIRY header bytes into the
command scatterlist via sg_copy_from_buffer():

drivers/ata/libata-scsi.c:atapi_fixup_inquiry() {
	u8 buf[4];

	sg_copy_to_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, 4);
	if (buf[2] =3D=3D 0) {
		buf[2] =3D 0x5;
		buf[3] =3D 0x32;
	}
	sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd), buf, 4);
}

Wouldn't this still trigger a kernel page fault when writing to the read-on=
ly
DMA_TO_DEVICE scatterlist pages?

> +		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
> +				   INVALID_FIELD_IN_CDB);
> +		goto done;
> +	}
> +
>  	return ata_scsi_qc_issue(ap, qc);
> =20
>  done:
> @@ -2009,6 +2022,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *=
dev, struct scsi_cmnd *cmd,
>  	unsigned long flags;
>  	unsigned int len;
> =20
> +	/* A data-out request may contain pages pinned without write access. */
> +	if (cmd->sc_data_direction =3D=3D DMA_TO_DEVICE) {
> +		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
> +				   INVALID_FIELD_IN_CDB);

[Severity: Medium]
Does this compile when CONFIG_ATA is enabled?

In drivers/ata/libata-scsi.c, ata_scsi_set_sense() takes five arguments
(dev, cmd, sk, asc, ascq):

void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
			u8 sk, u8 asc, u8 ascq)
{
	bool d_sense =3D (dev->flags & ATA_DFLAG_D_SENSE);

	scsi_build_sense(cmd, d_sense, sk, asc, ascq);
}

And in include/scsi/scsi_proto.h, INVALID_FIELD_IN_CDB is defined as a sing=
le
byte constant for asc:

#define INVALID_FIELD_IN_CDB		0x24

Both new calls to ata_scsi_set_sense() in ata_scsi_translate() and
ata_scsi_rbuf_fill() pass only four arguments, omitting the fifth ascq
argument (0x0), which causes a build failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028113903.1956=
9-1-zhaogongyi@bytedance.com?part=3D1
