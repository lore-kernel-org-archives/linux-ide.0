From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 03 Feb 2016 17:23:18 +0100
Message-ID: <8562433.7oWe1ikqcL@wuerfel>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1725737.t6I7PsvPbL@wuerfel> <56B2247D.5040501@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:52138 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcBCQXq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2016 11:23:46 -0500
In-Reply-To: <56B2247D.5040501@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 03 February 2016 16:02:05 Zubair Lutfullah Kakakhel wrote:

> Hence, I find the original binding simpler and easier to understand when looking at the hardware manual
> 
> +       uctl@118006c000000 {
> +               compatible = "cavium,octeon-7130-sata-uctl";
> +               reg = <0x11800 0x6c000000 0x0 0x100>;
> +               ranges; /* Direct mapping */
> +               dma-ranges;
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +
> +               sata: sata@16c0000000000 {
> +                       compatible = "cavium,octeon-7130-ahci";
> +                       reg = <0x16c00 0x00000000 0x0 0x200>;
> +                       interrupt-parent = <&cibsata>;
> +                       interrupts = <2 4>; /* Bit: 2, level */
> +               };
> +       };
> 
> Is it possible to let this example go in as is?
> 

I don't have the hardware manual, so I'm just guessing what the hardware
looks like. If the manual describes the device as a bridge with a 1:1 mapping,
then your existing example above absolutely makes sense.

	Arnd
