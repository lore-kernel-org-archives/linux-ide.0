From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Wed, 19 Mar 2008 20:43:03 +0900
Message-ID: <47E0FC47.8040902@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200803190853.10030.volker.armin.hemmann@tu-clausthal.de> <47E0D5C8.9070005@gmail.com> <200803191108.18577.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:36095 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765275AbYCSUOD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Mar 2008 16:14:03 -0400
Received: by wf-out-1314.google.com with SMTP id 28so597306wff.4
        for <linux-ide@vger.kernel.org>; Wed, 19 Mar 2008 13:14:00 -0700 (PDT)
In-Reply-To: <200803191108.18577.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Volker Armin Hemmann wrote:
> On Mittwoch, 19. M=E4rz 2008, Tejun Heo wrote:
>> x UDMA/133 abar m8192@0xf9dfc000 port 0xf9dfc200
>>
>>> irq 315
>>> [   38.125479] ata4: SATA max UDMA/133 abar m8192@0xf9dfc000 port
>>> 0xf9dfc280 irq 315
>>> [   38.597035] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
>>> [   38.597732] ata1.00: ATA-7: WDC WD1600JS-00MHB1, 10.02E01, max
>>> UDMA/133 [   38.597775] ata1.00: 312581808 sectors, multi 16: LBA48
>>> [   38.598405] ata1.00: configured for UDMA/133
>>> [   39.069342] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 30=
0)
>>> [   39.084225] ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-12, max UDMA7
>>> [   39.084264] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (dep=
th
>>> 0/32) [   39.086268] ata2.00: configured for UDMA/133
>> So, just to confirm.  With the updated patch, you don't see any prob=
lem,
>> right?
>=20
> Correct. With the updated patch I don't see problems in 'non-raid' mo=
de. AHCI=20
> mode still has problems without nosmi. But that is an entirely differ=
ent=20
> problem, right?

Yeap, can you please post the result of "lspci -nn"?

--=20
tejun
