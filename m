From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 01/14] devicetree: bindings: add bindings for
 ahci-da850
Date: Mon, 23 Jan 2017 09:49:31 -0600
Message-ID: <20170123154931.zyrcg5grqvia435t@rob-hp-laptop>
References: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
 <1484911325-23425-2-git-send-email-bgolaszewski@baylibre.com>
 <5615fb6b-af26-c2fb-1f97-416548a9faaf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35035 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdAWPtd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2017 10:49:33 -0500
Content-Disposition: inline
In-Reply-To: <5615fb6b-af26-c2fb-1f97-416548a9faaf@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 20, 2017 at 07:02:08PM +0530, Sekhar Nori wrote:
> Hi Rob,
> 
> On Friday 20 January 2017 04:51 PM, Bartosz Golaszewski wrote:
> > Add DT bindings for the TI DA850 AHCI SATA controller.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Could you ack this binding?

First I'm seeing it that I recall and v5? That either means the DT list 
wasn't copied or new versions are being sent out faster than can be 
reviewed. Sending new versions puts you at the back of the queue.

> 
> Thanks,
> Sekhar
> 
> > ---
> >  Documentation/devicetree/bindings/ata/ahci-da850.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> > new file mode 100644
> > index 0000000..268fe87
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
> > @@ -0,0 +1,15 @@
> > +Device tree binding for the TI DA850 AHCI SATA Controller
> > +---------------------------------------------------------
> > +
> > +Required properties:
> > +  - compatible: must be "ti,da850-ahci"
> > +  - reg: physical base addresses and sizes of the controller's register areas

Need to state how many and what the regions are.

> > +  - interrupts: interrupt specifier (refer to the interrupt binding)
> > +
> > +Example:
> > +
> > +	sata: sata@218000 {
> > +		compatible = "ti,da850-ahci";
> > +		reg = <0x218000 0x2000>, <0x22c018 0x4>;
> > +		interrupts = <67>;
> > +	};
> > 
> 
