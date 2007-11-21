From: Vincent Fortier <vincent.fortier1@ec.gc.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB
	(v2)
Date: Wed, 21 Nov 2007 12:39:44 +0000
Message-ID: <1195648784.11490.0.camel@kayak.wul.qc.ec.gc.ca>
References: <47438248.7030704@shaw.ca>
Reply-To: vincent.fortier1@ec.gc.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:38265 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757622AbXKUMpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Nov 2007 07:45:40 -0500
In-Reply-To: <47438248.7030704@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

Le mardi 20 novembre 2007 =E0 18:56 -0600, Robert Hancock a =E9crit :
> This fixes some problems with ATAPI devices on nForce4 controllers in=
 ADMA
> mode on systems with memory located above 4GB. We need to delay setti=
ng the
> 64-bit DMA mask until the PRD table and padding buffer are allocated =
so that
> they don't get allocated above 4GB and break legacy mode (which is ne=
eded for
> ATAPI devices). Also, explicitly set a 32-bit DMA mask before allocat=
ing the
> legacy buffers since setting the DMA mask affects both ports and we n=
eed to
> ensure the second port's buffers are allocated properly (fixes a prob=
lem
> with the previous version of this patch).
>=20
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>=20

Would this be worth sending to stable team for 2.6.22 & 2.6.23 ?

Regards,

- vin
