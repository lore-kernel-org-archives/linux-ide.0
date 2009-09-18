From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata:ide: Fix udma timings of pdc202xx_old controllers
Date: Fri, 18 Sep 2009 15:52:50 +0400
Message-ID: <4AB37492.90407@ru.mvista.com>
References: <8b5805ff0909171602v3dc10db9i5920be3a2abf2e04@mail.gmail.com> 	<20090918002322.54099f94@lxorguk.ukuu.org.uk> <8b5805ff0909171654i515c832bm570db9bd5936b11a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32958 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753899AbZIRLuV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Sep 2009 07:50:21 -0400
In-Reply-To: <8b5805ff0909171654i515c832bm570db9bd5936b11a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jung-Ik (John) Lee" <jilee@google.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Jung-Ik (John) Lee wrote:

>>>From: John(Jung-Ik) Lee <jilee@google.com>

>>>Fix udma timings of pdc202xx_old controllers.
>>>MB=3D1, MC=3D1 (0x20, 0x01) for all UDMA modes of pdc2026{57}.

    The patch should be broken in two as it's for 2 different subsystem=
s.

>>On what documentation is this based ?

> I have two documents, 20265, and 20267, and both need to set to the
> same single value for all UDMA modes.

> Doc 1:
>   PDC20265 Bus Mastering Ultra DMA PCI =96ATA/ATAPI Controller
> Specification Rev 2.0
>   #7.17.2, Ultra DMA Data Transfer Speed list
>     For all Ultra DMA mode, MB, MC =3D 01h, 01h

> Doc 2:
>   PDC20267 Bus Mastering Ultra DMA PCI =96ATA/ATAPI Controller
> Specification Rev 2.0
>   #7.17.2, Ultra DMA Data Transfer Speed list
>     For all Ultra DMA mode, MB, MC =3D 01h, 01h

> Are there other pdc202xx old controllers that are different?

    There are PDC20262 and PDC20246. We should ask Bart -- he probably =
has=20
the documatation for them...

> -John

>>Alan

WBR, Sergei

