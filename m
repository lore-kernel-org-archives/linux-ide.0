From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-generic: handle probing of legacy io-ports v5 (was: Re: [PATCH 1/2] pata_legacy: export functionality to ide)
Date: Thu, 7 Aug 2008 19:06:35 +0200
Message-ID: <200808071906.35569.bzolnier@gmail.com>
References: <20080803165135.GA31977@gollum.tnic> <489A03C3.5070607@ru.mvista.com> <20080807043621.GA3771@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:31263 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbYHGRPP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Aug 2008 13:15:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so303553fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 07 Aug 2008 10:15:14 -0700 (PDT)
In-Reply-To: <20080807043621.GA3771@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Thursday 07 August 2008, Borislav Petkov wrote:

[...]

> Here's v5:
> 
> ---
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

applied, thanks
