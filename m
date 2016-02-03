From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 03 Feb 2016 16:31:23 +0100
Message-ID: <1725737.t6I7PsvPbL@wuerfel>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com> <2782231.XGO9cUTm7n@wuerfel> <56B21250.5050807@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53835 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbcBCPbn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2016 10:31:43 -0500
In-Reply-To: <56B21250.5050807@imgtec.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 03 February 2016 14:44:32 Zubair Lutfullah Kakakhel wrote:
> 
> Possible in the example.
> 
> I'll update the example to
> 
>         uctl@118006c000000 {
>                 compatible = "cavium,octeon-7130-sata-uctl";
>                 reg = <0x11800 0x6c000000 0x0 0x100>;
>                 ranges; /* Direct mapping */
>                 dma-ranges;
>                 #address-cells = <1>;
>                 #size-cells = <2>;
> 
>                 sata: sata@0 {
>                         compatible = "cavium,octeon-7130-ahci";
>                         reg = <0x16c00 0x00000000 0x0 0x200>;
>                         interrupt-parent = <&cibsata>;
>                         interrupts = <2 4>; /* Bit: 2, level */
>                 };
>         };

Sorry, I should have been clearer. What I meant is


         uctl@118006c000000 {
                compatible = "cavium,octeon-7130-sata-uctl";
                reg = <0x11800 0x6c000000 0x0 0x100>;
                ranges = <0   0x16c00 0x00000000   0xffffffff>;
                dma-ranges;
                #address-cells = <1>;
                #size-cells = <1>;

                sata: sata@0 {
                        compatible = "cavium,octeon-7130-ahci";
                        reg = <0x00000000 0x200>;
                        interrupt-parent = <&cibsata>;
                        interrupts = <2 4>; /* Bit: 2, level */
                };
        };


However, I realized that this would break the dma-ranges, if the
child device is indeed 64-bit DMA capable. When #address-cells and/or
#size-cells don't match between parent and child, you have to provide
non-empty ranges as well as dma-ranges, and the dma-ranges for
#address-cells=<1> would imply only supporting 32-bit DMA.


It could still be

         uctl@118006c000000 {
                compatible = "cavium,octeon-7130-sata-uctl";
                reg = <0x11800 0x6c000000 0x0 0x100>;
                ranges = <0 0  0x16c00 0x00000000   1 0>;
                dma-ranges;
                #address-cells = <1>;
                #size-cells = <1>;

                sata: sata@0 {
                        compatible = "cavium,octeon-7130-ahci";
                        reg = <0 0  0x200>;
                        interrupt-parent = <&cibsata>;
                        interrupts = <2 4>; /* Bit: 2, level */
                };
        };

to have a ranges property that shows we are only translating one 4GB
segment of MMIO addresses into the child, but that the child has DMA
access to the entire CPU address space (including 64-bit wide RAM
as well as all MMIO).

	Arnd
