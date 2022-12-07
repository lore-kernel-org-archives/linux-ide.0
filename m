Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF14CC352A1
	for <linux-ide@archiver.kernel.org>; Wed,  7 Dec 2022 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLGS1U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 13:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGS1T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 13:27:19 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA456A774
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 10:27:16 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=D3Ka0M3+Lh5j7FFyEARuH5qQ8ZdtDES7AN6VvN9dZHM=;
        b=S4TiJxY+MSMNWDk00VjUtJk9P77HagD+Y+1O9kDRECnE2lR0BzLyl0Bih2ZKI4TvuXbSYOIL5l90NbHGo08M+vb+ePH4GH3O9kk4JKwzY4C1ywjkOZBV34AGensVyXSJJl4xto+cfZ/kDqsfNRP/8sK7sLX493Je5tE1y++ISzcxSuNHurfY/cs51WJee2JrrwY3M3fKuRgfqaOheOA5BL+xifyx2FzBFnJZ0k1D16N4rr4xIgDwSRx75y
        O4GGw4G+D/a0nc22gbDHkVmzp/+sYiJhYOO0dbvg7SEt//8hazFO1pzRUqD94v1lkFLeHoBBmuOwtK9GZ1/S0PBoGmog==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Wed, 7 Dec 2022 18:27:01 +0000
MIME-Version: 1.0
Date:   Wed, 07 Dec 2022 18:27:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <1b74a7e40419b6f99870c21ca3be7834@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
References: <c403c1dd-6478-09a3-f8b4-98026eb16c99@opensource.wdc.com>
 <5b5d7816-5e43-88e8-1337-769cce825f78@opensource.wdc.com>
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
X-Originating-IP: 84.232.129.15
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

December 6, 2022 8:08 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> By the way, what is the maximum speed of you pmp box ? Is it really 1.5
> Gbps (sata gen 1) ?

No. It's 3 Gbps.

> Without reverting the above patch, could you please try the following p=
atch ?

I did more tests, with and without the patch, with and without the commit=
 reverted.
All logs start when eSATA cable is connected. I didn't include boot logs.

--- with your patch, commit not reverted ---
[ 11.642517][ T30] hardreset, Online=3D>Offline
[ 11.643598][ T30] resume, do loop
[ 11.858908][ T30] resume, after do loop
[ 11.908907][ T30] debounce, SCR=3D0x100
[ 11.958906][ T30] debounce, SCR=3D0x100
[ 12.008906][ T30] debounce, SCR=3D0x100
[ 12.058905][ T30] debounce, SCR=3D0x101
[ 12.108907][ T30] debounce, SCR=3D0x100
[ 12.158906][ T30] debounce, SCR=3D0x100
[ 12.208906][ T30] debounce, SCR=3D0x100
[ 12.258906][ T30] debounce, SCR=3D0x100
[ 12.308906][ T30] debounce, SCR=3D0x101
[ 12.358906][ T30] debounce, SCR=3D0x100
[ 12.408906][ T30] debounce, SCR=3D0x100
[ 12.458906][ T30] debounce, SCR=3D0x100
[ 12.508906][ T30] debounce, SCR=3D0x100
[ 12.558906][ T30] debounce, SCR=3D0x100
[ 12.608906][ T30] debounce, SCR=3D0x100
[ 12.658905][ T30] debounce, SCR=3D0x100
[ 12.708905][ T30] debounce, SCR=3D0x100
[ 12.758905][ T30] debounce, SCR=3D0x100
[ 12.808905][ T30] debounce, SCR=3D0x101
[ 12.858905][ T30] debounce, SCR=3D0x100
[ 12.908905][ T30] debounce, SCR=3D0x100
[ 12.958905][ T30] debounce, SCR=3D0x100
[ 13.008905][ T30] debounce, SCR=3D0x100
[ 13.058906][ T30] debounce, SCR=3D0x101
[ 13.108905][ T30] debounce, SCR=3D0x100
[ 13.158906][ T30] debounce, SCR=3D0x100
[ 13.208906][ T30] debounce, SCR=3D0x100
[ 13.258906][ T30] debounce, SCR=3D0x100
[ 13.308906][ T30] debounce, SCR=3D0x101
[ 13.358906][ T30] debounce, SCR=3D0x100
[ 13.408906][ T30] debounce, SCR=3D0x100
[ 13.458906][ T30] debounce, SCR=3D0x101
[ 13.508906][ T30] debounce, SCR=3D0x100
[ 13.558906][ T30] debounce, SCR=3D0x100
[ 13.608906][ T30] debounce, SCR=3D0x100
[ 13.658906][ T30] debounce, SCR=3D0x100
[ 13.708906][ T30] debounce, SCR=3D0x0
[ 13.758906][ T30] debounce, SCR=3D0x0
[ 13.808906][ T30] debounce, SCR=3D0x0
[ 13.858906][ T30] debounce, SCR=3D0x0
[ 13.908906][ T30] debounce, SCR=3D0x0
[ 13.958905][ T30] debounce, SCR=3D0x100
[ 14.008905][ T30] debounce, SCR=3D0x100
[ 14.058905][ T30] debounce, SCR=3D0x100
[ 14.062763][ T30] resume, return at end of function
[ 14.066620][ T30] hardreset, ata_phys_link_offline check failed
[ 14.071739][ T30] ata2: SATA link down (SStatus 100 SControl 300)
[ 14.084217][ T30] hardreset, Online=3D>Offline
[ 14.085293][ T30] resume, do loop
[ 14.308906][ T30] resume, after do loop
[ 14.358906][ T30] debounce, SCR=3D0x100
[ 14.408906][ T30] debounce, SCR=3D0x101
[ 14.458906][ T30] debounce, SCR=3D0x100
[ 14.508906][ T30] debounce, SCR=3D0x100
[ 14.558906][ T30] debounce, SCR=3D0x100
[ 14.608906][ T30] debounce, SCR=3D0x100
[ 14.658906][ T30] debounce, SCR=3D0x101
[ 14.708905][ T30] debounce, SCR=3D0x100
[ 14.758905][ T30] debounce, SCR=3D0x100
[ 14.808905][ T30] debounce, SCR=3D0x100
[ 14.858905][ T30] debounce, SCR=3D0x100
[ 14.908905][ T30] debounce, SCR=3D0x101
[ 14.958905][ T30] debounce, SCR=3D0x100
[ 15.008906][ T30] debounce, SCR=3D0x100
[ 15.058905][ T30] debounce, SCR=3D0x100
[ 15.108906][ T30] debounce, SCR=3D0x100
[ 15.158906][ T30] debounce, SCR=3D0x101
[ 15.208906][ T30] debounce, SCR=3D0x100
[ 15.258906][ T30] debounce, SCR=3D0x100
[ 15.308906][ T30] debounce, SCR=3D0x100
[ 15.358906][ T30] debounce, SCR=3D0x100
[ 15.408906][ T30] debounce, SCR=3D0x101
[ 15.458906][ T30] debounce, SCR=3D0x100
[ 15.508906][ T30] debounce, SCR=3D0x100
[ 15.558906][ T30] debounce, SCR=3D0x100
[ 15.608906][ T30] debounce, SCR=3D0x100
[ 15.658906][ T30] debounce, SCR=3D0x100
[ 15.708906][ T30] debounce, SCR=3D0x100
[ 15.758906][ T30] debounce, SCR=3D0x100
[ 15.808906][ T30] debounce, SCR=3D0x100
[ 15.858905][ T30] debounce, SCR=3D0x100
[ 15.908905][ T30] debounce, SCR=3D0x100
[ 15.958905][ T30] debounce, SCR=3D0x100
[ 16.008906][ T30] debounce, SCR=3D0x100
[ 16.012763][ T30] resume, return at end of function
[ 16.016620][ T30] hardreset, ata_phys_link_offline check failed
[ 16.021735][ T30] ata2: SATA link down (SStatus 100 SControl 300)
[ 16.034210][ T30] hardreset, Online=3D>Offline
[ 16.035286][ T30] resume, do loop
[ 16.258906][ T30] resume, after do loop
[ 16.308906][ T30] debounce, SCR=3D0x100
[ 16.358906][ T30] debounce, SCR=3D0x100
[ 16.408906][ T30] debounce, SCR=3D0x100
[ 16.458906][ T30] debounce, SCR=3D0x100
[ 16.508905][ T30] debounce, SCR=3D0x100
[ 16.558905][ T30] debounce, SCR=3D0x100
[ 16.608905][ T30] debounce, SCR=3D0x100
[ 16.658906][ T30] debounce, SCR=3D0x100
[ 16.708905][ T30] debounce, SCR=3D0x100
[ 16.758905][ T30] debounce, SCR=3D0x100
[ 16.808905][ T30] debounce, SCR=3D0x100
[ 16.812763][ T30] resume, return at end of function
[ 16.816620][ T30] hardreset, ata_phys_link_offline check failed
[ 16.821734][ T30] ata2: SATA link down (SStatus 100 SControl 300)
[ 16.834209][ T30] hardreset, Online=3D>Offline
[ 16.835284][ T30] resume, do loop
[ 17.058905][ T30] resume, after do loop
[ 17.108906][ T30] debounce, SCR=3D0x100
[ 17.158906][ T30] debounce, SCR=3D0x100
[ 17.208906][ T30] debounce, SCR=3D0x100
[ 17.258906][ T30] debounce, SCR=3D0x100
[ 17.308906][ T30] debounce, SCR=3D0x100
[ 17.358906][ T30] debounce, SCR=3D0x100
[ 17.408906][ T30] debounce, SCR=3D0x100
[ 17.458906][ T30] debounce, SCR=3D0x101
[ 17.508906][ T30] debounce, SCR=3D0x100
[ 17.558906][ T30] debounce, SCR=3D0x100
[ 17.608906][ T30] debounce, SCR=3D0x100
[ 17.658906][ T30] debounce, SCR=3D0x100
[ 17.708906][ T30] debounce, SCR=3D0x101
[ 17.758906][ T30] debounce, SCR=3D0x100
[ 17.808905][ T30] debounce, SCR=3D0x100
[ 17.858905][ T30] debounce, SCR=3D0x100
[ 17.908905][ T30] debounce, SCR=3D0x100
[ 17.958905][ T30] debounce, SCR=3D0x101
[ 18.008906][ T30] debounce, SCR=3D0x100
[ 18.058905][ T30] debounce, SCR=3D0x100
[ 18.108906][ T30] debounce, SCR=3D0x100
[ 18.158906][ T30] debounce, SCR=3D0x100
[ 18.208906][ T30] debounce, SCR=3D0x101
[ 18.258906][ T30] debounce, SCR=3D0x100
[ 18.308906][ T30] debounce, SCR=3D0x100
[ 18.358906][ T30] debounce, SCR=3D0x100
[ 18.408906][ T30] debounce, SCR=3D0x0
[ 18.458906][ T30] debounce, SCR=3D0x0
[ 18.508906][ T30] debounce, SCR=3D0x0
[ 18.558906][ T30] debounce, SCR=3D0x0
[ 18.608906][ T30] debounce, SCR=3D0x0
[ 18.658906][ T30] debounce, SCR=3D0x100
[ 18.708906][ T30] debounce, SCR=3D0x100
[ 18.758905][ T30] debounce, SCR=3D0x100
[ 18.808905][ T30] debounce, SCR=3D0x101
[ 18.858906][ T30] debounce, SCR=3D0x100
[ 18.908906][ T30] debounce, SCR=3D0x100
[ 18.958906][ T30] debounce, SCR=3D0x100
[ 19.008906][ T30] debounce, SCR=3D0x100
[ 19.058905][ T30] debounce, SCR=3D0x101
[ 19.108905][ T30] debounce, SCR=3D0x100
[ 19.112763][ T30] debounce, loop end with timeout
[ 19.116619][ T30] resume, sata_link_debounce check failed, returning rc=
=3D0xFFFFFFE0
[ 19.121546][ T30] hardreset, sata_link_resume check failed
[ 19.129358][ T30] ata2: COMRESET failed (errno=3D-32)
[ 19.140138][ T30] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 27.368908][ T30] hardreset, Online=3D>Offline
[ 27.369984][ T30] resume, do loop
[ 27.588906][ T30] resume, after do loop
[ 27.638906][ T30] debounce, SCR=3D0x100
[ 27.688906][ T30] debounce, SCR=3D0x100
[ 27.738906][ T30] debounce, SCR=3D0x100
[ 27.788906][ T30] debounce, SCR=3D0x0
[ 27.838906][ T30] debounce, SCR=3D0x0
[ 27.888906][ T30] debounce, SCR=3D0x0
[ 27.938906][ T30] debounce, SCR=3D0x0
[ 27.988906][ T30] debounce, SCR=3D0x0
[ 28.038905][ T30] debounce, SCR=3D0x100
[ 28.088927][ T30] debounce, SCR=3D0x100
[ 28.138906][ T30] debounce, SCR=3D0x100
[ 28.142764][ T30] resume, return at end of function
[ 28.146620][ T30] hardreset, ata_phys_link_offline check failed
[ 28.151734][ T30] ata2: SATA link down (SStatus 100 SControl 300)
[ 28.164209][ T30] hardreset, Online=3D>Offline
[ 28.165285][ T30] resume, do loop
[ 28.388907][ T30] resume, after do loop
[ 28.438906][ T30] debounce, SCR=3D0x100
[ 28.488906][ T30] debounce, SCR=3D0x101
[ 28.538906][ T30] debounce, SCR=3D0x100
[ 28.588906][ T30] debounce, SCR=3D0x100
[ 28.638906][ T30] debounce, SCR=3D0x101
[ 28.688906][ T30] debounce, SCR=3D0x100
[ 28.738905][ T30] debounce, SCR=3D0x100
[ 28.788905][ T30] debounce, SCR=3D0x100
[ 28.838905][ T30] debounce, SCR=3D0x100
[ 28.888905][ T30] debounce, SCR=3D0x101
[ 28.938905][ T30] debounce, SCR=3D0x100
[ 28.988905][ T30] debounce, SCR=3D0x100
[ 29.038905][ T30] debounce, SCR=3D0x100
[ 29.088905][ T30] debounce, SCR=3D0x100
[ 29.138907][ T30] debounce, SCR=3D0x100
[ 29.188906][ T30] debounce, SCR=3D0x100
[ 29.238905][ T30] debounce, SCR=3D0x100
[ 29.288906][ T30] debounce, SCR=3D0x100
[ 29.338905][ T30] debounce, SCR=3D0x100
[ 29.388905][ T30] debounce, SCR=3D0x101
[ 29.438905][ T30] debounce, SCR=3D0x100
[ 29.488905][ T30] debounce, SCR=3D0x100
[ 29.538906][ T30] debounce, SCR=3D0x100
[ 29.588906][ T30] debounce, SCR=3D0x100
[ 29.638906][ T30] debounce, SCR=3D0x100
[ 29.688905][ T30] debounce, SCR=3D0x100
[ 29.738905][ T30] debounce, SCR=3D0x100
[ 29.788905][ T30] debounce, SCR=3D0x101
[ 29.838906][ T30] debounce, SCR=3D0x100
[ 29.888906][ T30] debounce, SCR=3D0x100
[ 29.938905][ T30] debounce, SCR=3D0x100
[ 29.988905][ T30] debounce, SCR=3D0x100
[ 30.038905][ T30] debounce, SCR=3D0x101
[ 30.088927][ T30] debounce, SCR=3D0x100
[ 30.138905][ T30] debounce, SCR=3D0x100
[ 30.188905][ T30] debounce, SCR=3D0x100
[ 30.238906][ T30] debounce, SCR=3D0x100
[ 30.288905][ T30] debounce, SCR=3D0x101
[ 30.338906][ T30] debounce, SCR=3D0x100
[ 30.388905][ T30] debounce, SCR=3D0x100
[ 30.438905][ T30] debounce, SCR=3D0x100
[ 30.488905][ T30] debounce, SCR=3D0x100
[ 30.538905][ T30] debounce, SCR=3D0x101
[ 30.542763][ T30] debounce, loop end with timeout
[ 30.546619][ T30] resume, sata_link_debounce check failed, returning rc=
=3D0xFFFFFFE0
[ 30.551545][ T30] hardreset, sata_link_resume check failed
[ 30.559344][ T30] ata2: COMRESET failed (errno=3D-32)
[ 30.570122][ T30] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 38.248909][ T30] hardreset, Online=3D>Offline
[ 38.249985][ T30] resume, do loop
[ 38.468906][ T30] resume, after do loop
[ 38.518906][ T30] debounce, SCR=3D0x100
[ 38.568906][ T30] debounce, SCR=3D0x101
[ 38.618906][ T30] debounce, SCR=3D0x100
[ 38.668906][ T30] debounce, SCR=3D0x100
[ 38.718906][ T30] debounce, SCR=3D0x100
[ 38.768906][ T30] debounce, SCR=3D0x100
[ 38.818906][ T30] debounce, SCR=3D0x100
[ 38.868906][ T30] debounce, SCR=3D0x100
[ 38.918905][ T30] debounce, SCR=3D0x100
[ 38.968905][ T30] debounce, SCR=3D0x101
[ 39.018906][ T30] debounce, SCR=3D0x100
[ 39.068906][ T30] debounce, SCR=3D0x100
[ 39.118906][ T30] debounce, SCR=3D0x100
[ 39.168906][ T30] debounce, SCR=3D0x100
[ 39.218906][ T30] debounce, SCR=3D0x100
[ 39.268906][ T30] debounce, SCR=3D0x100
[ 39.318906][ T30] debounce, SCR=3D0x101
[ 39.368906][ T30] debounce, SCR=3D0x100
[ 39.418906][ T30] debounce, SCR=3D0x100
[ 39.468906][ T30] debounce, SCR=3D0x101
[ 39.518906][ T30] debounce, SCR=3D0x100
[ 39.568905][ T30] debounce, SCR=3D0x100
[ 39.618905][ T30] debounce, SCR=3D0x100
[ 39.668905][ T30] debounce, SCR=3D0x100
[ 39.718905][ T30] debounce, SCR=3D0x100
[ 39.768905][ T30] debounce, SCR=3D0x100
[ 39.818905][ T30] debounce, SCR=3D0x100
[ 39.868905][ T30] debounce, SCR=3D0x101
[ 39.918905][ T30] debounce, SCR=3D0x100
[ 39.968905][ T30] debounce, SCR=3D0x100
[ 40.018905][ T30] debounce, SCR=3D0x100
[ 40.068905][ T30] debounce, SCR=3D0x100
[ 40.118906][ T30] debounce, SCR=3D0x100
[ 40.168906][ T30] debounce, SCR=3D0x100
[ 40.218906][ T30] debounce, SCR=3D0x101
[ 40.268906][ T30] debounce, SCR=3D0x100
[ 40.318906][ T30] debounce, SCR=3D0x100
[ 40.368906][ T30] debounce, SCR=3D0x101
[ 40.418906][ T30] debounce, SCR=3D0x100
[ 40.468906][ T30] debounce, SCR=3D0x100
[ 40.518906][ T30] debounce, SCR=3D0x100
[ 40.568906][ T30] debounce, SCR=3D0x100
[ 40.618906][ T30] debounce, SCR=3D0x101
[ 40.622764][ T30] debounce, loop end with timeout
[ 40.626620][ T30] resume, sata_link_debounce check failed, returning rc=
=3D0xFFFFFFE0
[ 40.631546][ T30] hardreset, sata_link_resume check failed
[ 40.639344][ T30] ata2: COMRESET failed (errno=3D-32)
[ 40.650122][ T30] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 48.488908][ T30] hardreset, Online=3D>Offline
[ 48.489983][ T30] resume, do loop
[ 48.708906][ T30] resume, after do loop
[ 48.758905][ T30] debounce, SCR=3D0x100
[ 48.808905][ T30] debounce, SCR=3D0x100
[ 48.858905][ T30] debounce, SCR=3D0x100
[ 48.908905][ T30] debounce, SCR=3D0x100
[ 48.958905][ T30] debounce, SCR=3D0x100
[ 49.008905][ T30] debounce, SCR=3D0x100
[ 49.058905][ T30] debounce, SCR=3D0x101
[ 49.108905][ T30] debounce, SCR=3D0x100
[ 49.158906][ T30] debounce, SCR=3D0x100
[ 49.208906][ T30] debounce, SCR=3D0x100
[ 49.258906][ T30] debounce, SCR=3D0x100
[ 49.308906][ T30] debounce, SCR=3D0x101
[ 49.358906][ T30] debounce, SCR=3D0x100
[ 49.408906][ T30] debounce, SCR=3D0x100
[ 49.458906][ T30] debounce, SCR=3D0x100
[ 49.508906][ T30] debounce, SCR=3D0x100
[ 49.558906][ T30] debounce, SCR=3D0x100
[ 49.608906][ T30] debounce, SCR=3D0x100
[ 49.658906][ T30] debounce, SCR=3D0x100
[ 49.708906][ T30] debounce, SCR=3D0x101
[ 49.758906][ T30] debounce, SCR=3D0x100
[ 49.808905][ T30] debounce, SCR=3D0x100
[ 49.858906][ T30] debounce, SCR=3D0x101
[ 49.908905][ T30] debounce, SCR=3D0x100
[ 49.958905][ T30] debounce, SCR=3D0x100
[ 50.008905][ T30] debounce, SCR=3D0x100
[ 50.058905][ T30] debounce, SCR=3D0x100
[ 50.108906][ T30] debounce, SCR=3D0x101
[ 50.158905][ T30] debounce, SCR=3D0x100
[ 50.208906][ T30] debounce, SCR=3D0x100
[ 50.258906][ T30] debounce, SCR=3D0x100
[ 50.308906][ T30] debounce, SCR=3D0x100
[ 50.358906][ T30] debounce, SCR=3D0x101
[ 50.408906][ T30] debounce, SCR=3D0x100
[ 50.458906][ T30] debounce, SCR=3D0x100
[ 50.508906][ T30] debounce, SCR=3D0x100
[ 50.558906][ T30] debounce, SCR=3D0x100
[ 50.608905][ T30] debounce, SCR=3D0x100
[ 50.658906][ T30] debounce, SCR=3D0x100
[ 50.708906][ T30] debounce, SCR=3D0x100
[ 50.758906][ T30] debounce, SCR=3D0x100
[ 50.808906][ T30] debounce, SCR=3D0x100
[ 50.858906][ T30] debounce, SCR=3D0x100
[ 50.908906][ T30] debounce, SCR=3D0x100
[ 50.958906][ T30] debounce, SCR=3D0x100
[ 50.962764][ T30] resume, return at end of function
[ 50.966620][ T30] hardreset, ata_phys_link_offline check failed
[ 50.971735][ T30] ata2: SATA link down (SStatus 100 SControl 300)
[ 50.984190][ T30] ata2: EH pending after 5 tries, giving up

As you can see, it doesn't work. But I noticed something:
With commit reverted, initially it's not working and, after a reset, sets=
 speed to 1.5Gbps and then the port multiplier is detected. When each por=
t is scanned, speed is set to 3.0 Gbps and it works fine like that.
If the commit is NOT reverted, SATA speed is never limited and port multi=
plier is never detected.

--- commit reverted, no patch ---
[    7.554443][   T30] hardreset, Online=3D>Offline
[    7.555523][   T30] resume, do loop
[    7.778921][   T30] resume, after do loop
[    7.828920][   T30] debounce, SCR=3D0x100
[    7.878919][   T30] debounce, SCR=3D0x101
[    7.928919][   T30] debounce, SCR=3D0x100
[    7.978919][   T30] debounce, SCR=3D0x100
[    8.028919][   T30] debounce, SCR=3D0x100
[    8.078919][   T30] debounce, SCR=3D0x100
[    8.128920][   T30] debounce, SCR=3D0x101
[    8.178920][   T30] debounce, SCR=3D0x100
[    8.228919][   T30] debounce, SCR=3D0x100
[    8.278920][   T30] debounce, SCR=3D0x100
[    8.328919][   T30] debounce, SCR=3D0x100
[    8.378920][   T30] debounce, SCR=3D0x101
[    8.428919][   T30] debounce, SCR=3D0x100
[    8.478919][   T30] debounce, SCR=3D0x100
[    8.528919][   T30] debounce, SCR=3D0x100
[    8.578919][   T30] debounce, SCR=3D0x100
[    8.628920][   T30] debounce, SCR=3D0x0
[    8.678919][   T30] debounce, SCR=3D0x0
[    8.728919][   T30] debounce, SCR=3D0x0
[    8.778919][   T30] debounce, SCR=3D0x0
[    8.828919][   T30] debounce, SCR=3D0x0
[    8.878920][   T30] debounce, SCR=3D0x0
[    8.928919][   T30] debounce, SCR=3D0x101
[    8.978919][   T30] debounce, SCR=3D0x100
[    9.028919][   T30] debounce, SCR=3D0x100
[    9.078919][   T30] debounce, SCR=3D0x100
[    9.128942][   T30] debounce, SCR=3D0x100
[    9.178920][   T30] debounce, SCR=3D0x101
[    9.228919][   T30] debounce, SCR=3D0x100
[    9.278919][   T30] debounce, SCR=3D0x100
[    9.328919][   T30] debounce, SCR=3D0x101
[    9.378920][   T30] debounce, SCR=3D0x100
[    9.428919][   T30] debounce, SCR=3D0x100
[    9.478919][   T30] debounce, SCR=3D0x100
[    9.528919][   T30] debounce, SCR=3D0x100
[    9.578919][   T30] debounce, SCR=3D0x100
[    9.628919][   T30] debounce, SCR=3D0x100
[    9.678919][   T30] debounce, SCR=3D0x100
[    9.728919][   T30] debounce, SCR=3D0x100
[    9.778919][   T30] debounce, SCR=3D0x100
[    9.828919][   T30] debounce, SCR=3D0x101
[    9.832777][   T30] debounce, loop end with timeout
[    9.836633][   T30] resume, sata_link_debounce check failed, returning=
 rc=3D0xFFFFFFE0
[    9.841560][   T30] hardreset, sata_link_resume check failed
[    9.849358][   T30] ata2: COMRESET failed (errno=3D-32)
[    9.860137][   T30] ata2: reset failed (errno=3D-32), retrying in 8 se=
cs
[   17.768922][   T30] ata2: limiting SATA link speed to 1.5 Gbps
[   17.774794][   T30] hardreset, Online=3D>Offline
[   17.774800][   T30] Reconfig spd
[   17.780365][   T30] resume, do loop
[   17.998921][   T30] resume, after do loop
[   18.048920][   T30] debounce, SCR=3D0x113
[   18.098921][   T30] debounce, SCR=3D0x113
[   18.148920][   T30] debounce, SCR=3D0x113
[   18.198920][   T30] debounce, SCR=3D0x113
[   18.248920][   T30] debounce, SCR=3D0x113
[   18.298920][   T30] debounce, SCR=3D0x113
[   18.348920][   T30] debounce, SCR=3D0x113
[   18.398920][   T30] debounce, SCR=3D0x113
[   18.448920][   T30] debounce, SCR=3D0x113
[   18.498920][   T30] debounce, SCR=3D0x113
[   18.548920][   T30] debounce, SCR=3D0x113
[   18.552778][   T30] resume, return at end of function
[   18.556635][   T30] hardreset, Offline=3D>Online
[   18.566200][   T30] hardreset, sata_pmp_supported, before check_ready
[   18.728925][   T30] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[   18.742723][   T30] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f
[   18.762620][   T30] ahci-mvebu f10a8000.sata: FBS is enabled
[   18.768711][   T30] ata2.00: hard resetting link
[   18.773388][   T30] hardreset, Online=3D>Offline
[   18.773430][   T30] Reconfig spd
[   18.779195][   T30] resume, do loop
[   18.998957][   T30] resume, after do loop
[   19.007601][   T30] debounce, SCR=3D0x123
[   19.016760][   T30] debounce, SCR=3D0x123
[   19.025753][   T30] debounce, SCR=3D0x123
[   19.034735][   T30] debounce, SCR=3D0x123
[   19.043694][   T30] debounce, SCR=3D0x123
[   19.052654][   T30] debounce, SCR=3D0x123
[   19.061614][   T30] debounce, SCR=3D0x123
[   19.070573][   T30] debounce, SCR=3D0x123
[   19.079532][   T30] debounce, SCR=3D0x123
[   19.088490][   T30] debounce, SCR=3D0x123
[   19.097471][   T30] debounce, SCR=3D0x123
[   19.106458][   T30] debounce, SCR=3D0x123
[   19.110405][   T30] resume, return at end of function
[   19.114297][   T30] hardreset, Offline=3D>Online
[   19.123869][   T30] hardreset, after check_ready
[   19.124102][   T30] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   19.136013][   T30] ata2.01: hard resetting link
[   19.140683][   T30] hardreset, Online=3D>Offline
[   19.140725][   T30] Reconfig spd
[   19.146487][   T30] resume, do loop
[   19.368956][   T30] resume, after do loop
[   19.377601][   T30] debounce, SCR=3D0x123
[   19.386757][   T30] debounce, SCR=3D0x123
[   19.395749][   T30] debounce, SCR=3D0x123
[   19.404730][   T30] debounce, SCR=3D0x123
[   19.413689][   T30] debounce, SCR=3D0x123
[   19.422648][   T30] debounce, SCR=3D0x123
[   19.431608][   T30] debounce, SCR=3D0x123
[   19.440567][   T30] debounce, SCR=3D0x123
[   19.449526][   T30] debounce, SCR=3D0x123
[   19.458485][   T30] debounce, SCR=3D0x123
[   19.467466][   T30] debounce, SCR=3D0x123
[   19.476453][   T30] debounce, SCR=3D0x123
[   19.480400][   T30] resume, return at end of function
[   19.484291][   T30] hardreset, Offline=3D>Online
[   19.493863][   T30] hardreset, after check_ready
[   19.494096][   T30] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
[   19.505968][   T30] ata2.02: hard resetting link
[   19.510636][   T30] hardreset, Online=3D>Offline
[   19.510676][   T30] Reconfig spd
[   19.516437][   T30] resume, do loop
[   19.738955][   T30] resume, after do loop
[   19.747599][   T30] debounce, SCR=3D0x0
[   19.756755][   T30] debounce, SCR=3D0x0
[   19.765572][   T30] debounce, SCR=3D0x0
[   19.774378][   T30] debounce, SCR=3D0x0
[   19.783163][   T30] debounce, SCR=3D0x0
[   19.791947][   T30] debounce, SCR=3D0x0
[   19.800732][   T30] debounce, SCR=3D0x0
[   19.809516][   T30] debounce, SCR=3D0x0
[   19.818300][   T30] debounce, SCR=3D0x0
[   19.827107][   T30] debounce, SCR=3D0x0
[   19.835914][   T30] debounce, SCR=3D0x0
[   19.844726][   T30] debounce, SCR=3D0x0
[   19.853511][   T30] debounce, SCR=3D0x0
[   19.857261][   T30] resume, return at end of function
[   19.861009][   T30] hardreset, ata_phys_link_offline check failed
[   19.866313][   T30] ata2.02: SATA link down (SStatus 0 SControl 300)
[   19.878918][   T30] ata2.03: hard resetting link
[   19.883562][   T30] hardreset, Online=3D>Offline
[   19.883602][   T30] Reconfig spd
[   19.889363][   T30] resume, do loop
[   20.108958][   T30] resume, after do loop
[   20.117603][   T30] debounce, SCR=3D0x0
[   20.126760][   T30] debounce, SCR=3D0x0
[   20.135578][   T30] debounce, SCR=3D0x0
[   20.144385][   T30] debounce, SCR=3D0x0
[   20.153170][   T30] debounce, SCR=3D0x0
[   20.161955][   T30] debounce, SCR=3D0x0
[   20.170740][   T30] debounce, SCR=3D0x0
[   20.179524][   T30] debounce, SCR=3D0x0
[   20.188308][   T30] debounce, SCR=3D0x0
[   20.197115][   T30] debounce, SCR=3D0x0
[   20.205921][   T30] debounce, SCR=3D0x0
[   20.214734][   T30] debounce, SCR=3D0x0
[   20.223519][   T30] debounce, SCR=3D0x0
[   20.227270][   T30] resume, return at end of function
[   20.231018][   T30] hardreset, ata_phys_link_offline check failed
[   20.236322][   T30] ata2.03: SATA link down (SStatus 0 SControl 300)
[   20.248946][   T30] ata2.04: hard resetting link
[   20.253590][   T30] hardreset, Online=3D>Offline
[   20.253629][   T30] Reconfig spd
[   20.259389][   T30] resume, do loop
[   20.478955][   T30] resume, after do loop
[   20.487598][   T30] debounce, SCR=3D0x0
[   20.496754][   T30] debounce, SCR=3D0x0
[   20.505571][   T30] debounce, SCR=3D0x0
[   20.514378][   T30] debounce, SCR=3D0x0
[   20.523164][   T30] debounce, SCR=3D0x0
[   20.531949][   T30] debounce, SCR=3D0x0
[   20.540734][   T30] debounce, SCR=3D0x0
[   20.549520][   T30] debounce, SCR=3D0x0
[   20.558304][   T30] debounce, SCR=3D0x0
[   20.567110][   T30] debounce, SCR=3D0x0
[   20.575917][   T30] debounce, SCR=3D0x0
[   20.584730][   T30] debounce, SCR=3D0x0
[   20.593514][   T30] debounce, SCR=3D0x0
[   20.597264][   T30] resume, return at end of function
[   20.601012][   T30] hardreset, ata_phys_link_offline check failed
[   20.606314][   T30] ata2.04: SATA link down (SStatus 0 SControl 300)
[   20.618920][   T30] ata2.05: hard resetting link
[   20.623564][   T30] hardreset, Online=3D>Offline
[   20.623604][   T30] Reconfig spd
[   20.629366][   T30] resume, do loop
[   20.848955][   T30] resume, after do loop
[   20.857600][   T30] debounce, SCR=3D0x0
[   20.866757][   T30] debounce, SCR=3D0x0
[   20.875573][   T30] debounce, SCR=3D0x0
[   20.884379][   T30] debounce, SCR=3D0x0
[   20.893164][   T30] debounce, SCR=3D0x0
[   20.901948][   T30] debounce, SCR=3D0x0
[   20.910734][   T30] debounce, SCR=3D0x0
[   20.919518][   T30] debounce, SCR=3D0x0
[   20.928302][   T30] debounce, SCR=3D0x0
[   20.937108][   T30] debounce, SCR=3D0x0
[   20.945915][   T30] debounce, SCR=3D0x0
[   20.954727][   T30] debounce, SCR=3D0x0
[   20.963512][   T30] debounce, SCR=3D0x0
[   20.967261][   T30] resume, return at end of function
[   20.971011][   T30] hardreset, ata_phys_link_offline check failed
[   20.976314][   T30] ata2.05: SATA link down (SStatus 0 SControl 300)
[   20.988920][   T30] ata2.06: hard resetting link
[   20.993564][   T30] hardreset, Online=3D>Offline
[   20.993604][   T30] Reconfig spd
[   20.999365][   T30] resume, do loop
[   21.218956][   T30] resume, after do loop
[   21.227600][   T30] debounce, SCR=3D0x0
[   21.236757][   T30] debounce, SCR=3D0x0
[   21.245574][   T30] debounce, SCR=3D0x0
[   21.254381][   T30] debounce, SCR=3D0x0
[   21.263166][   T30] debounce, SCR=3D0x0
[   21.271950][   T30] debounce, SCR=3D0x0
[   21.280735][   T30] debounce, SCR=3D0x0
[   21.289519][   T30] debounce, SCR=3D0x0
[   21.298303][   T30] debounce, SCR=3D0x0
[   21.307110][   T30] debounce, SCR=3D0x0
[   21.315917][   T30] debounce, SCR=3D0x0
[   21.324730][   T30] debounce, SCR=3D0x0
[   21.333515][   T30] debounce, SCR=3D0x0
[   21.337264][   T30] resume, return at end of function
[   21.341013][   T30] hardreset, ata_phys_link_offline check failed
[   21.346316][   T30] ata2.06: SATA link down (SStatus 0 SControl 300)
[   21.358921][   T30] ata2.07: hard resetting link
[   21.363565][   T30] hardreset, Online=3D>Offline
[   21.363605][   T30] Reconfig spd
[   21.369367][   T30] resume, do loop
[   21.588955][   T30] resume, after do loop
[   21.597599][   T30] debounce, SCR=3D0x0
[   21.606756][   T30] debounce, SCR=3D0x0
[   21.615571][   T30] debounce, SCR=3D0x0
[   21.624378][   T30] debounce, SCR=3D0x0
[   21.633163][   T30] debounce, SCR=3D0x0
[   21.641948][   T30] debounce, SCR=3D0x0
[   21.650733][   T30] debounce, SCR=3D0x0
[   21.659517][   T30] debounce, SCR=3D0x0
[   21.668301][   T30] debounce, SCR=3D0x0
[   21.677108][   T30] debounce, SCR=3D0x0
[   21.685915][   T30] debounce, SCR=3D0x0
[   21.694727][   T30] debounce, SCR=3D0x0
[   21.703512][   T30] debounce, SCR=3D0x0
[   21.707261][   T30] resume, return at end of function
[   21.711010][   T30] hardreset, ata_phys_link_offline check failed
[   21.716313][   T30] ata2.07: SATA link down (SStatus 0 SControl 300)
[   21.729010][   T30] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, =
max UDMA/133
[   21.736621][   T30] ata2.00: 976773168 sectors, multi 0: LBA48
[   21.742737][   T30] ata2.00: configured for UDMA/133
[   21.747805][   T30] ata2.01: ATA-6: Areca   Archive, 0100 AX, max UDMA=
/133
[   21.754751][   T30] ata2.01: 23437498368 sectors, multi 0: LBA48
[   21.761035][   T30] ata2.01: configured for UDMA/133
[   21.766185][   T30] ata2: EH complete
[   21.770704][   T33] scsi 1:0:0:0: Direct-Access     ATA      WDC WD50A=
RC-5040 n/a  PQ: 0 ANSI: 5
[   21.782846][    T7] sd 1:0:0:0: [sdb] 976773168 512-byte logical block=
s: (500 GB/466 GiB)
[   21.783199][   T33] scsi 1:1:0:0: Direct-Access     ATA      Areca   A=
rchive  n/a  PQ: 0 ANSI: 5
[   21.791187][    T7] sd 1:0:0:0: [sdb] Write Protect is off
[   21.803969][   T36] sd 1:1:0:0: [sdc] 23437498368 512-byte logical blo=
cks: (12.0 TB/10.9 TiB)
[   21.805465][    T7] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   21.814172][   T36] sd 1:1:0:0: [sdc] Write Protect is off
[   21.819944][    T7] sd 1:0:0:0: [sdb] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   21.825358][   T36] sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[   21.835352][    T7] sd 1:0:0:0: [sdb] Preferred minimum I/O size 512 b=
ytes
[   21.841057][   T36] sd 1:1:0:0: [sdc] Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
[   21.858454][   T36] sd 1:1:0:0: [sdc] Preferred minimum I/O size 512 b=
ytes
[   21.865645][    T7] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[   21.868480][   T36] sd 1:1:0:0: [sdc] Attached SCSI removable disk


--- commit reverted, no patch (a different run) ---
[  150.559157][   T30] hardreset, Online=3D>Offline
[  150.559168][   T30] Reconfig spd
[  150.564715][   T30] resume, do loop
[  150.788797][   T30] resume, after do loop
[  150.848797][   T30] debounce, SCR=3D0x100
[  150.908796][   T30] debounce, SCR=3D0x100
[  150.968796][   T30] debounce, SCR=3D0x101
[  151.028796][   T30] debounce, SCR=3D0x100
[  151.088796][   T30] debounce, SCR=3D0x101
[  151.148797][   T30] debounce, SCR=3D0x100
[  151.208796][   T30] debounce, SCR=3D0x100
[  151.268796][   T30] debounce, SCR=3D0x100
[  151.328816][   T30] debounce, SCR=3D0x100
[  151.388796][   T30] debounce, SCR=3D0x100
[  151.448797][   T30] debounce, SCR=3D0x100
[  151.508796][   T30] debounce, SCR=3D0x100
[  151.568796][   T30] debounce, SCR=3D0x100
[  151.628796][   T30] debounce, SCR=3D0x100
[  151.688796][   T30] debounce, SCR=3D0x100
[  151.692653][   T30] resume, return at end of function
[  151.696510][   T30] hardreset, ata_phys_link_offline check failed
[  151.701613][   T30] ata2: SATA link down (SStatus 100 SControl 300)
[  151.714078][   T30] hardreset, Online=3D>Offline
[  151.715154][   T30] resume, do loop
[  151.948797][   T30] resume, after do loop
[  152.008796][   T30] debounce, SCR=3D0x100
[  152.068797][   T30] debounce, SCR=3D0x100
[  152.128796][   T30] debounce, SCR=3D0x100
[  152.188796][   T30] debounce, SCR=3D0x100
[  152.248796][   T30] debounce, SCR=3D0x100
[  152.308796][   T30] debounce, SCR=3D0x100
[  152.368816][   T30] debounce, SCR=3D0x100
[  152.428797][   T30] debounce, SCR=3D0x100
[  152.488796][   T30] debounce, SCR=3D0x100
[  152.492654][   T30] resume, return at end of function
[  152.496511][   T30] hardreset, ata_phys_link_offline check failed
[  152.501610][   T30] ata2: SATA link down (SStatus 100 SControl 300)
[  152.786601][   T30] ata2: limiting SATA link speed to 1.5 Gbps
[  152.792489][   T30] hardreset, Online=3D>Offline
[  152.792494][   T30] Reconfig spd
[  152.798032][   T30] resume, do loop
[  153.028797][   T30] resume, after do loop
[  153.088796][   T30] debounce, SCR=3D0x113
[  153.148796][   T30] debounce, SCR=3D0x113
[  153.208796][   T30] debounce, SCR=3D0x113
[  153.268796][   T30] debounce, SCR=3D0x113
[  153.328796][   T30] debounce, SCR=3D0x113
[  153.388795][   T30] debounce, SCR=3D0x113
[  153.448796][   T30] debounce, SCR=3D0x113
[  153.508796][   T30] debounce, SCR=3D0x113
[  153.568796][   T30] debounce, SCR=3D0x113
[  153.572654][   T30] resume, return at end of function
[  153.576511][   T30] hardreset, Offline=3D>Online
[  153.586069][   T30] hardreset, sata_pmp_supported, before check_ready
[  153.758800][   T30] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
[  153.772539][   T30] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, =
8 ports, feat 0xf/0x1f

So, is this a quirk of the mvebu controller or the Areca DAS? BTW, Areca =
uses some mvebu SOC too.
I'm going to try the Areca DAS with a few other controllers. I want to se=
e what happens.

Marius Dinu

