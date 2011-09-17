From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Sat, 17 Sep 2011 20:35:57 +0200
Message-ID: <2922376.ufKFh1svrE@wuerfel>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org> <20110916214313.GB16381@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58690 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab1IQSgp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2011 14:36:45 -0400
In-Reply-To: <20110916214313.GB16381@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, patches@linaro.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org

On Friday 16 September 2011 22:43:13 Russell King - ARM Linux wrote:
> On Fri, Sep 16, 2011 at 03:38:10PM +0100, Dave Martin wrote:
> > This patch enables device-tree-based probing of the pata-generic
> > platform driver across all architectures:
> > 
> >   * make the pata_of_generic module depend on OF instead of PPC_OF;
> >   * supply some missing inclues;
> >   * replace endianness-sensitive raw access to device tree data
> >     with of_property_read_u32() calls.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> > 
> > Tested on ARM Versatile Express, with my soon-to-be-posted device
> > tree support patches.
> 
> This may not be the correct way to support the CF slot on Versatile
> Express - it depends whether the CF slot on VE supports just CF
> memory cards or whether it can take any CF card.
> 
> If the latter, then what may be inserted could be a CF network card,
> and that means it's probably wrong to tell the kernel that what's
> there is a PATA interface.

The documentation at
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447e/CACECHFJ.html
claims that the slot only supports TrueIDE and PIO/Taskfile mode, which
are the two modes for CF memory cards. Of course this is highly dependent
on what you load into the FPGA that implements the CF interface on
the versatile express, but at least for the currect Versatile Express
FPGA load it should be right.

Also, the patch makes sense regardless of versatile express, it's just
basic cleanup.

One extension we might want to add eventually is support for the UDMA
modes that are present on most of the current CF cards but not supported
by this driver (AFAICT).

	Arnd
