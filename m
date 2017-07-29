From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: ata: add DT bindings for MediaTek SATA
 controller
Date: Sat, 29 Jul 2017 11:41:11 +0800
Message-ID: <1501299671.12447.4.camel@mtkswgap22>
References: <cover.1501134896.git.ryder.lee@mediatek.com>
         <45c7b2abc65b0d7b5b945763837811296e56835f.1501134896.git.ryder.lee@mediatek.com>
         <7adf5e2c-4678-3e91-1036-f5e82d23329f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:36471 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753112AbdG2Dl1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jul 2017 23:41:27 -0400
In-Reply-To: <7adf5e2c-4678-3e91-1036-f5e82d23329f@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

On Fri, 2017-07-28 at 12:20 +0300, Sergei Shtylyov wrote:
> > +Required properties:
> > + - compatible	   : Must be "mediatek,ahci".
> > + - reg		   : Physical base addresses and length of register sets.
> > + - interrupts	   : Interrupt associated with the SATA device.
> > + - interrupt-names : Associated name must be: "hostc".
> > + - clocks	   : The phandle for the clock.
> 
>     Your example shows that you need both phandle and specifier (afetr phandle).
> 
> > + - clock-names	   : Associated name must be: "ahb", "axi", "asic", "rbc", "pm"
> > + - phys		   : The phandle for the PHY port.
> 
>      Likewise.

Oh yeah, I forgot about that.

> > + - phy-names	   : Associated name must be: "sata-phy".
> > + - ports-implemented : Mask that indicates which ports that the HBA supports
> > +		       are available for software to use. Useful if PORTS_IMPL
> > +		       is not programmed by the BIOS, which is true with some
> > +		       embedded SOC's.
> 
>     An empty line wouldn't hurt here...

Okay.

> > +Optional properties:
> > + - power-domains   : A phandle and power domain specifier pair to the power
> > +		     domain which is responsible for collapsing and restoring
> > +		     power to the peripheral.
> > + - resets	   : Must contain an entry for each entry in reset-names.
> > +		     See ../reset/reset.txt for details.
> > + - reset-names	   : Associated names must be: "axi-rst", "sw-rst", "reg-rst".
> > + - mediatek,phy-mode : A phandle to the system controller, used to enable
> > +		       SATA function.

Thanks!
Ryder.

