From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/3 v3] ide: add at91_ide driver
Date: Tue, 10 Mar 2009 22:24:56 +0300
Message-ID: <49B6BE88.1080201@ru.mvista.com>
References: <200902181106.54260.stf_xl@wp.pl> <49B6BDCE.3070403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54573 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752679AbZCJTYR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Mar 2009 15:24:17 -0400
In-Reply-To: <49B6BDCE.3070403@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>

Sergei Shtylyov wrote:

>> This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Static Me=
mory
>> Controller with Compact Flash True IDE Mode logic.

>> Driver have to switch 8/16 bit bus width when accessing Task Tile or=
 Data
>> Register. Moreover some extra things need to be done when setting PI=
O=20
>> mode.
>> Only PIO mode is used, hardware have no DMA support. If interrupt li=
ne is
>> connected through GPIO extra quirk is needed to cope with fake=20
>> interrupts.

>> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

>    This is prolly only me, but I afil to compile this driver with the=
=20
> current arch/arm/configs/at91sam9263ek_defconfig:

>   CC      drivers/ide/at91_ide.o
> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_input_data=E2=80=
=99:
> drivers/ide/at91_ide.c:159: error: implicit declaration of function=20
> =E2=80=98__ide_mm_insw=E2=80=99
> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_output_data=E2=80=
=99:
> drivers/ide/at91_ide.c:174: error: implicit declaration of function=20
> =E2=80=98__ide_mm_outsw=E2=80=99
> drivers/ide/at91_ide.c: In function =E2=80=98at91_ide_tf_load=E2=80=99=
:
> drivers/ide/at91_ide.c:192: error: =E2=80=98task=E2=80=99 undeclared =
(first use in this=20
> function)
> drivers/ide/at91_ide.c:192: error: (Each undeclared identifier is=20
> reported only
> once
> drivers/ide/at91_ide.c:192: error: for each function it appears in.)
> drivers/ide/at91_ide.c: At top level:
> drivers/ide/at91_ide.c:303: warning: initialization from incompatible=
=20
> pointer type
> drivers/ide/at91_ide.c:304: warning: initialization from incompatible=
=20
> pointer type
> make[1]: *** [drivers/ide/at91_ide.o] Error 1
> make: *** [drivers/ide/] Error 2

    Ah, it's only with pata-2.6 series applied. Bart, you clearly need =
to=20
include this driver to some of your patches...

MBR, Sergei
