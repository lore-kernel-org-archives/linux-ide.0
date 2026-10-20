Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485140;
	b=PhiVd6PHkqtY/f5yylVk5p9VF2fZAapJqtviait2NhkCu1vvF697MyQdO/885siLElHU
	 2zUiiSqwQPOEcOyXVjAtvVfdmB3mUd/HSxYbrhuvvgauRSE/XBpqqDbrdC1gQhhJizHUA
	 tHMcwpuXOf6zZgqOEy+lEBPEbf5li/jzWRwMTFo9pCZ5e+Xejo7Grki0yWyMvCyY+hACN
	 VjqEPAcfg5EpgG3PhuQgCV+gUv7bNmdZ/ZUrX13/Vatk3HTO8gSR/FLIclNOlFJFQKQrE
	 S+TZK5PvdE5A+JPhJCGPGl+q9JzXdTDlUXBgDIF8gmYWI5ZqEdUW/CTyHlWFX7LpbTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485140;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hEKIfCRtr3zRiaSni+9iuV0AWqdfcKLRiZbUdyKkmhQ=;
	b=2V3UJihrFz7824IEIjmwMVocy7B9IjHE27TogokLj/TWp7+5yph8G9w+VMF0iKNNRdm2
	 VxMeAYF4t+q+ToV6iooRPmERQtvr1cqNtl1fp4lQE/2t4A5lNAF0Dn65S5ZVQlCaefMwI
	 dkpyKMj17R5AZjNShhwytM8QSaEirXpFbAHfMW7FKY9A1lBNe+9/iCQw9bxWeKcnfmcIs
	 6Y7I9AS7ohKPLRlfq6CdcsTBQjm54d1uGKQzJZw/DTbd3QxnpDMMFQoeopjfs7fYYojzd
	 KM7pHyYJdK7cVnxnNzacVmmdmj2jcps1RXlmk9+kDcctircf6H1QOA47oFaI3DuHTKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2eAVotb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99A606A31C
	for <linux-ide@vger.kernel.org>; Tue, 20 Oct 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2eAVotb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFE91F000C9;
	Tue, 20 Oct 2026 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485140;
	bh=hEKIfCRtr3zRiaSni+9iuV0AWqdfcKLRiZbUdyKkmhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2eAVotbkSe+2Vs09nlZubdyPTHx/cKciVFBE/HsxwL4ZC2ilcr4R7ta+T9Rb8dff
	 J6NmuZcS3saMA2QJwXTTVl59rnfso1v/hGfwczE3wfbCHpZwdUodUjxZnAAsbfAg/a
	 AZA3iQdJFbzDwaRjavw9+1qcAZMkvTMxq2fpAdC0vZAndz+9dUBI5VyO2fzw+YKPJo
	 dN8OGp9snwVr0DfFCELnX45sPGhShqS9hmdMLKMt+7+P+kp9oEqhQbT5MlUDXZBuop
	 NxHfNUAU+Ig3dLRmKqk5SlXHRRpZ2Kp/ZkGwvhTeJNd7JK9ti+mMC/zf8IVYD+iNrl
	 ZLoQ92XXre6iw==
Message-ID: <sashiko-outbox-178562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ata: libata: skip sata_down_spd_limit() when no
 device is present
Reply-To: sashiko-reviews@lists.linux.dev
To: tongzhiwei <tongzhiwei@cmss.chinamobile.com>
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
In-Reply-To: <20261020032054.430-1-tongzhiwei@cmss.chinamobile.com>
References: <20261010075457.882-1-tongzhiwei@cmss.chinamobile.com>
 <20261020032054.430-1-tongzhiwei@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:32:19 +0000
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
- [High] ata: libata: sata_down_spd_limit() DET =3D=3D 0 check breaks link =
recovery
- [Medium] ata: libata: sata_down_spd_limit() DET check fails on replug and=
 LPM
--

commit 2169b3134adb850a6a9a8662fa4f3cc24faf938a
Author: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

ata: libata: skip sata_down_spd_limit() when no device is present

This commit changes sata_down_spd_limit() to return -EINVAL when reading
SCR_STATUS indicates that the SStatus DET field is 0, intending to prevent
probe attempts during a hot-unplug from lowering sata_spd_limit.

>     ata: libata: skip sata_down_spd_limit() when no device is present
>    =20
>     A hot-unplug goes through ata_eh_schedule_probe() -> ata_dev_init() ->
>     sata_spd =3D 0.  After commit 69f2c9346313 ("ata: libata: Fix
>     sata_down_spd_limit() when no link speed is reported"), when the devi=
ce
>     is unplugged, every probe lowers sata_spd_limit.  This breaks
>     commit 2dc0b46b5ea3 ("libata: sata_down_spd_limit should return
>     if driver has not recorded sstatus speed").
>    =20
>     As a result, when the device is plugged back in, it is limited to a
>     low speed that is never recovered.
>    =20
>     Use the SStatus DET field to detect the no-device case and bail out
>     of sata_down_spd_limit() when no device is present (DET =3D=3D 0).
>    =20
>     Fixes: 69f2c9346313 ("ata: libata: Fix sata_down_spd_limit() when no =
link speed is reported")
>     Assisted-by: LLM
>     Signed-off-by: tongzhiwei <tongzhiwei@cmss.chinamobile.com>

[Severity: Medium]
Is this description of how sata_spd_limit persists across hot-unplug probes
accurate, and does checking for (sstatus & 0xf) =3D=3D 0 inside
sata_down_spd_limit() actually avoid the speed drop when a drive is plugged
back in?

At the beginning of every ata_eh_schedule_probe() call, ata_dev_init()
already resets link->sata_spd_limit back to link->hw_sata_spd_limit:

drivers/ata/libata-eh.c:ata_eh_schedule_probe()
    ata_eh_detach_dev(dev);
    ata_dev_init(dev);
    ...
    ata_ering_record(&dev->ering, 0, AC_ERR_OTHER);
    ata_ering_map(&dev->ering, ata_count_probe_trials_cb, &trials);

    if (trials > ATA_EH_PROBE_TRIALS)
        sata_down_spd_limit(link, 1);

What actually persists across ata_dev_init() is dev->ering, which is only
cleared once ata_dev_read_id() succeeds in ata_eh_revalidate_and_attach().

When a device is hot-unplugged and plugged back in within
ATA_EH_PROBE_TRIAL_INTERVAL (60 seconds), the unplugged probes accumulate
entries in dev->ering. On the subsequent plug-in probe, ata_eh_recover()
calls ata_eh_schedule_probe() before ata_eh_reset(). Because the drive is n=
ow
physically attached, SStatus.DET (sstatus & 0xf) is already 0x1 or 0x3 when
ata_eh_schedule_probe() increments trials past ATA_EH_PROBE_TRIALS (2) and
calls sata_down_spd_limit(link, 1). Doesn't (sstatus & 0xf) =3D=3D 0 evalua=
te to
false on that plug-in probe and still force the reconnected drive down to
1.5 Gbps?

Also, what happens when Link Power Management (LPM) is enabled on an empty
port (such as ATA_LPM_MED_POWER_WITH_DIPM, ATA_LPM_MIN_POWER_WITH_PARTIAL, =
or
ATA_LPM_MIN_POWER)? In drivers/ata/libata-sata.c:sata_link_scr_lpm():

		} else {
			/* empty port, power off */
			scontrol &=3D ~0xf;
			scontrol |=3D (0x1 << 2);
		}

sata_link_scr_lpm() sets SControl.DET to 0x4, causing SStatus.DET to report
0x4 (PHY offline) instead of 0x0. Similarly, some controllers leave
SStatus.DET stuck at 0x1 after hot-unplugging, as noted in
sata_link_debounce(). In both cases, wouldn't (sstatus & 0xf) =3D=3D 0 also=
 be
bypassed while no device is present?

> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index ad40f516c6d43..775da21cbbae7 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -549,6 +549,9 @@ int sata_down_spd_limit(struct ata_link *link, u32 sp=
d_limit)
>  	 * If not, use cached value in link->sata_spd.
>  	 */
>  	rc =3D sata_scr_read(link, SCR_STATUS, &sstatus);
> +	/* No device present (DET =3D=3D 0): nothing to recover by lowering spe=
ed. */
> +	if (rc =3D=3D 0 && (sstatus & 0xf) =3D=3D 0)
> +		return -EINVAL;

[Severity: High]
Won't bailing out of sata_down_spd_limit() on an instantaneous
(sstatus & 0xf) =3D=3D 0 read break link speed step-down recovery when a
connected device fails speed negotiation or drops its link?

For example, when SStatus.DET is oscillating (such as cycling between 0 and=
 1
when high-speed negotiation fails), sata_link_debounce() returns -EPIPE so
that the caller lowers the link speed:

drivers/ata/libata-sata.c:sata_link_debounce()
		/* Check deadline.  If debouncing failed, return
		 * -EPIPE to tell upper layer to lower link speed.
		 */
		if (time_after(jiffies, deadline))
			return -EPIPE;

drivers/ata/libata-eh.c:ata_eh_reset()
	} else if (rc =3D=3D -EPIPE)
		sata_down_spd_limit(failed_link, 0);

Likewise, ata_eh_reset() calls sata_down_spd_limit(link, 0) when
try =3D=3D max_tries - 1, ata_eh_schedule_probe() calls
sata_down_spd_limit(link, 1) to recover from failed link speed negotiations
that cause repeated DEVXCHG or PHRDY CHG events, and ata_eh_speed_down()
calls sata_down_spd_limit(link, 0) when a previously established link (with
link->sata_spd recorded) suffers errors and drops.

If sata_scr_read() in sata_down_spd_limit() samples SCR_STATUS while the
dropped or oscillating link has DET =3D=3D 0, won't this check return -EINV=
AL and
prevent libata from stepping down link->sata_spd_limit to recover the devic=
e?

>  	if (rc =3D=3D 0 && ata_sstatus_online(sstatus))
>  		spd =3D (sstatus >> 4) & 0xf;
>  	else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020032054.430-=
1-tongzhiwei@cmss.chinamobile.com?part=3D1
