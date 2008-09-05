From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: HPT374 detection crash with 74811f355f4f69a187fa74892dcf2a684b84ce99
Date: Fri, 05 Sep 2008 20:16:18 +0400
Message-ID: <48C15B52.6020508@ru.mvista.com>
References: <1a9da18c0809041610tb3f2a58r6acd6f10a3d50a91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60591 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754309AbYIEQPp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Sep 2008 12:15:45 -0400
In-Reply-To: <1a9da18c0809041610tb3f2a58r6acd6f10a3d50a91@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?Ik1hc291ZCBTaGFyYmlhbmkgXCLZhdiz2LnZiNivINi02LHYqNuM2KfZhtuM?= =?UTF-8?B?XCIi?= <masouds@masoud.ir>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

Masoud Sharbiani "=D9=85=D8=B3=D8=B9=D9=88=D8=AF =D8=B4=D8=B1=D8=A8=DB=8C=
=D8=A7=D9=86=DB=8C" wrote:

> Hi there, Looks like your commit 74811f355f4f69a187fa74892dcf2a684b84=
ce99
>  (hpt366: convert to use ->host_priv)

    Thanks for doing the bisection.

> has caused the following crash:

    Oops, we did it again. :-)

> (Full dmesg follows, as captured from a serial console)

> [   22.555200] hpt366: HPT374 chipset detected
> [   22.559489] hpt366 0000:03:06.0: IDE controller (0x1103:0x0008 rev=
 0x07)
> [   22.566278] HPT366_IDE 0000:03:06.0: PCI INT A -> GSI 28 (level, l=
ow) -> IRQ 28
> [   22.573729] usb 1-2: new full speed USB device using uhci_hcd and =
address 4
> [   22.580726] pci 0000:03:06.1: PCI INT A -> GSI 28 (level, low) -> =
IRQ 28
> [   22.587529] hpt366 0000:03:06.0: DPLL base: 48 MHz, f_CNT: 142, as=
suming 33 MHz PCI
> [   22.602705] hpt366 0000:03:06.0: using 50 MHz DPLL clock
> [   22.608181] hpt366 0000:03:06.0: 100% native mode on irq 28
> [   22.613831] hpt366 0000:03:06.1: no clock data saved by BIOS

    Aha, HPT374 workaround for reading BIOS clock data didn't get execu=
ted.

> [   22.731015] usb 1-2: configuration #1 chosen from 1 choice
> [   22.737191] ata2.00: ATA-6: ST3120022A, 3.04, max UDMA/100
> [   22.738880] hub 1-2:1.0: USB hub found
> [   22.746597] ata2.00: 234441648 sectors, multi 16: LBA48
> [   22.747804] hpt366 0000:03:06.1: DPLL base: 33 MHz, f_CNT: 139, as=
suming

    Uh, I wonder where did it get those 33 MHz DPLL base -- there's sim=
ply no=20
such base.  Looks like memory addressed by .host_priv got corrupt...

MBR, Sergei
