Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C38142
	for <linux-ide@archiver.kernel.org>; Tue, 24 Jan 2023 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjAXRD5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjAXRDl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2023 12:03:41 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E11A474D9
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2023 09:02:57 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=KC/Ggk8vo2HC7qSfNwx+RT9d1YUyQ8PGK90i1O/phk4=;
        b=h3Q/DqIVlHNMFZwmVf64SdTwVZUfC5Oqs0fyQIxp8jC9UhVAHUl8wktMkZuHZwShfhU1L+i+9bqUADAx4Kcr5HE4F6kTmOhkDmP/I0VR5y7PF3aEFXbDdx5fzxFnxH05KFNRN8q5R7I88W/dIKvqF5LTRRfFZzzPpLwi/Hm0vezCv6Vm+lF7eJLRQozfYFIoGZxC4n7Dp2OxtTYCh60jSBQHNRhqRxkqifU/sgnd7hn+ndDHD4C038SkGo
        CVdCx8AYTjSIZ2+jIzDNSQy4u+86cJqKJxLlB5n1lP5Z467n7gOY8sjxFI6zw/ADtcKliZiFEtMcx9fLlK2DlabNlj5Q==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 24 Jan 2023 17:02:55 +0000
MIME-Version: 1.0
Date:   Tue, 24 Jan 2023 17:02:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <f4d558fd-343a-8cb5-605d-574af42ad3db@opensource.wdc.com>
References: <f4d558fd-343a-8cb5-605d-574af42ad3db@opensource.wdc.com>
 <fa7f7eea-7b43-f2d7-18e5-f253ed316919@opensource.wdc.com>
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
 <44527e2f8583a8ce51b1241bf9e56595@psihoexpert.ro>
 <45337bf4a17c9c879f9439c1138bc443@psihoexpert.ro>
 <7fe0b96f30bf787d339ba656d5d2df01@psihoexpert.ro>
 <db3fa398d4a1dcadb9df02d1001a61c6@psihoexpert.ro>
X-Originating-IP: 188.24.134.78
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 24, 2023 11:54 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> OK. Good. But from the trace below, it looks like you have the previous
> patch still applied. Can you try only the above patch ?

Done:
[ 15.135173][ T113] hardreset, Online=3D>Offline
[ 15.135182][ T113] sata_set_spd_needed, scontrol=3D0x300
[ 15.139656][ T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 15.144934][ T113] __sata_set_spd_needed, corrected limit=3D0xFFFFFFFF
[ 15.151235][ T113] __sata_set_spd_needed, target=3D0x0
[ 15.157725][ T113] __sata_set_spd_needed, spd=3D0x0
[ 15.162805][ T113] __sata_set_spd_needed, final *scontrol=3D0x300
[ 15.168708][ T113] resume, do loop
[ 15.403902][ T113] resume, after do loop
[ 15.463901][ T113] debounce, SCR=3D0x100
[ 15.513923][ T113] debounce, SCR=3D0x101
[ 15.573901][ T113] debounce, SCR=3D0x100
[ 15.633901][ T113] debounce, SCR=3D0x101
[ 15.693901][ T113] debounce, SCR=3D0x100
[ 15.753901][ T113] debounce, SCR=3D0x101
[ 15.813900][ T113] debounce, SCR=3D0x100
[ 15.873901][ T113] debounce, SCR=3D0x101
[ 15.933900][ T113] debounce, SCR=3D0x100
[ 15.993900][ T113] debounce, SCR=3D0x100
[ 16.053900][ T113] debounce, SCR=3D0x100
[ 16.113901][ T113] debounce, SCR=3D0x100
[ 16.173900][ T113] debounce, SCR=3D0x100
[ 16.233901][ T113] debounce, SCR=3D0x0
[ 16.293901][ T113] debounce, SCR=3D0x0
[ 16.353900][ T113] debounce, SCR=3D0x0
[ 16.413901][ T113] debounce, SCR=3D0x0
[ 16.473901][ T113] debounce, SCR=3D0x100
[ 16.477586][ T113] resume, return at end of function
[ 16.481446][ T113] hardreset, ata_phys_link_offline check failed
[ 16.486550][ T113] ata2: SATA link down (SStatus 100 SControl 300)
[ 16.499019][ T113] sata_down_spd_limit: limit 0x1, cur spd 0x0, saved li=
mit 0xffffffff, hw limit
0xffffffff
[ 16.508914][ T113] ata2: limiting SATA link speed to 1.5 Gbps
[ 16.514800][ T113] hardreset, Online=3D>Offline
[ 16.514807][ T113] sata_set_spd_needed, scontrol=3D0x300
[ 16.519276][ T113] __sata_set_spd_needed, initial limit=3D0x1
[ 16.524544][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 16.530235][ T113] __sata_set_spd_needed, target=3D0x1
[ 16.536119][ T113] __sata_set_spd_needed, spd=3D0x0
[ 16.541199][ T113] __sata_set_spd_needed, final *scontrol=3D0x310
[ 16.546046][ T113] __sata_set_spd_needed, initial limit=3D0x1
[ 16.552085][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 16.557790][ T113] __sata_set_spd_needed, target=3D0x1
[ 16.563655][ T113] __sata_set_spd_needed, spd=3D0x0
[ 16.568748][ T113] __sata_set_spd_needed, final *scontrol=3D0x314
[ 16.574637][ T113] resume, do loop
[ 16.803902][ T113] resume, after do loop
[ 16.863901][ T113] debounce, SCR=3D0x113
[ 16.923901][ T113] debounce, SCR=3D0x113
[ 16.983901][ T113] debounce, SCR=3D0x113
[ 17.043900][ T113] debounce, SCR=3D0x113
[ 17.103901][ T113] debounce, SCR=3D0x113
[ 17.163901][ T113] debounce, SCR=3D0x113
[ 17.223901][ T113] debounce, SCR=3D0x113
[ 17.283900][ T113] debounce, SCR=3D0x113
[ 17.343900][ T113] debounce, SCR=3D0x113
[ 17.347761][ T113] resume, return at end of function
[ 17.351620][ T113] hardreset, Offline=3D>Online
[ 17.361184][ T113] hardreset, sata_pmp_supported, before check_ready
[ 17.533905][ T113] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
[ 17.547634][ T113] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 p=
orts, feat 0xf/0x1f
[ 17.556257][ T113] device: 'link2.0': device_add
[ 17.561066][ T113] device: 'link2.0': device_add
[ 17.566026][ T113] device: 'dev2.0.0': device_add
[ 17.570872][ T113] device: 'dev2.0.0': device_add
[ 17.575869][ T113] device: 'link2.1': device_add
[ 17.580628][ T113] device: 'link2.1': device_add
[ 17.585489][ T113] device: 'dev2.1.0': device_add
[ 17.590370][ T113] device: 'dev2.1.0': device_add
...
[ 17.830354][ T113] device: 'link2.14': device_add
[ 17.835236][ T113] device: 'link2.14': device_add
[ 17.840174][ T113] device: 'dev2.14.0': device_add
[ 17.845134][ T113] device: 'dev2.14.0': device_add
[ 17.850194][ T113] ahci-mvebu f10a8000.sata: FBS is enabled
[ 17.855948][ T113] ata2.00: SCR_CONTROL =3D 0x300
[ 17.860630][ T113] ata2.01: SCR_CONTROL =3D 0x300
[ 17.865332][ T113] ata2.02: SCR_CONTROL =3D 0x300
[ 17.870010][ T113] ata2.03: SCR_CONTROL =3D 0x300
[ 17.874720][ T113] ata2.04: SCR_CONTROL =3D 0x300
[ 17.879397][ T113] ata2.05: SCR_CONTROL =3D 0x300
[ 17.884140][ T113] ata2.06: SCR_CONTROL =3D 0x300
[ 17.888817][ T113] ata2.07: SCR_CONTROL =3D 0x300
[ 17.893568][ T113] ata2.00: hard resetting link
[ 17.898247][ T113] hardreset, Online=3D>Offline
[ 17.898287][ T113] sata_set_spd_needed, scontrol=3D0x300
[ 17.902759][ T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 17.908037][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 17.914351][ T113] __sata_set_spd_needed, target=3D0x1
[ 17.920217][ T113] __sata_set_spd_needed, spd=3D0x0
[ 17.925308][ T113] __sata_set_spd_needed, final *scontrol=3D0x310
[ 17.930221][ T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 17.936287][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 17.942587][ T113] __sata_set_spd_needed, target=3D0x1
[ 17.948465][ T113] __sata_set_spd_needed, spd=3D0x0
[ 17.953544][ T113] __sata_set_spd_needed, final *scontrol=3D0x310
[ 17.959580][ T113] resume, do loop
[ 18.193937][ T113] resume, after do loop
[ 18.202581][ T113] debounce, SCR=3D0x123
[ 18.211737][ T113] debounce, SCR=3D0x123
[ 18.220718][ T113] debounce, SCR=3D0x123
[ 18.229700][ T113] debounce, SCR=3D0x123
[ 18.238661][ T113] debounce, SCR=3D0x123
[ 18.247624][ T113] debounce, SCR=3D0x123
[ 18.256584][ T113] debounce, SCR=3D0x123
[ 18.265545][ T113] debounce, SCR=3D0x123
[ 18.274506][ T113] debounce, SCR=3D0x123
[ 18.283466][ T113] debounce, SCR=3D0x123
[ 18.292447][ T113] debounce, SCR=3D0x123
[ 18.301429][ T113] debounce, SCR=3D0x123
[ 18.305373][ T113] resume, return at end of function
[ 18.309265][ T113] hardreset, Offline=3D>Online
[ 18.318828][ T113] hardreset, after check_ready
[ 18.319045][ T113] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
[ 18.330915][ T113] ata2.01: hard resetting link
[ 18.335582][ T113] hardreset, Online=3D>Offline
[ 18.335619][ T113] sata_set_spd_needed, scontrol=3D0x300
[ 18.340090][ T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 18.345365][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 18.351665][ T113] __sata_set_spd_needed, target=3D0x1
[ 18.357543][ T113] __sata_set_spd_needed, spd=3D0x0
[ 18.362624][ T113] __sata_set_spd_needed, final *scontrol=3D0x310
[ 18.367549][ T113] __sata_set_spd_needed, initial limit=3D0xFFFFFFFF
[ 18.373589][ T113] __sata_set_spd_needed, corrected limit=3D0x1
[ 18.379911][ T113] __sata_set_spd_needed, target=3D0x1
[ 18.385790][ T113] __sata_set_spd_needed, spd=3D0x0
[ 18.390870][ T113] __sata_set_spd_needed, final *scontrol=3D0x310
[ 18.396900][ T113] resume, do loop
[ 18.623935][ T113] resume, after do loop
[ 18.632578][ T113] debounce, SCR=3D0x123
[ 18.641735][ T113] debounce, SCR=3D0x123
[ 18.650715][ T113] debounce, SCR=3D0x123
[ 18.659695][ T113] debounce, SCR=3D0x123
[ 18.668654][ T113] debounce, SCR=3D0x123
[ 18.677614][ T113] debounce, SCR=3D0x123
[ 18.686575][ T113] debounce, SCR=3D0x123
[ 18.695535][ T113] debounce, SCR=3D0x123
[ 18.704496][ T113] debounce, SCR=3D0x123
[ 18.713456][ T113] debounce, SCR=3D0x123
[ 18.722438][ T113] debounce, SCR=3D0x123
[ 18.731421][ T113] debounce, SCR=3D0x123
[ 18.735365][ T113] resume, return at end of function
[ 18.739256][ T113] hardreset, Offline=3D>Online
[ 18.748820][ T113] hardreset, after check_ready
[ 18.749041][ T113] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)

Marius Dinu

