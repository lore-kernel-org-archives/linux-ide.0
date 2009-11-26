From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 16/86] pata_efar: MWDMA0 is unsupported
Date: Thu, 26 Nov 2009 15:53:58 +0100
Message-ID: <200911261553.58941.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170415.5446.15073.sendpatchset@localhost> <20091125172552.6817e3da@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59315 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbZKZOzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Nov 2009 09:55:24 -0500
In-Reply-To: <20091125172552.6817e3da@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 25 November 2009 06:25:52 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:04:15 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_efar: MWDMA0 is unsupported
> > 
> > MWDMA0 timings cannot be met with the PIIX based controller
> > programming interface.
> 
> The efar documentation makes no reference to not being capable of MWDMA0,
> so where does this come from ? No MWDMA0 is an Intel erratum it appears.

No MWDMA0 support is a common issue on all 'PIIX-like' controllers.

In case of this chipset while the (preliminary) documentation claims MWDMA0
support on the 'FEATURES' page the later 'programming guide' part describes
only PIO0-4, SWDMA2, MWDMA1-2 and UDMA0-4 transfer modes as supported.

--
Bartlomiej Zolnierkiewicz
