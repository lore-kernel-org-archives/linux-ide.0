Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7CAC636D3
	for <linux-ide@archiver.kernel.org>; Tue,  7 Feb 2023 18:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBGSkb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBGSka (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 7 Feb 2023 13:40:30 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8F1C31B
        for <linux-ide@vger.kernel.org>; Tue,  7 Feb 2023 10:40:12 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=KLS+xqRfeDoO6woSIv4nw3sP9OcovLQ7DHKqgxqX3ww=;
        b=Ky/1QzEjm7DW+J6x5TeS3EXrkRNu4/K8yJgsNrhb/mvAGUulu/5aBY5nyiMxxCTe1ovBxY+hmNd5V6peeq8raNgBHambduaiZQuLEb05K+Zrl+S3D8cuU+lpfLXTRT+Pi070r4GM5iD4J9gRQYfXeCgE3YhI7uyF6eJLwVBslUfOk388r1KY+JbdDHi16PuFDi+L/B+WkdUERC5/ellFpebc1XfRPO1YC5j+DM0yAdDZaQdlS12QtGqUxS
        SWNr5f++jxguDhTvoqruWtAUFNSTtw/JExnnvkj++cRilrqSkib6tbwB3qsCS/kIm+MZUlwuZeKZb6u+GLa56y9/25NQ==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Tue, 7 Feb 2023 18:40:00 +0000
MIME-Version: 1.0
Date:   Tue, 07 Feb 2023 18:40:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <6936c460663c956b5c77215eeef140d7@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <1e069565-a391-0f33-0714-ba9cc3792a42@opensource.wdc.com>
References: <1e069565-a391-0f33-0714-ba9cc3792a42@opensource.wdc.com>
 <1831eb01-5c84-54f1-7950-9b8e9bf0a046@opensource.wdc.com>
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
 <c7e1b214fca6c2a08dbce60006442dd8@psihoexpert.ro>
 <009822d6-24b8-739d-e7ee-13adc1c7d548@opensource.wdc.com>
 <55834657003f5a4579b326ee61fe1e80@psihoexpert.ro>
 <8cd8066ac1059ae0fef280a3cf6ab03c@psihoexpert.ro>
 <9490768bca8f5a213d89214ca9324fa0@psihoexpert.ro>
 <071bf5d4-4007-6779-60fd-82ec58dd44fe@opensource.wdc.com>
 <d8abdd49a63106081b4f899f8bc53dbe@psihoexpert.ro>
X-Originating-IP: 188.24.148.115
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

January 31, 2023 9:28 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc.=
com> wrote:

> I did testing on Intel & AMD machines with different adpaters/drives/pm=
p that I
> have (AHCI, ASMedia and Marvell adapters). Everything was OK on my end.
>=20
>=20The tag is for this kernel only. If backporting to 5.15 does not solv=
e the
> issue, we will need to take that separately and redo debugging on that =
version.
> I would like to send the patch to Linus by the end of the week...
>=20
>=20--
> Damien Le Moal
> Western Digital Research

I saw that the patch was applied to v5.15 too. That was probably not a go=
od ideea. This weekend I tried to test the patch in OpenWrt kernel v5.15.=
 It doesn't work:

--- RAID box connected ---
[ 1772.100899] ata2: SATA link down (SStatus 111 SControl 310)
[ 1772.114132] ata2: limiting SATA link speed to 1.5 Gbps
...and these two lines repeat forever. There is no "giving up".

I tried the workaround "libata.force=3D2:1.5Gbps". It works, but with a d=
elay:

[ 116.705772] ata2: SATA link down (SStatus 101 SControl 300)
[ 119.175752] ata2: COMRESET failed (errno=3D-32)
[ 119.180133] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 127.205713] ata2: limiting SATA link speed to <unknown>
[ 129.475703] ata2: COMRESET failed (errno=3D-32)
[ 129.480084] ata2: reset failed (errno=3D-32), retrying in 8 secs
[ 137.445667] ata2: limiting SATA link speed to <unknown>
[ 139.715666] ata2: COMRESET failed (errno=3D-32)
[ 139.720052] ata2: reset failed (errno=3D-32), retrying in 33 secs
[ 172.645529] ata2: limiting SATA link speed to <unknown>
[ 173.585525] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 3D0)
[ 173.591831] ata2.15: Port Multiplier 1.2, 0x197b:0x0325 r193, 8 ports, =
feat 0xf/0x1f
[ 173.600838] ahci-mvebu f10a8000.sata: FBS is enabled
[ 173.605977] ata2.00: hard resetting link
[ 173.937078] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 173.943563] ata2.01: hard resetting link
[ 174.277073] ata2.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 174.283555] ata2.02: hard resetting link
[ 174.617075] ata2.02: SATA link down (SStatus 0 SControl 300)
[ 174.622787] ata2.03: hard resetting link
[ 174.957074] ata2.03: SATA link down (SStatus 0 SControl 300)
[ 174.962785] ata2.04: hard resetting link
[ 175.297075] ata2.04: SATA link down (SStatus 0 SControl 300)
[ 175.302784] ata2.05: hard resetting link
[ 175.637072] ata2.05: SATA link down (SStatus 0 SControl 300)
[ 175.642781] ata2.06: hard resetting link
[ 175.977071] ata2.06: SATA link down (SStatus 0 SControl 300)
[ 175.982781] ata2.07: hard resetting link
[ 176.317063] ata2.07: SATA link down (SStatus 0 SControl 300)
[ 176.322839] ata2.00: ATA-6: WDC WD50ARC-5040-VOL#01, 0100 AX, max UDMA/=
133
[ 176.329758] ata2.00: 976773168 sectors, multi 0: LBA48
[ 176.335595] ata2.00: configured for UDMA/133
[ 176.339944] ata2.01: ATA-6: Areca Archive, 0100 AX, max UDMA/133
[ 176.346160] ata2.01: 23437498368 sectors, multi 0: LBA48
[ 176.351830] ata2.01: configured for UDMA/133
[ 176.356303] ata2: EH complete

So probably some other commit needs backporting before this one works. An=
y ideea which might it be?
I will try another bisect when I have time. Any clues would help a lot.

Marius Dinu

