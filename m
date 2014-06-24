From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 0/8] iMX6 SATA configuration
Date: Tue, 24 Jun 2014 07:45:03 -0500
Message-ID: <CAL_JsqLvcRmOfjhuoyND_n7DGSNWPDCJT8iDQs-SfJrYjZj5zQ@mail.gmail.com>
References: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178]:55790 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaFXMpY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jun 2014 08:45:24 -0400
In-Reply-To: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>

On Tue, Jun 24, 2014 at 5:19 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Another round of these patches.  I've integrated Shawn's patch to split
> the documentation into this series so I can add the DT documentation
> on top of it.
>
>  .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
>  Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
>  arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
>  drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
>  4 files changed, 216 insertions(+), 14 deletions(-)

For patches 1, 4, and 6:

Acked-by: Rob Herring <robh@kernel.org>

Rob
