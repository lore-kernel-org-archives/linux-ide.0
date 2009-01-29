From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 29 Jan 2009 15:48:32 +0100
Message-ID: <200901291548.33238.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <49787929.2010305@ru.mvista.com> <497F2C5E.9020205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:57857 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbZA2Oso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jan 2009 09:48:44 -0500
In-Reply-To: <497F2C5E.9020205@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Tuesday 27 January 2009 16:46:38 Sergei Shtylyov napisa=C5=82(a):
> Hello, I wrote:
>=20
> >>>> Well, we could add #ifdef with diffrent implementation of=20
> >>>> init_smc_mode(), set_8bit_mode(), etc...=20
>=20
> >>>   No, #ifdef'ery is certainly not an option.
>=20
> >> Why?
>=20
> >    It's totally ugly and unacceptable way of doing things. It seems=
 also=20
> > totally wrong to add support for totally incompatible SMC to this d=
river=20
> > (especially with #ifdef's). Another driver should be written if CF=20
> > support is required.
>=20
> >> Other option is create some header files and implement and exporti=
ng=20
> >> these
> >> functions from processor specific code. This add files dependencie=
s=20
> >> and spread
> >> things across sources, FWIW.
>=20
> >    I don't think it's feasible as that SMC is just too different.
>=20
>     Besides, AT91RM9200 code turned out to already be registering a p=
latform=20
> device called at91_cf -- driver for which I have located in drivers/p=
cmcia/,=20
> so apparently they're not interested in True IDE mode support (and ha=
ve=20
> overgeneralized the name as well :-).
There can be AT91RM9200 boards where is only IDE hardware instead
"full" Compact Flash support.

Atmel publish application note with description how connect HDD to AT91=
RM9200.
Connection is very similar as for SAM9, the major difference is using G=
PIO to control=20
CF ~CSx signals. Here is document:

http://www.atmel.com/dyn/resources/prod_documents/doc6023.pdf

Currently people at at91.com forum did board with HDD. As driver
they use pata_platform with some hacks, which look very similar
as things in this driver, except they use polling and not need irq quir=
k:

http://www.at91.com/samphpbb/viewtopic.php?f=3D9&t=3D4528&p=3D15739

Stanislaw Gruszka
