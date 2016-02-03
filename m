From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 3 Feb 2016 16:02:05 +0000
Message-ID: <56B2247D.5040501@imgtec.com>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <2782231.XGO9cUTm7n@wuerfel> <56B21250.5050807@imgtec.com>
 <1725737.t6I7PsvPbL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1725737.t6I7PsvPbL@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 03/02/16 15:31, Arnd Bergmann wrote:
> On Wednesday 03 February 2016 14:44:32 Zubair Lutfullah Kakakhel wrot=
e:
>>
>> Possible in the example.
>>
>> I'll update the example to
>>
>>          uctl@118006c000000 {
>>                  compatible =3D "cavium,octeon-7130-sata-uctl";
>>                  reg =3D <0x11800 0x6c000000 0x0 0x100>;
>>                  ranges; /* Direct mapping */
>>                  dma-ranges;
>>                  #address-cells =3D <1>;
>>                  #size-cells =3D <2>;
>>
>>                  sata: sata@0 {
>>                          compatible =3D "cavium,octeon-7130-ahci";
>>                          reg =3D <0x16c00 0x00000000 0x0 0x200>;
>>                          interrupt-parent =3D <&cibsata>;
>>                          interrupts =3D <2 4>; /* Bit: 2, level */
>>                  };
>>          };
>
> Sorry, I should have been clearer. What I meant is
>
>
>           uctl@118006c000000 {
>                  compatible =3D "cavium,octeon-7130-sata-uctl";
>                  reg =3D <0x11800 0x6c000000 0x0 0x100>;
>                  ranges =3D <0   0x16c00 0x00000000   0xffffffff>;
>                  dma-ranges;
>                  #address-cells =3D <1>;
>                  #size-cells =3D <1>;
>
>                  sata: sata@0 {
>                          compatible =3D "cavium,octeon-7130-ahci";
>                          reg =3D <0x00000000 0x200>;
>                          interrupt-parent =3D <&cibsata>;
>                          interrupts =3D <2 4>; /* Bit: 2, level */
>                  };
>          };
>
>
> However, I realized that this would break the dma-ranges, if the
> child device is indeed 64-bit DMA capable. When #address-cells and/or
> #size-cells don't match between parent and child, you have to provide
> non-empty ranges as well as dma-ranges, and the dma-ranges for
> #address-cells=3D<1> would imply only supporting 32-bit DMA.
>
>
> It could still be
>
>           uctl@118006c000000 {
>                  compatible =3D "cavium,octeon-7130-sata-uctl";
>                  reg =3D <0x11800 0x6c000000 0x0 0x100>;
>                  ranges =3D <0 0  0x16c00 0x00000000   1 0>;
>                  dma-ranges;
>                  #address-cells =3D <1>;
>                  #size-cells =3D <1>;
>
>                  sata: sata@0 {
>                          compatible =3D "cavium,octeon-7130-ahci";
>                          reg =3D <0 0  0x200>;
>                          interrupt-parent =3D <&cibsata>;
>                          interrupts =3D <2 4>; /* Bit: 2, level */
>                  };
>          };
>
> to have a ranges property that shows we are only translating one 4GB
> segment of MMIO addresses into the child, but that the child has DMA
> access to the entire CPU address space (including 64-bit wide RAM
> as well as all MMIO).
>

The above might seem simple to the learned eye.

But it really convolutes my head.

The original binding from Cavium indicates direct mapping.

Given the restricted child device register range, your restricted range=
s might make sense.

But I can't make sense of the mappings in the manual I have.

Perhaps David Daney can give more insight on what the hardware implemen=
ts.

=C2=AF\_(=E3=83=84)_/=C2=AF
    |__|
    /  \

Keep in mind. this sata-uctl might seem like a bus driver

But it is only sitting in front of a sata ahci block.

There is little need for over-engineering address ranges.

Hence, I find the original binding simpler and easier to understand whe=
n looking at the hardware manual

+	uctl@118006c000000 {
+		compatible =3D "cavium,octeon-7130-sata-uctl";
+		reg =3D <0x11800 0x6c000000 0x0 0x100>;
+		ranges; /* Direct mapping */
+		dma-ranges;
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+
+		sata: sata@16c0000000000 {
+			compatible =3D "cavium,octeon-7130-ahci";
+			reg =3D <0x16c00 0x00000000 0x0 0x200>;
+			interrupt-parent =3D <&cibsata>;
+			interrupts =3D <2 4>; /* Bit: 2, level */
+		};
+	};

Is it possible to let this example go in as is?

Regards,
ZubairLK

> 	Arnd
>
