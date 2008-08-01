From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: fix out-of-bounds access in pata_oldpiix.c
Date: Fri, 01 Aug 2008 13:35:06 +0900
Message-ID: <4892927A.1000808@kernel.org>
References: <488040E4.1090500@gmx.ch> <20080718095541.6bf01fff@the-village.bc.nu> <200807181615.26272.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40688 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbYHAEfq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Aug 2008 00:35:46 -0400
In-Reply-To: <200807181615.26272.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?UTF-8?B?RGF2aWQgTcO8bGxlcg==?= <dave.mueller@gmx.ch>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Friday 18 July 2008, Alan Cox wrote:
>> On Fri, 18 Jul 2008 09:06:12 +0200
>> David M=C3=BCller <dave.mueller@gmx.ch> wrote:
>>
>>> The "pata_oldpiix" driver in linux-2.6.26 is calling its "set_dmamo=
de"=20
>>> routine also locally, but under different preconditions as the=20
>>> corresponding call in libata-core.c. This may cause an "out-of-arra=
y=20
>>> bounds" access in "oldpiix_set_dmamode".
>> This looks wrong adev->dma_mode should never be invalid at this poin=
t.
>> Are you not confusing dma_mask and dma_mode. Can you provide the
>> backtraces of the failing case and the actual chip variant you are u=
sing ?
>>
>> Either way the fix is not in oldpiix if this is appearing as 0xFF bu=
t in
>> the core code so NAK
>=20
> ->dma_mode =3D=3D 0xff means that DMA is unsupported by a given devic=
e
> and according to the core code it is a valid ->dma_mode setting.
>=20
> This may want to be changed in the future but as the things are right
> now David's patch is correct and fixes a real bug.  Please UNNAK.

Alan, David's patch is correct.  0xff indicates unsupported transfer
mode (mainly because 0x00 is valid PIO mode).  ->set_pio/dmamode won't
see it as libata-core won't call them if unsupported but qc_issue will
see it.  Can you please unnak?

--=20
tejun
