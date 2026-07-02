Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423887081A
	for <linux-ide@vger.kernel.org>; Thu,  2 Jul 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958453; cv=none; b=sqEQ7IXJGnLik0f69fCqUO8bP8ijYay/k1/Pi0wr6leIwyRn3So61fBl6yKaYj9TXTgPapMLj/le6VvK86rjSGOcxzUdtvltCdCK633wVHDfQG+XNJfezkb9ooY82UjSLX+lNcCB2bY7MRpK1au1xqtPlaDfrBBdxs9TZq74GT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958453; c=relaxed/simple;
	bh=K6QkQL16lUWuh+uhXW4BYTHZkr+MrizcYiR59m3gPD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwiGj3lfnsT9K0x1zFhl188VGcFxVGTKXH4NLJEZHxVEsow1PhjTzxStUJ94F+Sc6717OxpVxuFZCCREYZHXBs0+wu55FoP0nuH64dSq23/p6usCylxjsitaM5U11k6UTiHXv4/bjcOeCdGqaZBMMjztJa1OS6cBPH3vpe5gG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/nLutu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/nLutu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01331F000E9;
	Thu,  2 Jul 2026 02:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958451;
	bh=+hnyotckuqi6T3zftHGuTRmQ5ucKsKgkOqs4ehckGmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/nLutu39ObG3IWiuZulzKDpFhH9Weuy+wloL6vFsA/o1ioH0TtglZUua7w7o+Ir7
	 B4y1c5sxKe0r7FlwIIJ1fk2WpIehT5dux9+gO9K5nwmpDuWawehFo3Ri4PpOfW77dS
	 g8SNfNcfpMXZGA7xnPdhWb/TyvkGuPzCfnDNmLeCA99fRADhQG0tfxZsGfWIM73Ra7
	 drggUgHoHXRjqTfjqqwSRqssTWEK5u2N2H/KlojacMa1xdHN5WZCRJjha8Q9T1jvBs
	 Kpc61Zy10PgT3JewfArH3M636D5sONdzKfg7QiNkyMqV+gYYNObbRNLHUWhYxW8nLE
	 J24++lnsWXUBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy
 to response length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karuna Ramkumar" <rkaruna@google.com>
Cc: dlemoal@kernel.org, cassel@kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20260702020142.3399851-1-rkaruna@google.com>
References: <20260702020142.3399851-1-rkaruna@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:14:11 +0000
Message-Id: <20260702021411.B01331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The defensive bounds check `WARN_ON(len > ATA_SCSI_RBUF_SIZE)`=
 is ineffective because it evaluates after the `actor` callback has already=
 performed an out-of-bounds write.
--

commit 41acccb75ba899e5e72a927d95a97d5d6f088c63
Author: Karuna Ramkumar <rkaruna@google.com>

ata: libata-scsi: limit simulated SCSI command copy to response length

This patch limits the sg_copy_from_buffer() size to the actual response len=
gth
instead of the full buffer size to avoid overwriting the tail of the transf=
er
buffer. It also adds a bounds check on the length returned by the actor
function to abort if it exceeds the static buffer capacity.

> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a6..836981b176c7d 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1933,8 +1933,13 @@ static void ata_scsi_rbuf_fill(struct ata_device *=
dev, struct scsi_cmnd *cmd,
>  	memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
>  	len =3D actor(dev, cmd, ata_scsi_rbuf);
>  	if (len) {
> +		if (WARN_ON(len > ATA_SCSI_RBUF_SIZE)) {
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
This is a pre-existing issue, but does this defensive bounds check actually
prevent memory corruption?

Because the check evaluates after the actor callback has already executed,
the actor function may have already performed an out-of-bounds write. For
example, a malicious or buggy ATA device reporting a large number of
Concurrent Positioning Ranges (nr_cpr up to 255) could cause
ata_scsiop_inq_b9() to write up to 8224 bytes into the 2048-byte statically
allocated ata_scsi_rbuf array:

drivers/ata/libata-scsi.c:ata_scsiop_inq_b9() {
	...
	for (i =3D 0; i < cpr_log->nr_cpr; i++, desc +=3D 32) {
		desc[0] =3D cpr_log->cpr[i].num;
		desc[1] =3D cpr_log->cpr[i].num_storage_elements;
		put_unaligned_be64(cpr_log->cpr[i].start_lba, &desc[8]);
		put_unaligned_be64(cpr_log->cpr[i].num_lbas, &desc[16]);
	}
	...
}

Should the actor functions be modified to take a buffer size parameter so
they can safely enforce limits before writing memory?

> +			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
> +			spin_unlock_irqrestore(&ata_scsi_rbuf_lock, flags);
> +			return;
> +		}
>  		sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
> -				    ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
> +				    ata_scsi_rbuf, len);
>  		cmd->result =3D SAM_STAT_GOOD;
>  		if (scsi_bufflen(cmd) > len)
>  			scsi_set_resid(cmd, scsi_bufflen(cmd) - len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702020142.3399=
851-1-rkaruna@google.com?part=3D1
