From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: ata: add DT bindings for MediaTek
 SATA controller
Date: Fri, 11 Aug 2017 11:57:36 +0800
Message-ID: <1502423856.32524.17.camel@mtkswgap22>
References: <cover.1502098458.git.ryder.lee@mediatek.com>
         <a7ceb4ed8cc3542169ae8d2d995bdd4707f504e1.1502098458.git.ryder.lee@mediatek.com>
         <20170810205149.lkphpv7krhdaa23y@rob-hp-laptop>
         <1502418356.18608.10.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:60568 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751691AbdHKD54 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2017 23:57:56 -0400
In-Reply-To: <1502418356.18608.10.camel@mtkswgap22>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>

Hi Rob,

Sorry for the noise letter.

On Fri, 2017-08-11 at 10:25 +0800, Ryder Lee wrote:
> > > +Required properties:
> > > + - compatible	   : Must be "mediatek,ahci".
> > 
> > SoC specific compatible strings please.
> 
> Okay.

I took a look at ./ahci-platform.txt. Could we just add a generic
compatible string as below:

compatible: Must be "mediatek,soc-model-ahci", "mediatek,mtk-ahci"

In doing so, we can avoid having an endless list of compatibles for
those MTK SoCs with the same IP block.

> > > +
> > > +Optional properties:
> > > + - power-domains   : A phandle and power domain specifier pair to the power
> > > +		     domain which is responsible for collapsing and restoring
> > > +		     power to the peripheral.
> > > + - resets	   : Must contain an entry for each entry in reset-names.
> > > +		     See ../reset/reset.txt for details.
> > > + - reset-names	   : Associated names must be: "axi", "sw", "reg".
> > > + - mediatek,phy-mode : A phandle to the system controller, used to enable
> > > +		       SATA function.
> > > +
> > > +Example:
> > > +
> > > +	sata: sata@1a200000 {
> > > +		compatible = "mediatek,ahci";

MT7622 should be:
               compatible = "mediatek,mt7622-ahci",
                            "mediatek,mtk-ahci";


Ryder


