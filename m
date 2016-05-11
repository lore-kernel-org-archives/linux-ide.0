From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 14:19:05 +0100
Message-ID: <yw1xd1oshgvq.fsf@unicorn.mansr.com>
References: <1462970683-451525-1-git-send-email-arnd@arndb.de>
	<yw1xh9e4hhwb.fsf@unicorn.mansr.com> <4546329.1O9421M58I@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:34417 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932103AbcEKNTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2016 09:19:10 -0400
In-Reply-To: <4546329.1O9421M58I@wuerfel> (Arnd Bergmann's message of "Wed, 11
	May 2016 15:13:22 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 11 May 2016 13:57:08 M=E5ns Rullg=E5rd wrote:
>> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> > index 41b0725e58ad..8f7a4a4d2566 100644
>> > --- a/drivers/ata/Kconfig
>> > +++ b/drivers/ata/Kconfig
>> > @@ -322,7 +322,7 @@ config SATA_DWC
>> >
>> >  config SATA_DWC_OLD_DMA
>> >       bool "Support old device trees"
>> > -     depends on SATA_DWC
>> > +     depends on SATA_DWC && DMADEVICES
>> >       select DW_DMAC_CORE
>> >       default y if 460EX
>> >       help
>> > --=20
>>=20
>> Isn't the proper fix here to have DW_DMAC_CORE select DMADEVICES?
>
> No, all dmaengine drivers depend on DMADEVICES, so that would
> cause a circular dependency.
>
> The normal behavior for DMA slave drivers is to use the generic
> DMA API and have a dependency on DMADEVICES but not on a particular
> DMA engine implementation. In this case, the driver uses an exported
> interface of the dw_dma driver directly, so we also need to select
> that one, but it doesn't mean we can skip the normal dependency.

OK, but then shouldn't the main SATA_DWC have this dependency since it
uses the DMA API?

--=20
M=E5ns Rullg=E5rd
