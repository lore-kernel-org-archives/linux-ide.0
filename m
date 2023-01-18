Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D93C32793
	for <linux-ide@archiver.kernel.org>; Wed, 18 Jan 2023 19:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARTnu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 18 Jan 2023 14:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARTnr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2023 14:43:47 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37295867D
        for <linux-ide@vger.kernel.org>; Wed, 18 Jan 2023 11:43:43 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=Y3MbRxuwuZJWa2jdikaqPO+ghfhhpjWAOEnOigpf9AQ=;
        b=IlpgNb4lmBXW8y6KIT5VTmxVVwir9sP6FVkgNc7rNoEVTZmu1BPwV7bMs0UgirddoweE04yaoYdqBHbVEveR879OLQ/myTE+4tW+lkPZAqivknNqPDEIcABsY/TWxj/4t3jbhByRLtgKavVXXiI2tN7LBNlGepTuO3QMIyKAocspkB2sPhaOaPoay8Xb5I5wvWMHhcP3jMAXYiEBL984ik2QHidG6J9B2b7UVh7BDdMpOmU0JxldwSZGiI
        h6cUZGJmHWFTI9NAWeGaN4omPuob347ZiFNvDUM387vrzAnaZ3es1hfAkMhnbFKd0JL0+5mo5ghzgkViD77aqzUsNqbg==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Wed, 18 Jan 2023 19:43:41 +0000
MIME-Version: 1.0
Date:   Wed, 18 Jan 2023 19:43:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <41774337-a8d9-a2de-72ea-27b6016ff720@opensource.wdc.com>
References: <41774337-a8d9-a2de-72ea-27b6016ff720@opensource.wdc.com>
 <b6d818c162b14cc508f5cdb14c6e88a9@psihoexpert.ro>
 <125bd8a6-7a1c-cd08-b5ee-da5a24f79f21@opensource.wdc.com>
 <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
 <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
 <97af1ef9ed605800e6ad43b7b3518800@psihoexpert.ro>
 <aa61bc53-34e2-4f19-962f-888e9daabbb4@opensource.wdc.com>
 <C9DCFF5E79814EAB9E9BE94B81A1CD7F@graph>
 <889ee9c9e77106b17ceac456e327d480@psihoexpert.ro>
 <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
 <77b389a080646567b9f9d44caa42d547@psihoexpert.ro>
 <da1d366a494469a46eb066b167613e21@psihoexpert.ro>
 <d42ddd29171c69e9a6628bfc2b100aca@psihoexpert.ro>
X-Originating-IP: 86.123.22.43
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 17, 2023 10:27 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> Could you try adding messages in the function sata_down_spd_limit() ?
> I recall that during probe, scr status does not give a current speed,
> which creates the problem of triggering that "return -EINVAL" in the el=
se
> for "if (spd > 1)"...
>=20
>=20What I would like you to print is:
>=20
>=20diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 884ae73b11ea..ad68f86be1c5 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3081,14 +3081,21 @@ int sata_down_spd_limit(struct ata_link *link, =
u32
> spd_limit)
> if (!sata_scr_valid(link))
> return -EOPNOTSUPP;
>=20
>=20+ pr_info("sata_down_spd_limit: limit 0x%0x, cur spd 0x%0x, "
> + "saved limit 0x%0x, hw limit 0x%0x\n",
> + spd_limit, link->sata_spd
> + link->sata_spd_limit, link->hw_sata_spd_limit);
> +
> /* If SCR can be read, use it to determine the current SPD.
> * If not, use cached value in link->sata_spd.
> */
> rc =3D sata_scr_read(link, SCR_STATUS, &sstatus);
> - if (rc =3D=3D 0 && ata_sstatus_online(sstatus))
> + if (rc =3D=3D 0 && ata_sstatus_online(sstatus)) {
> spd =3D (sstatus >> 4) & 0xf;
> - else
> + pr_info("spd from STS: 0x%0x\n", spd);
> + } else {
> spd =3D link->sata_spd;
> + }
>=20
>=20mask =3D link->sata_spd_limit;
> if (mask <=3D 1)
>=20
>=20Please try printing that in addition to the messages you already have=
. And
> please try with default boot (no ata options) and with the 1.5gbps forc=
e
> (since that is the only one working).
>=20
>=20--
> Damien Le Moal
> Western Digital Research

---- no limit ----
[ 73.075849][ T112] hardreset, Online=3D>Offline
[ 73.075856][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 73.080328][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 73.085601][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 73.091900][ T112] __sata_set_spd_needed, target=3D0x0
[ 73.098386][ T112] __sata_set_spd_needed, spd=3D0x0
[ 73.103475][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
[ 73.109363][ T112] resume, do loop
[ 73.343477][ T112] resume, after do loop
[ 73.403476][ T112] debounce, SCR=3D0x101
[ 73.463496][ T112] debounce, SCR=3D0x101
[ 73.523476][ T112] debounce, SCR=3D0x100
[ 73.583476][ T112] debounce, SCR=3D0x100
[ 73.643475][ T112] debounce, SCR=3D0x100
[ 73.703475][ T112] debounce, SCR=3D0x100
[ 73.763475][ T112] debounce, SCR=3D0x100
[ 73.823475][ T112] debounce, SCR=3D0x101
[ 73.883475][ T112] debounce, SCR=3D0x100
[ 73.943475][ T112] debounce, SCR=3D0x100
[ 74.003475][ T112] debounce, SCR=3D0x100
[ 74.063475][ T112] debounce, SCR=3D0x100
[ 74.123475][ T112] debounce, SCR=3D0x100
[ 74.183475][ T112] debounce, SCR=3D0x0
[ 74.243475][ T112] debounce, SCR=3D0x0
[ 74.303475][ T112] debounce, SCR=3D0x0
[ 74.363475][ T112] debounce, SCR=3D0x0
[ 74.423475][ T112] debounce, SCR=3D0x100
[ 74.427159][ T112] resume, return at end of function
[ 74.431015][ T112] hardreset, ata_phys_link_offline check failed
[ 74.436114][ T112] ata2: SATA link down (SStatus 100 SControl 300)
[ 74.448580][ T112] hardreset, Online=3D>Offline
[ 74.448586][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 74.453053][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 74.458318][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 74.464627][ T112] __sata_set_spd_needed, target=3D0x0
[ 74.471100][ T112] __sata_set_spd_needed, spd=3D0x0
[ 74.476189][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
[ 74.482076][ T112] resume, do loop
[ 74.713476][ T112] resume, after do loop
[ 74.773475][ T112] debounce, SCR=3D0x101
[ 74.833475][ T112] debounce, SCR=3D0x100
[ 74.883500][ T112] debounce, SCR=3D0x100
[ 74.943476][ T112] debounce, SCR=3D0x100
[ 75.003475][ T112] debounce, SCR=3D0x100
[ 75.063475][ T112] debounce, SCR=3D0x101
[ 75.123475][ T112] debounce, SCR=3D0x100
[ 75.183475][ T112] debounce, SCR=3D0x101
[ 75.243475][ T112] debounce, SCR=3D0x100
[ 75.303475][ T112] debounce, SCR=3D0x100
[ 75.363475][ T112] debounce, SCR=3D0x100
[ 75.423476][ T112] debounce, SCR=3D0x100
[ 75.483475][ T112] debounce, SCR=3D0x100
[ 75.543495][ T112] debounce, SCR=3D0x100
[ 75.603475][ T112] debounce, SCR=3D0x100
[ 75.663475][ T112] debounce, SCR=3D0x100
[ 75.723475][ T112] debounce, SCR=3D0x101
[ 75.783475][ T112] debounce, SCR=3D0x100
[ 75.843475][ T112] debounce, SCR=3D0x100
[ 75.903475][ T112] debounce, SCR=3D0x100
[ 75.963475][ T112] debounce, SCR=3D0x100
[ 76.023475][ T112] debounce, SCR=3D0x100
[ 76.083475][ T112] debounce, SCR=3D0x100
[ 76.143475][ T112] debounce, SCR=3D0x100
[ 76.203475][ T112] debounce, SCR=3D0x100
[ 76.263475][ T112] debounce, SCR=3D0x100
[ 76.323475][ T112] debounce, SCR=3D0x100
[ 76.327332][ T112] resume, return at end of function
[ 76.331189][ T112] hardreset, ata_phys_link_offline check failed
[ 76.336287][ T112] ata2: SATA link down (SStatus 100 SControl 300)
[ 76.348747][ T112] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved li=
mit 0xffffffff, hw limit
0xffffffff
[ 76.358641][ T112] hardreset, Online=3D>Offline
[ 76.358646][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 76.363113][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 76.368377][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 76.374687][ T112] __sata_set_spd_needed, target=3D0x0
[ 76.381160][ T112] __sata_set_spd_needed, spd=3D0x0
[ 76.386254][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
[ 76.392141][ T112] resume, do loop
[ 76.623476][ T112] resume, after do loop
[ 76.683475][ T112] debounce, SCR=3D0x100
[ 76.743475][ T112] debounce, SCR=3D0x101
[ 76.803475][ T112] debounce, SCR=3D0x100
[ 76.863475][ T112] debounce, SCR=3D0x100
[ 76.923475][ T112] debounce, SCR=3D0x100
[ 76.983476][ T112] debounce, SCR=3D0x100
[ 77.043475][ T112] debounce, SCR=3D0x100
[ 77.103495][ T112] debounce, SCR=3D0x100
[ 77.163476][ T112] debounce, SCR=3D0x100
[ 77.223475][ T112] debounce, SCR=3D0x100
[ 77.283475][ T112] debounce, SCR=3D0x101
[ 77.343475][ T112] debounce, SCR=3D0x100
[ 77.403475][ T112] debounce, SCR=3D0x101
[ 77.463475][ T112] debounce, SCR=3D0x100
[ 77.523475][ T112] debounce, SCR=3D0x100
[ 77.583475][ T112] debounce, SCR=3D0x100
[ 77.643475][ T112] debounce, SCR=3D0x100
[ 77.703475][ T112] debounce, SCR=3D0x100
[ 77.763475][ T112] debounce, SCR=3D0x100
[ 77.823475][ T112] debounce, SCR=3D0x100
[ 77.883475][ T112] debounce, SCR=3D0x100
[ 77.943475][ T112] debounce, SCR=3D0x101
[ 78.003475][ T112] debounce, SCR=3D0x100
[ 78.063475][ T112] debounce, SCR=3D0x101
[ 78.123475][ T112] debounce, SCR=3D0x100
[ 78.183475][ T112] debounce, SCR=3D0x100
[ 78.243475][ T112] debounce, SCR=3D0x100
[ 78.303476][ T112] debounce, SCR=3D0x100
[ 78.363475][ T112] debounce, SCR=3D0x100
[ 78.423475][ T112] debounce, SCR=3D0x100
[ 78.483475][ T112] debounce, SCR=3D0x100
[ 78.543475][ T112] debounce, SCR=3D0x100
[ 78.603475][ T112] debounce, SCR=3D0x100
[ 78.663494][ T112] debounce, SCR=3D0x100
[ 78.667353][ T112] resume, return at end of function
[ 78.671209][ T112] hardreset, ata_phys_link_offline check failed
[ 78.676306][ T112] ata2: SATA link down (SStatus 101 SControl 300)
[ 78.688765][ T112] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved li=
mit 0xffffffff, hw limit
0xffffffff
[ 78.698659][ T112] hardreset, Online=3D>Offline
[ 78.698664][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 78.703131][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 78.708395][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 78.714704][ T112] __sata_set_spd_needed, target=3D0x0
[ 78.721177][ T112] __sata_set_spd_needed, spd=3D0x0
[ 78.726272][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
[ 78.732158][ T112] resume, do loop
[ 78.963475][ T112] resume, after do loop
[ 79.023475][ T112] debounce, SCR=3D0x100
[ 79.083476][ T112] debounce, SCR=3D0x100
[ 79.143475][ T112] debounce, SCR=3D0x101
[ 79.203476][ T112] debounce, SCR=3D0x100
[ 79.263475][ T112] debounce, SCR=3D0x101
[ 79.323475][ T112] debounce, SCR=3D0x100
[ 79.383475][ T112] debounce, SCR=3D0x100
[ 79.443476][ T112] debounce, SCR=3D0x100
[ 79.503475][ T112] debounce, SCR=3D0x100
[ 79.563475][ T112] debounce, SCR=3D0x100
[ 79.623475][ T112] debounce, SCR=3D0x100
[ 79.683475][ T112] debounce, SCR=3D0x101
[ 79.743475][ T112] debounce, SCR=3D0x100
[ 79.803475][ T112] debounce, SCR=3D0x101
[ 79.863475][ T112] debounce, SCR=3D0x100
[ 79.923475][ T112] debounce, SCR=3D0x101
[ 79.983475][ T112] debounce, SCR=3D0x100
[ 80.043475][ T112] debounce, SCR=3D0x101
[ 80.103475][ T112] debounce, SCR=3D0x100
[ 80.163475][ T112] debounce, SCR=3D0x100
[ 80.223495][ T112] debounce, SCR=3D0x101
[ 80.283476][ T112] debounce, SCR=3D0x100
[ 80.343475][ T112] debounce, SCR=3D0x100
[ 80.403475][ T112] debounce, SCR=3D0x100
[ 80.463475][ T112] debounce, SCR=3D0x100
[ 80.523475][ T112] debounce, SCR=3D0x100
[ 80.583475][ T112] debounce, SCR=3D0x100
[ 80.643475][ T112] debounce, SCR=3D0x100
[ 80.703475][ T112] debounce, SCR=3D0x100
[ 80.763475][ T112] debounce, SCR=3D0x100
[ 80.823475][ T112] debounce, SCR=3D0x100
[ 80.827332][ T112] resume, return at end of function
[ 80.831189][ T112] hardreset, ata_phys_link_offline check failed
[ 80.836288][ T112] ata2: SATA link down (SStatus 100 SControl 300)
[ 80.848748][ T112] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved li=
mit 0xffffffff, hw limit
0xffffffff
[ 80.858641][ T112] hardreset, Online=3D>Offline
[ 80.858646][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 80.863114][ T112] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 80.868377][ T112] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 80.874687][ T112] __sata_set_spd_needed, target=3D0x0
[ 80.881160][ T112] __sata_set_spd_needed, spd=3D0x0
[ 80.886255][ T112] __sata_set_spd_needed, final *scontrol=3D0x300
[ 80.892142][ T112] resume, do loop
[ 81.123500][ T112] resume, after do loop
[ 81.183476][ T112] debounce, SCR=3D0x100
[ 81.243475][ T112] debounce, SCR=3D0x100
[ 81.303475][ T112] debounce, SCR=3D0x100
[ 81.363476][ T112] debounce, SCR=3D0x100
[ 81.423476][ T112] debounce, SCR=3D0x100
[ 81.483475][ T112] debounce, SCR=3D0x100
[ 81.543475][ T112] debounce, SCR=3D0x100
[ 81.603475][ T112] debounce, SCR=3D0x100
[ 81.663475][ T112] debounce, SCR=3D0x100
[ 81.667334][ T112] resume, return at end of function
[ 81.671190][ T112] hardreset, ata_phys_link_offline check failed
[ 81.676288][ T112] ata2: SATA link down (SStatus 100 SControl 300)
[ 81.688731][ T112] ata2: EH pending after 5 tries, giving up

---- limit 1.5Gbps ----

[ 19.819298][ T112] hardreset, Online=3D>Offline
[ 19.819306][ T112] sata_set_spd_needed, scontrol=3D0x310
[ 19.823798][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 19.829052][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 19.834752][ T112] __sata_set_spd_needed, target=3D0x1
[ 19.840614][ T112] __sata_set_spd_needed, spd=3D0x1
[ 19.845703][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 19.851592][ T112] resume, do loop
[ 20.083568][ T112] resume, after do loop
[ 20.143567][ T112] debounce, SCR=3D0x113
[ 20.203567][ T112] debounce, SCR=3D0x113
[ 20.263567][ T112] debounce, SCR=3D0x113
[ 20.323566][ T112] debounce, SCR=3D0x113
[ 20.383566][ T112] debounce, SCR=3D0x113
[ 20.443566][ T112] debounce, SCR=3D0x113
[ 20.503566][ T112] debounce, SCR=3D0x113
[ 20.563566][ T112] debounce, SCR=3D0x113
[ 20.623566][ T112] debounce, SCR=3D0x113
[ 20.627424][ T112] resume, return at end of function
[ 20.631280][ T112] hardreset, Offline=3D>Online
[ 20.640838][ T112] hardreset, sata_pmp_supported, before check_ready
[ 20.803595][ T112] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[ 20.817315][ T112] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 p=
orts, feat 0xf/0x1f
[ 20.825960][ T112] device: 'link2.0': device_add
[ 20.830777][ T112] device: 'link2.0': device_add
[ 20.835790][ T112] device: 'dev2.0.0': device_add
[ 20.840636][ T112] device: 'dev2.0.0': device_add
[ 20.846288][ T112] device: 'link2.1': device_add
[ 20.851053][ T112] device: 'link2.1': device_add
[ 20.856268][ T112] device: 'dev2.1.0': device_add
[ 20.861117][ T112] device: 'dev2.1.0': device_add
[ 20.866722][ T112] device: 'link2.2': device_add
[ 20.871488][ T112] device: 'link2.2': device_add
[ 20.876368][ T112] device: 'dev2.2.0': device_add
[ 20.881214][ T112] device: 'dev2.2.0': device_add
[ 20.886777][ T112] device: 'link2.3': device_add
[ 20.891541][ T112] device: 'link2.3': device_add
[ 20.896427][ T112] device: 'dev2.3.0': device_add
[ 20.901275][ T112] device: 'dev2.3.0': device_add
[ 20.906277][ T112] device: 'link2.4': device_add
[ 20.911039][ T112] device: 'link2.4': device_add
[ 20.915946][ T112] device: 'dev2.4.0': device_add
[ 20.921082][ T112] device: 'dev2.4.0': device_add
[ 20.926100][ T112] device: 'link2.5': device_add
[ 20.930863][ T112] device: 'link2.5': device_add
[ 20.936073][ T112] device: 'dev2.5.0': device_add
[ 20.940925][ T112] device: 'dev2.5.0': device_add
[ 20.946222][ T112] device: 'link2.6': device_add
[ 20.950988][ T112] device: 'link2.6': device_add
[ 20.956436][ T112] device: 'dev2.6.0': device_add
[ 20.961292][ T112] device: 'dev2.6.0': device_add
[ 20.966849][ T112] device: 'link2.7': device_add
[ 20.971618][ T112] device: 'link2.7': device_add
[ 20.976506][ T112] device: 'dev2.7.0': device_add
[ 20.981358][ T112] device: 'dev2.7.0': device_add
[ 20.986928][ T112] device: 'link2.8': device_add
[ 20.991700][ T112] device: 'link2.8': device_add
[ 20.996612][ T112] device: 'dev2.8.0': device_add
[ 21.001760][ T112] device: 'dev2.8.0': device_add
[ 21.006776][ T112] device: 'link2.9': device_add
[ 21.011544][ T112] device: 'link2.9': device_add
[ 21.017066][ T112] device: 'dev2.9.0': device_add
[ 21.021924][ T112] device: 'dev2.9.0': device_add
[ 21.027237][ T112] device: 'link2.10': device_add
[ 21.032095][ T112] device: 'link2.10': device_add
[ 21.037406][ T112] device: 'dev2.10.0': device_add
[ 21.042352][ T112] device: 'dev2.10.0': device_add
[ 21.048268][ T112] device: 'link2.11': device_add
[ 21.053129][ T112] device: 'link2.11': device_add
[ 21.058157][ T112] device: 'dev2.11.0': device_add
[ 21.063101][ T112] device: 'dev2.11.0': device_add
[ 21.068830][ T112] device: 'link2.12': device_add
[ 21.073707][ T112] device: 'link2.12': device_add
[ 21.078703][ T112] device: 'dev2.12.0': device_add
[ 21.083664][ T112] device: 'dev2.12.0': device_add
[ 21.088772][ T112] device: 'link2.13': device_add
[ 21.093645][ T112] device: 'link2.13': device_add
[ 21.098637][ T112] device: 'dev2.13.0': device_add
[ 21.103606][ T112] device: 'dev2.13.0': device_add
[ 21.109014][ T112] device: 'link2.14': device_add
[ 21.113901][ T112] device: 'link2.14': device_add
[ 21.119225][ T112] device: 'dev2.14.0': device_add
[ 21.124190][ T112] device: 'dev2.14.0': device_add
[ 21.130120][ T112] ahci-mvebu f10a8000.sata: FBS is enabled
[ 21.135879][ T112] ata2.00: SCR_CONTROL =3D 0x300
[ 21.140525][ T112] ata2.00: FORCE: PHY spd limit set to 1.5Gbps
[ 21.146622][ T112] ata2.01: SCR_CONTROL =3D 0x300
[ 21.151266][ T112] ata2.01: FORCE: PHY spd limit set to 1.5Gbps
[ 21.157358][ T112] ata2.02: SCR_CONTROL =3D 0x300
[ 21.162001][ T112] ata2.02: FORCE: PHY spd limit set to 1.5Gbps
[ 21.168099][ T112] ata2.03: SCR_CONTROL =3D 0x300
[ 21.172743][ T112] ata2.03: FORCE: PHY spd limit set to 1.5Gbps
[ 21.178835][ T112] ata2.04: SCR_CONTROL =3D 0x300
[ 21.183478][ T112] ata2.04: FORCE: PHY spd limit set to 1.5Gbps
[ 21.189572][ T112] ata2.05: SCR_CONTROL =3D 0x300
[ 21.194235][ T112] ata2.05: FORCE: PHY spd limit set to 1.5Gbps
[ 21.200304][ T112] ata2.06: SCR_CONTROL =3D 0x300
[ 21.204972][ T112] ata2.06: FORCE: PHY spd limit set to 1.5Gbps
[ 21.211041][ T112] ata2.07: SCR_CONTROL =3D 0x300
[ 21.215704][ T112] ata2.07: FORCE: PHY spd limit set to 1.5Gbps
[ 21.221851][ T112] ata2.00: hard resetting link
[ 21.226515][ T112] hardreset, Online=3D>Offline
[ 21.226553][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 21.231021][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 21.236291][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 21.241980][ T112] __sata_set_spd_needed, target=3D0x1
[ 21.247853][ T112] __sata_set_spd_needed, spd=3D0x0
[ 21.252930][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 21.257850][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 21.263906][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 21.269594][ T112] __sata_set_spd_needed, target=3D0x1
[ 21.275467][ T112] __sata_set_spd_needed, spd=3D0x0
[ 21.280545][=20T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 21.286568][ T112] resume, do loop
[ 21.513601][ T112] resume, after do loop
[ 21.522240][ T112] debounce, SCR=3D0x123
[ 21.531389][ T112] debounce, SCR=3D0x123
[ 21.540363][ T112] debounce, SCR=3D0x123
[ 21.549337][ T112] debounce, SCR=3D0x123
[ 21.558293][ T112] debounce, SCR=3D0x123
[ 21.567248][ T112] debounce, SCR=3D0x123
[ 21.576203][ T112] debounce, SCR=3D0x123
[ 21.585159][ T112] debounce, SCR=3D0x123
[ 21.594114][ T112] debounce, SCR=3D0x123
[ 21.603069][ T112] debounce, SCR=3D0x123
[ 21.612041][ T112] debounce, SCR=3D0x123
[ 21.621017][ T112] debounce, SCR=3D0x123
[ 21.624952][ T112] resume, return at end of function
[ 21.628840][ T112] hardreset, Offline=3D>Online
[ 21.638398][ T112] hardreset, after check_ready
[ 21.638610][ T112] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
[ 21.650473][ T112] ata2.01: hard resetting link
[ 21.655136][ T112] hardreset, Online=3D>Offline
[ 21.655171][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 21.659639][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 21.664908][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 21.670596][ T112] __sata_set_spd_needed, target=3D0x1
[ 21.676470][ T112] __sata_set_spd_needed, spd=3D0x0
[ 21.681546][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 21.686463][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 21.692501][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 21.698206][ T112] __sata_set_spd_needed, target=3D0x1
[ 21.704080][ T112] __sata_set_spd_needed, spd=3D0x0
[ 21.709157][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 21.715178][ T112] resume, do loop
[ 21.943601][ T112] resume, after do loop
[ 21.952238][ T112] debounce, SCR=3D0x123
[ 21.961386][ T112] debounce, SCR=3D0x123
[ 21.970359][ T112] debounce, SCR=3D0x123
[ 21.979332][ T112] debounce, SCR=3D0x123
[ 21.988287][ T112] debounce, SCR=3D0x123
[ 21.997242][ T112] debounce, SCR=3D0x123
[ 22.006197][ T112] debounce, SCR=3D0x123
[ 22.015153][ T112] debounce, SCR=3D0x123
[ 22.024109][ T112] debounce, SCR=3D0x123
[ 22.033063][ T112] debounce, SCR=3D0x123
[ 22.042035][ T112] debounce, SCR=3D0x123
[ 22.051009][ T112] debounce, SCR=3D0x123
[ 22.054944][ T112] resume, return at end of function
[ 22.058831][ T112] hardreset, Offline=3D>Online
[ 22.068388][ T112] hardreset, after check_ready
[ 22.068597][ T112] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
[ 22.080480][ T112] ata2.02: hard resetting link
[ 22.085143][ T112] hardreset, Online=3D>Offline
[ 22.085179][ T112] sata_set_spd_needed, scontrol=3D0x300
[ 22.089647][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 22.094916][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 22.100604][ T112] __sata_set_spd_needed, target=3D0x1
[ 22.106477][ T112] __sata_set_spd_needed, spd=3D0x0
[ 22.111555][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 22.116472][ T112] __sata_set_spd_needed, initial limit=3D0x1
[ 22.122510][ T112] __sata_set_spd_needed, corrected limit=3D0x1
[ 22.128215][ T112] __sata_set_spd_needed, target=3D0x1
[ 22.134089][ T112] __sata_set_spd_needed, spd=3D0x0
[ 22.139167][ T112] __sata_set_spd_needed, final *scontrol=3D0x310
[ 22.145189][ T112] resume, do loop
[ 22.373600][ T112] resume, after do loop
[ 22.382236][ T112] debounce, SCR=3D0x0
[ 22.391383][ T112] debounce, SCR=3D0x0
[ 22.400182][ T112] debounce, SCR=3D0x0
[ 22.408981][ T112] debounce, SCR=3D0x0
[ 22.417762][ T112] debounce, SCR=3D0x0
[ 22.426544][ T112] debounce, SCR=3D0x0
[ 22.435326][ T112] debounce, SCR=3D0x0
[ 22.444106][ T112] debounce, SCR=3D0x0
[ 22.452887][ T112] debounce, SCR=3D0x0
[ 22.461685][ T112] debounce, SCR=3D0x0
[ 22.470484][ T112] debounce, SCR=3D0x0
[ 22.479283][ T112] debounce, SCR=3D0x0
[ 22.488064][ T112] debounce, SCR=3D0x0
[ 22.491807][ T112] resume, return at end of function
[ 22.495538][ T112] hardreset, ata_phys_link_offline check failed
[ 22.500820][ T112] ata2.02: SATA link down (SStatus 0 SControl 300)
... same for ata2.03 - ata2.07
[ 24.700822][ T112] ata2.07: SATA link down (SStatus 0 SControl 300)
[ 24.713496][ T112] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max=
 UDMA/133
[ 24.721125][ T112] ata2.00: 976773168 sectors, multi 0: LBA48
[ 24.727228][ T112] ata2.00: configured for UDMA/133
[ 24.732296][ T112] ata2.01: ATA-6: Areca Archive, 0100 AX, max UDMA/133
[ 24.739227][ T112] ata2.01: 23437498368 sectors, multi 0: LBA48
[ 24.745499][ T112] ata2.01: configured for UDMA/133
[ 24.750648][ T112] ata2: EH complete
[ 24.755230][ T63] scsi 1:0:0:0: Direct-Access ATA WDC WD50ARC-5040 n/a P=
Q: 0 ANSI: 5
[ 24.764991][ T63] device: 'target1:0:0': device_add
[ 24.770118][ T63] bus: 'scsi': add device target1:0:0
[ 24.775498][ T63] device: '1:0:0:0': device_add
[ 24.780565][ T63] bus: 'scsi': add device 1:0:0:0
[ 24.785552][ T63] scsi 1:0:0:0: scheduling asynchronous probe
[ 24.791555][ T63] device: '1:0:0:0': device_add
[ 24.791569][ T118] bus: 'scsi': __driver_probe_device: matched device 1:=
0:0:0 with driver sd
[ 24.796461][ T63] device: '1:0:0:0': device_add
[ 24.804926][ T118] bus: 'scsi': really_probe: probing driver sd with dev=
ice 1:0:0:0
[ 24.817484][ T118] sd 1:0:0:0: no default pinctrl state
[ 24.822937][ T118] device: '1:0:0:0': device_add
[ 24.824243][ T63] scsi 1:1:0:0: Direct-Access ATA Areca Archive n/a PQ: =
0 ANSI: 5
[ 24.828657][ T118] sd 1:0:0:0: [sdb] 976773168 512-byte logical blocks: =
(500 GB/466 GiB)
[ 24.837872][ T63] device: 'target1:1:0': device_add
[ 24.845150][ T118] sd 1:0:0:0: [sdb] Write Protect is off
[ 24.849923][ T63] bus: 'scsi': add device target1:1:0
[ 24.855451][ T118] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 24.860757][ T63] device: '1:1:0:0': device_add
[ 24.866593][ T118] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: e=
nabled, doesn't support
DPO or FUA
[ 24.871964][ T63] bus: 'scsi': add device 1:1:0:0
[ 24.881186][ T118] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 byte=
s
[ 24.886609][ T63] scsi 1:1:0:0: scheduling asynchronous probe
[ 24.892843][ T118] device: 'sdb': device_add
[ 24.898807][ T63] device: '1:1:0:0': device_add
[ 24.903982][ T7] bus: 'scsi': __driver_probe_device: matched device 1:1:=
0:0 with driver sd
[ 24.908057][ T63] device: '1:1:0:0': device_add
[ 24.916484][ T7] bus: 'scsi': really_probe: probing driver sd with devic=
e 1:1:0:0
[ 24.929038][ T7] sd 1:1:0:0: no default pinctrl state
[ 24.934513][ T7] device: '1:1:0:0': device_add
[ 24.941340][ T118] device: '8:16': device_add
[ 24.947108][ T7] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blocks: =
(12.0 TB/10.9 TiB)
[ 24.955826][ T7] sd 1:1:0:0: [sdc] Write Protect is off
[ 24.961351][ T7] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 24.967286][ T7] sd 1:1:0:0: [sdc] Write cache: enabled, read cache: ena=
bled, doesn't support DPO
or FUA
[ 24.977267][ T7] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 bytes
[ 24.984224][ T7] device: 'sdc': device_add
[ 24.990405][ T7] device: '8:32': device_add
[ 25.016696][ T7] sd 1:1:0:0: [sdc] Attached SCSI removable disk
[ 25.022920][ T7] driver: 'sd': driver_bound: bound to device '1:1:0:0'
[ 25.030261][ T7] bus: 'scsi': really_probe: bound device 1:1:0:0 to driv=
er sd
[ 25.037753][ T7] sd 1:1:0:0: async probe completed
[ 25.426417][ T118] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[ 25.432640][ T118] driver: 'sd': driver_bound: bound to device '1:0:0:0'
[ 25.439564][ T118] bus: 'scsi': really_probe: bound device 1:0:0:0 to dr=
iver sd
[ 25.447043][ T118] sd 1:0:0:0: async probe completed

Marius

