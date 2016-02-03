From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 03 Feb 2016 14:47:03 +0100
Message-ID: <2782231.XGO9cUTm7n@wuerfel>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1930324.vU65IL0x0g@wuerfel> <56B1FF7A.3040906@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B1FF7A.3040906@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 03 February 2016 13:24:10 Zubair Lutfullah Kakakhel wrote:
> > Typically we treat those special registers as part of the device itself
> > and have a single device node for the AHCI controller and that one.
> >
> > What is your reason for doing it differently here?
> 
> Two reasons
> 
> 1- The hardware is like a proper split rather than additional hidden registers in
> the same memory space.
> 
> 2- Tons of devices in the field have the following DT node built in the bootloader.
> 
>                 uctl@118006c000000 {
>                         compatible = "cavium,octeon-7130-sata-uctl";
>                         reg = <0x11800 0x6c000000 0x0 0x100>;
>                         ...
>                          sata: sata@16c0000000000 {
>                                  compatible = "cavium,octeon-7130-ahci";
>                                  reg = <0x16c00 0x00000000 0x0 0x200>;
>                                 ...
>                          };
>                 };
> 
> The patch suggests a way to handle this.
> 

Ok, fair enough. Also, you write in the binding that this is a bus
bridge, so this indeed matches what the hardware does, and that's ok.

Does the bus bridge actually translate the entire 64-bit CPU MMIO space,
or is it possible that it only handles one device (or a couple of
them) with a fairly limited space?

Maybe it's better to represent it as a #address-cells=<1> in the
example, and have the child device appear at address 0 in there.

For the machines that already ship a DT, that would not matter though,
it works either way.

	Arnd
