From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 15:13:29 +0100
Message-ID: <200901221513.29755.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901221414.39802.stf_xl@wp.pl> <49787929.2010305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:31723 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbZAVONi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:13:38 -0500
In-Reply-To: <49787929.2010305@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Thursday 22 January 2009 14:48:25 Sergei Shtylyov napisa=C5=82(a):
> Stanislaw Gruszka wrote:
>=20
> >>>>>+/* Proper CS address space will be added */
> >>>>>+#define AT91_IDE_TASK_FILE	0x00c00000
> >>>>>+#define AT91_IDE_CTRL_REG	0x00e00000
>=20
> >>   Besides, I'm not sure: these 2 address range are decoded via 1 S=
MC=20
> >>chip select or 2?
>=20
> > These are in one chip select address space.
>=20
>     Then some external circutry converts the single nCS into -CS0 and=
 -CS1?

-CS0 -CS1 are controlled by address lines A[23:21]
0x00c00000 give -CS1=3D1 -CS1=3D0=20
0x00e00000 give -CS0=3D0 -CS1=3D1=20

Stanislaw Gruszka
