From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 15:39:40 +0100
Message-ID: <200901221539.40769.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901221212.55528.stf_xl@wp.pl> <49786138.20809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:8508 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbZAVOjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:39:47 -0500
In-Reply-To: <49786138.20809@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Thursday 22 January 2009 13:06:16 Sergei Shtylyov napisa=C5=82(a):
> > Hmm, you may have right, because I can see warning=20
> >
> > hda: probing with STATUS(0x50) instead of ALTSTATUS(0x00)
> >
> > but I don't understand this issue, I'm going to investigate.
> >  =20
>=20
>    I think it's exactly due to the driver reading alternate status fr=
om=20
> 0x00e00000 ISO 0x00e00006. Soft reset also won't work because of the=20
> wrong address.
Right, I change the address and warning disappear.

Thanks
Stanislaw Gruszka
