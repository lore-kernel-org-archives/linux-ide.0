From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide-generic: handle probing of legacy io-ports v5
Date: Fri, 08 Aug 2008 14:04:06 +0400
Message-ID: <489C1A16.2050307@ru.mvista.com>
References: <20080803165135.GA31977@gollum.tnic> <4898630C.7090403@ru.mvista.com> <9ea470500808050732s7be29360ge358790e955be06a@mail.gmail.com> <58cb370e0808050741v7ff3f20awb3d91a84486f8547@mail.gmail.com> <20080806061023.GA23773@gollum.tnic> <48998C58.20703@ru.mvista.com> <9ea470500808060703p4a94c868i25106e081aad75c4@mail.gmail.com> <4899C9F4.9040002@ru.mvista.com> <20080806194754.GC31312@gollum.tnic> <489A03C3.5070607@ru.mvista.com> <20080807043621.GA3771@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:22280 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751659AbYHHKEO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 06:04:14 -0400
In-Reply-To: <20080807043621.GA3771@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.orglinux

Hello.

Borislav Petkov wrote:

> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Sun, 3 Aug 2008 18:46:35 +0200
> Subject: [PATCH] ide-generic: handle probing of legacy io-ports v5
>
> Avoid probing the io-ports in case an IDE PCI controller is present and it
> uses the legacy iobases. If we still want to enforce the probing, we do
>
> ide_generic.probe_mask=0x3f
>
> on the kernel command line. The iobase checking code is
> adapted from drivers/ata/pata_legacy.c after converting hex
> pci ids into their corresponding macros in <linux/pci_ids.h>.
>
> Also, check only BAR0/2 resources since those are guaranteed
> by the workaround in drivers/pci/probe.c:pci_setup_device().
>
> CC: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


