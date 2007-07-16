From: yulin <yulin@starsoftcomm.com>
Subject: Re: [PATCH 2.6.22-rc4]: libata: PATA-mode fixes for sis_sata
Date: Mon, 16 Jul 2007 17:20:45 +0800
Message-ID: <469B386D.8020709@starsoftcomm.com>
References: <200706142340.44068.uwe.koziolek@gmx.net>	<469AD93B.6090509@starsoftcomm.com> <20070716100401.7a0b850e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.starsoftcomm.com ([211.100.62.25]:56824 "EHLO
	mail.starsoftcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXGPJQ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:16:58 -0400
In-Reply-To: <20070716100401.7a0b850e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, micha.biermann@gmx.de

Alan Cox =E5=86=99=E9=81=93:
>> So one leader of our IT, who is a Windows expert, suggested we can u=
se=20
>> int 13h and I/O in Linux. But int 13h just is used in real mode.
>>
>> Can you give me some advice to persuade him? If it is feasible, can =
you=20
>> introduce me?
>>    =20
>
> int13 is real mode only, runs polled and 16bit with one command at a
> time. As far as I know even Windows no longer uses it for anything bu=
t
> booting.
>
>  =20
>> Even can you give some good solutions to solve the compatibility pro=
blem?
>>    =20
>
> For hardware where we have info the right answer is to report bugs an=
d
> get them fixed (or indeed send fixes). For the more general case the
> ata_generic driver will drive anything that is SFF8038i compliant and=
 you
> can just add PCI identifiers to it for anything you hit.
>
> I am working on a generic ACPI driver to go with it for such cases.
>
> Alan
>
>
>  =20

Thank you for your help and explanations.

I will do some research work on ata_generic driver. Can you give me som=
e=20
advice or related information to do deeper research?

I alse found the problem of ACPI in our product, so we turn it off, but=
=20
always caused some other problems. So i think a generic ACPI driver wil=
l=20
be welcome.

And your mail is the best message received today before going home.

:)

 From YuLin
