Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193960;
	b=Nnr8YmuY4G95LwKmVn0genzHDAWhyqONlQnlVDeO3nHlwCNnu8nWxDIljYHtkmV6BO44
	 eif6swPT2IAJhn/0ZiWyFNJTuqS7/z+TZcjI69pdw5pBPo2Qffg9/8BDuWcYxInXPxFDO
	 D6sf4KMCLSO02dKCQOUvFUSWJ50rSwS3Rw8gB25wOJs8oh5DPi7ZaQtDVhQYvxCL9g1Sf
	 msSJWSWMBnkucNZTKeOZ1gO0gQ9HoysBhROQF+ugd/7+u9PHLD3dC/gH3UbvXhilZQk8S
	 CI1sViOlzqS3B0N6z/EdsEHg3FZWc6EbB2KOtwQ8xGXXiUqvETXxruWrWYotqR+4Tiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193960;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=tlfo139l9Rt2nBgX8WizNIcclCtcY/yZ2WQFmqA3Bow=;
	b=HxVRw5d/hi3G4AYBf+pPNkWXdpXDNPnC8Q59NEdWfdVmm7aheh9zuDg/Wa5mKuoP0Lvg
	 hBQ0SpHA0Mcnneq4TnM2P3OAY+iTPIwsXVGEc8KRq9ttK4lBZzA77tS02tQ1WiqZfHfti
	 t39jDY7Wey++0mdtfD42sR26Q+HeZp4lNVI4X1sQryi4gXeAx/D3i/kF4IQH0lrTVNeea
	 9zd8P0g845fzYtKE/U+rhmE122+ZnXUnutfSElQ5zlFLaghEZx7EQ6JAc8xUXHiMix0ZZ
	 wGR1s+9R0bFYtARjLVuY69aLCu7UhSH+5JbT9FfpggLQT2UfaeKIBF/bWCt0CYtx0vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dF0hgEbV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="Jb7UaO0/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41016606A31F
	for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 13:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41016606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dF0hgEbV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Jb7UaO0/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793193959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlfo139l9Rt2nBgX8WizNIcclCtcY/yZ2WQFmqA3Bow=;
	b=dF0hgEbV8AhFN2zb2Wu3mgy2nn7MThPE/QEm7G6J4B+RNW93L2MrVJDKf8hvHMehsR9iNA
	I72gvjJy1P6sIU0vzrRFc2un64R0S0nVfZCN0mtSDvU7sJ9pELZhy3zlAWoUvBKzH48wjj
	0QkCAUu3ewEwH5KRgnzCsTN7IiX36uY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Vdg7IBlINc2D3tA2414D-w-1; Wed, 28 Oct 2026 09:25:58 -0400
X-MC-Unique: Vdg7IBlINc2D3tA2414D-w-1
X-Mimecast-MFC-AGG-ID: Vdg7IBlINc2D3tA2414D-w_1793193957
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7bf71bbf197so772561137.2
        for <linux-ide@vger.kernel.org>; Wed, 28 Oct 2026 06:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793193957; cv=none;
        d=google.com; s=arc-20260327;
        b=ct93bw3wAeZZ4cV736JM2C9AQjUX5bs64ZKp5C1IkuwA+TtkHIQgtamJNdMDHujXnz
         6oOnXgcWftukUY8QJ1KbPqGhpoO/4Jdt1++1XClJZeJHGZDaXeXfz6aTdp9YcSSBr2JZ
         tvPl5E7tA+qKsxLdC4rV96sn7krgqcm1MD0zaUWrHoGJ/qHS7JTSxPeGmHmnif73STEi
         PzwYPZVFOJhf1ebf+HVVjU633OX5L+u6c7m4Q/uRboARgGmzlLnERmidvADPzTsLdmXa
         5rCXpGIcDYgqyvvoZP9UyuCVIL6xAeYUF6LJpy4lziX0lSFozf7In8BWXT5tJWuwWGMX
         9QfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tlfo139l9Rt2nBgX8WizNIcclCtcY/yZ2WQFmqA3Bow=;
        fh=CevGES2AFLxh77zkXsdBdBroN5O9WERkcETXwr7159A=;
        b=mhEs6HenU5WD+Ph2jg3FtEPdyY8nn1Tu5Lls0JWs6WvJMwtQUzNAOvG6NDk8akZ7HE
         CulJVNM9MrZhC2VPHaIRxk8qUBXbT1GTQffZwhWwxklRvgDW5ZKssNaSlA7uVICf4HuR
         0BtyGu4yWPjgdacLJ/D+G8xY9jvH6F0W3WFd0vFKt5dqgV5U/YnjdD62LIQiV0USxcPi
         nhTCrY5CEzc0P1BSh4Onll82icsqBsMVktd6rBVVygxMVyXEChx2QMjIPsbU740MNA4r
         zifqxah+chPJtIvYuUgEyUzMTkz5hZYsCCKK5p411pEWZERuCO+tDW60tYBw67A71ca/
         KeKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793193957; x=1793798757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tlfo139l9Rt2nBgX8WizNIcclCtcY/yZ2WQFmqA3Bow=;
        b=Jb7UaO0/8rsLC18fXofAhANCuCu3Jzo+Axkl+UmrQzvsKU0oxPI4WwutdItKMSvHw2
         f2iClur19urn1TW1PeRf0qteN1Ap5Q6QBzpkWN2yoJ3deZEY9TYbfefDX5LjreKHAOWs
         VISMmdDRDPfwMAwaG038q/G1r5xV86K2PnusSjPzYfVRtRR62DVtvFpUFiS+BMwAjTLJ
         PYWTJ8qEs/JtPnBTdOedLkhK2JCcZlzutY0FImzXGP7jznqiPJkR2TDgRP2nwxkBQy7u
         8+XOVJYKK8sE45X30QFLZf009EeGGOaZF2dfn3Z3/Rem8TkD6FNNs9A/t5ONJMFkN7UJ
         cP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193957; x=1793798757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlfo139l9Rt2nBgX8WizNIcclCtcY/yZ2WQFmqA3Bow=;
        b=1xBM4nL9x31we1Yyal2dRRVIg7xqpQuiDd16OHuzY3JBwK44KRBlT1FNn0lKDBmxpt
         pjOjhahz6xcND4XeduOSCQ+T26HjIhCO68jL5sJUN72itS/y/18YGpjT+lw9ubrSaYzg
         It4tavBEJ2mS8IZMJbwIYZI+5aOuXXs//6vS04NkGjEtnZyYMbChu5dbTXVOb+Llz0Rh
         PoUHrp+gVI/UNTKjgALDXqK4S28xSbxS+lri9scP/vbiVJUqaCfY7etW4mIdzK0huSOW
         wfPK6sQngrcjHcEKKRj9KTwCnmxgOzyBPahzpjpcGCWZBDnuSDH6psbPp5hnmbbn1bf6
         TuzA==
X-Gm-Message-State: AFq9FYL3QadpSc6ww9/PGeYg/VNn3sNerZXXliRTergNgW+rztQ008sl
	WxITr6qjlZHk0kn7tTUGPgBGa4uSi9fSCNZDGbMYcT5fhFwp+OwWIRrA8CqY5Uf08vr509WMuJ7
	kIp6zYK5eCDGtaVlbrrq6Ti6QIJH+yRxlASpmZotWMVYgbVdw+GDtHRkj23DQNTrZfT65tL48nf
	LG8T6Cp8blLv3hdgZEIj2k6DBJ94ezKP99FoJ8
X-Gm-Gg: AYBFou0q+SvrTwwL9YbjjFBGelRDgDpL8NND0aYlNU2lKdfM7Sb2LPF6nZJvOvhslK4
	hMN8Y3vmHEOIqoamGOV6SrIxs169mhhWiP2/OQKeVHtGk2suz/R2xW8oXiQvMlSQKTVrw2ipt44
	Obsl7DjapJqpVWEwK3ET8RCIl3d/Cr9ZDbqqCM3pqp3Fou983OWFW1R0rHRqf8KCLfBNCR/KL9u
	6qr4z5ohN6UbmWzaQ==
X-Received: by 2002:a05:6102:370e:b0:7c3:881f:b775 with SMTP id ada2fe7eead31-7d03a52b5bfmr973847137.24.1793193957136;
        Wed, 28 Oct 2026 06:25:57 -0700 (PDT)
X-Received: by 2002:a05:6102:370e:b0:7c3:881f:b775 with SMTP id
 ada2fe7eead31-7d03a52b5bfmr973836137.24.1793193956565; Wed, 28 Oct 2026
 06:25:56 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028124328.597603-1-tvignaud@redhat.com> <sashiko-outbox-187886@kernel.org>
In-Reply-To: <sashiko-outbox-187886@kernel.org>
From: Thierry Vignaud <tvignaud@redhat.com>
Date: Wed, 28 Oct 2026 14:25:44 +0100
X-Gm-Features: AclHuK8LsLqbfPmBZ2pOrZsCXcU2SBtbZa9moKq_kUk7jaKZzWyvHeARHRw0soE
Message-ID: <CAHSMvrFXEnsLKF_BSYWz=V=ht6++RocuHJO0tkhUmPcHHvXp5A@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
To: sashiko-reviews@lists.linux.dev
Cc: linux-ide@vger.kernel.org, dlemoal@kernel.org, cassel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 1:59=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] ata: libata-core: overly broad 1.5Gbps and NONCQ quirks for PNY =
1TB SATA SSD
> --
>
> commit 0d9a8ef67d5864f02d54ceedd7d99487c051f554
> Author: Thierry Vignaud <tvignaud@redhat.com>
>
> ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
>
> This commit adds an entry to __ata_dev_quirks[] for the "PNY 1TB SATA SSD=
"
> drive with ATA_QUIRK_NOLPM, ATA_QUIRK_1_5_GBPS, and ATA_QUIRK_NONCQ acros=
s
> all firmware revisions.
>
> > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > index dadcaf9ff4622..cf36f2638fab3 100644
> > --- a/drivers/ata/libata-core.c
> > +++ b/drivers/ata/libata-core.c
> > @@ -4398,6 +4398,11 @@ static const struct ata_dev_quirks_entry __ata_d=
ev_quirks[] =3D {
> >       /* PNY CS900 (Phison PS3111-S11, DRAM-less) drops the link on DIP=
M */
> >       { "PNY CS900 1TB SSD",          NULL,   ATA_QUIRK_NOLPM },
> >
> > +     /* PNY CS900 (variant) drops the link on DIPM and NCQ */
> > +     { "PNY 1TB SATA SSD",           NULL,   ATA_QUIRK_NOLPM |
> > +                                             ATA_QUIRK_1_5_GBPS |
> > +                                             ATA_QUIRK_NONCQ },
>
> [Severity: High]
> Could applying ATA_QUIRK_1_5_GBPS and ATA_QUIRK_NONCQ across all firmware
> revisions (NULL) of "PNY 1TB SATA SSD" cause a severe performance regress=
ion
> for other users of this drive?
>
> During ata_dev_configure() -> ata_dev_quirks(), every "PNY 1TB SATA SSD" =
will
> match this entry regardless of firmware revision. In ata_do_link_spd_quir=
k(),
> ATA_QUIRK_1_5_GBPS clamps the physical SATA link speed limit to 1.5 Gbps:
>
> drivers/ata/libata-core.c:ata_do_link_spd_quirk() {
>         if (dev->quirks & ATA_QUIRK_1_5_GBPS)
>                 target =3D 1;
>         else
>                 return 0;
>
>         target_limit =3D (1 << target) - 1;
>
>         /* if already on stricter limit, no need to push further */
>         if (plink->sata_spd_limit <=3D target_limit)
>                 return 0;
>
>         plink->sata_spd_limit =3D target_limit;
> }
>
> Unlike ATA_QUIRK_NOLPM and ATA_QUIRK_NONCQ, force_tbl[] has no on/off ent=
ry
> for ATA_QUIRK_1_5_GBPS, so users with working drives cannot override this
> 1.5 Gbps cap via libata.force. Meanwhile, ata_dev_config_ncq() also disab=
les
> NCQ completely when ATA_QUIRK_NONCQ is set.
>
> Additionally, the commit title and opening description state:
>
>   For a year, I workaround it by disabling NCQ & reducing the speed by
>   booting with "libata.force=3D0:3.0Gbps,0:noncq".
>   It turns out disabling LPM fixes it without the huge performance hit.
>
> while the embedded "v2:" changelog notes and the code itself instead drop=
 the
> speed to 1.5 Gbps, disable NCQ, and remove the firmware revision filter, =
and
> the code comment above the entry does not mention the 1.5 Gbps limit.
>
> Note also that in ata_port_alloc(), port IDs (ap->print_id) are allocated
> starting at 1:
>
> drivers/ata/libata-core.c:ata_port_alloc() {
>         id =3D ida_alloc_min(&ata_ida, 1, GFP_KERNEL);
>         if (id < 0) {
>                 kfree(ap);
>                 return NULL;
>         }
>         ap->print_id =3D id;
> }
>
> Because port numbering starts at 1, "libata.force=3D0:3.0Gbps,0:noncq" ne=
ver
> matched any port in ata_force_link_limits() or ata_force_quirks(), which =
matches
> the commit message logs on sda still showing queued commands (tag#2 throu=
gh
> tag#9).

I actually used the prefix "1:" eg :
ao=C3=BBt 01 09:17:31 localhost kernel: Command line:
BOOT_IMAGE=3D/boot/vmlinuz-7.0.1-desktop-1.mainline.mga10
root=3DUUID=3D95a19996-436f-4ce1-9779-26b13c319972 ro splash quiet noiswmd
resume=3DUUID=3D18acfa47-8d6c-46f4-9700-5c9506931817 audit=3D0
libata.force=3D1:3.0Gbps,1:noncq

I mistakely changed it to ":0" a cople weeks ago, which showed again
the issues, which is why I worked on this patch:
oct. 23 10:05:59 localhost kernel: Command line:
BOOT_IMAGE=3D/boot/vmlinuz-7.3.0-desktop-1.mainline.mga11
root=3DUUID=3D95a19996-436f-4ce1-9779-26b13c319972 ro splash quiet noiswmd
resume=3DUUID=3D18acfa47-8d6c-46f4-9700-5c9506931817 audit=3D0
libata.force=3D0:3.0Gbps,0:noncq,0:nolpm

I used the 1.5Gbps quirk in the patch b/c there's no 3.0Gbps in drivers/ata
I could add such a quirk now that there's 64 bits for quirks but
honestly that shouldn't impact much this low end SSD.

> If a specific drive requires 1.5 Gbps, no NCQ, and no LPM simultaneously =
to
> avoid link timeouts, could that indicate a local cable, controller, or ha=
rdware
> unit issue rather than a quirk that should be applied unconditionally to =
all
> "PNY 1TB SATA SSD" drives and firmware revisions?

I'm not the first one to reports issues with that SSD, see eg:
https://forums.linuxmint.com/viewtopic.php?t=3D424548
https://www.truenas.com/community/threads/help-zfs-continue-failing-with-po=
ol-i-o-failures.110424/
=3D> https://web.archive.org/web/20260319124414/https://www.truenas.com/com=
munity/threads/help-zfs-continue-failing-with-pool-i-o-failures.110424/

So PNY CS900 looks buggy across all sizes, at least under Linux.
So actually my patch won't cover all affected CS900 b/c it only covers
the "1Gb" model.
I can add the firmware revision to the quirk if you insist though.

