From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 15:13:22 +0200
Message-ID: <4546329.1O9421M58I@wuerfel>
References: <1462970683-451525-1-git-send-email-arnd@arndb.de> <yw1xh9e4hhwb.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53955 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbcEKNNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2016 09:13:53 -0400
In-Reply-To: <yw1xh9e4hhwb.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 11 May 2016 13:57:08 M=E5ns Rullg=E5rd wrote:
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index 41b0725e58ad..8f7a4a4d2566 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -322,7 +322,7 @@ config SATA_DWC
> >
> >  config SATA_DWC_OLD_DMA
> >       bool "Support old device trees"
> > -     depends on SATA_DWC
> > +     depends on SATA_DWC && DMADEVICES
> >       select DW_DMAC_CORE
> >       default y if 460EX
> >       help
> > --=20
>=20
> Isn't the proper fix here to have DW_DMAC_CORE select DMADEVICES?

No, all dmaengine drivers depend on DMADEVICES, so that would
cause a circular dependency.

The normal behavior for DMA slave drivers is to use the generic
DMA API and have a dependency on DMADEVICES but not on a particular
DMA engine implementation. In this case, the driver uses an exported
interface of the dw_dma driver directly, so we also need to select
that one, but it doesn't mean we can skip the normal dependency.

	Arnd
