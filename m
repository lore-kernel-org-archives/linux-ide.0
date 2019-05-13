From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 RESEND] drivers: ata: ahci_sunxi:
 Increased SATA/AHCI DMA TX/RX FIFOs
Date: Mon, 13 May 2019 13:20:17 +0200
Message-ID: <d8a776eb-0ecc-88b5-ab38-c47d8b15ec06@redhat.com>
References: <20190512205954.18435-1-um@mutluit.com>
 <413dcf9f-25a5-61f5-159f-a75e7b1f1522@redhat.com>
 <5CD94848.3090407@mutluit.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDRZXY4CYYORB6VF4XTAKGQEYGGTOZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5CD94848.3090407-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: "U.Mutlu" <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-amarula-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Pablo Greco <pgreco-/kQrlZ55X3WoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, FUKAUMI Naoki <naobsd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, Stefan Monnier <monnier-CRDzTM1onBSWkKpYnGOUKg@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi,

On 13-05-19 12:34, U.Mutlu wrote:
> Hans de Goede wrote on 05/13/2019 09:44 AM:
>> On 12-05-19 22:59, Uenal Mutlu wrote:
>>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
>>> TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
>>> to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
>>> from lame 36 MiB/s to 45 MiB/s previously.
>>> Read performance is about 200 MiB/s.
>>> [tested on SSD using dd bs=3D2K/4K/8K/12K/16K/24K/32K: peak-perf at 12K=
].
>>>
>>> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
>>> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
>>> These devices are RaspberryPi-like small devices.
>>>
>>> This problem of slow SATA write-speed with these small devices lasts no=
w
>>> for more than 5 years. Many commentators throughout the years wrongly
>>> assumed the slow write speed was a hardware limitation. This patch fina=
lly
>>> solves the problem, which in fact was just a hard-to-fix software probl=
em
>>> (b/c of lack of documentation by the SoC-maker Allwinner Technology).
>>>
>>> RFC: Since more than about 25 similar SBC/SoC models do use the
>>> ahci_sunxi driver, users are encouraged to test it on all the
>>> affected boards and give feedback
>>
>> The SATA controller on these boards is inside the A10/A20 SoC, the
>> A10 and A20 use the same controller, so it is the same on all the boards=
.
>=20
> Ok, thanks for the clarification.
> This fact of course simplifies the whole issue.
>=20
>> IOW I don't see this only being tested on 1 board as a reason for the pa=
tch
>> to be RFC.
>=20
> I just wanted to be on the safe side :-) since I personally
> have only 2 of the 25+ affected systems here for testing.
> But I now understand that if it works on the tested two
> A20 systems, then it normally should work on all of the
> affected different boards/models as they all are using
> the same SATA/AHCI-IP-Core, much like you also stated.
>=20
> But of course I still wouldn't like it if someone loses data
> and possibly blames my patch or even me myself, as the issue
> is indeed a sensitive one where data loss (corruption of the
> filesystem, partition, or the partition table) can indeed happen.
> To be honest, it happened to me during my experiments with
> some wrong, too high, values.
> But I think the current version is mature and stable.
>=20
>>> Lists of the affected sunxi and other boards and SoCs with SATA using
>>> the ahci_sunxi driver:
>>> =C2=A0=C2=A0 $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>>> =C2=A0=C2=A0 and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
>>> =C2=A0=C2=A0 See also http://linux-sunxi.org/Category:Devices_with_SATA=
_port
>>>
>>> Patch v2:
>>> =C2=A0=C2=A0 - Commented the patch in-place in ahci_sunxi.c
>>> =C2=A0=C2=A0 - With bs=3D12K and no conv=3D... passed to dd, the write =
performance
>>> =C2=A0=C2=A0=C2=A0=C2=A0 rises further to 132 MiB/s
>>> =C2=A0=C2=A0 - Changed MB/s to MiB/s
>>> =C2=A0=C2=A0 - Posted the story behind the patch:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 http://lkml.iu.edu/hypermail/linux/kernel/1905=
.1/03506.html
>>> =C2=A0=C2=A0 - Posted a dd test script to find optimal bs, and some res=
ults:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 https://bit.ly/2YoOzEM
>>>
>>> Patch v1:
>>> =C2=A0=C2=A0 - States bs=3D4K for dd and a write performance of 120 MiB=
/s
>>>
>>> Signed-off-by: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
>>> ---
>>> =C2=A0 drivers/ata/ahci_sunxi.c | 47 ++++++++++++++++++++++++++++++++++=
+++++++++++--
>>> =C2=A0 1 file changed, 45 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
>>> index 911710643305..ed19f19808c5 100644
>>> --- a/drivers/ata/ahci_sunxi.c
>>> +++ b/drivers/ata/ahci_sunxi.c
>>> @@ -157,8 +157,51 @@ static void ahci_sunxi_start_engine(struct ata_por=
t *ap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *port_mmio =3D ahci_port_ba=
se(ap);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ahci_host_priv *hpriv =3D ap->hos=
t->private_data;
>>> -=C2=A0=C2=A0=C2=A0 /* Setup DMA before DMA start */
>>> -=C2=A0=C2=A0=C2=A0 sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000=
ff00, 0x00004400);
>>> +=C2=A0=C2=A0=C2=A0 /* Setup DMA before DMA start
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * NOTE: A similar SoC with SATA/AHCI by Texas=
 Instruments documents
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 this Vendor Specific Port (P0DM=
ACR, aka PxDMACR) in its
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 User's Guide document (TMS320C6=
74x/OMAP-L1x Processor
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Serial ATA (SATA) Controller, L=
iterature Number: SPRUGJ8C,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 March 2011, Chapter 4.33 Port D=
MA Control Register (P0DMACR),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 p.68, https://www.ti.com/lit/ug=
/sprugj8c/sprugj8c.pdf)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 as equivalent to the following =
struct:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 struct AHCI_P0DMACR_t
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigne=
d TXTS=C2=A0=C2=A0=C2=A0=C2=A0 : 4,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RXTS=C2=A0=C2=A0=C2=A0=C2=
=A0 : 4,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TXABL=C2=A0=C2=A0=C2=A0 : =
4,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RXABL=C2=A0=C2=A0=C2=A0 : =
4,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reserved : 16;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 TXTS: Transmit Transaction Size=
 (TX_TRANSACTION_SIZE).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 This field defines =
the DMA transaction size in DWORDs for
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 transmit (system bu=
s read, device write) operation. [...]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 RXTS: Receive Transaction Size =
(RX_TRANSACTION_SIZE).
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 This field defines =
the Port DMA transaction size in DWORDs
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 for receive (system=
 bus write, device read) operation. [...]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 TXABL: Transmit Burst Limit.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 This field allows s=
oftware to limit the VBUSP master read
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 burst size. [...]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 RXABL: Receive Burst Limit.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 Allows software to =
limit the VBUSP master write burst
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 size. [...]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Reserved: Reserved.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * NOTE: According to the above document, the =
following alternative
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 to the code below could perhaps=
 be a better option
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 (or preparation) for possible f=
urther improvements later:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 sunxi_clrsetbits(hp=
riv->mmio + AHCI_P0DMACR, 0x0000ffff,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
x00000033);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000=
ffff, 0x00004433);
>>
>> Have you tried / benchmarked the 0x00000033 option?
>=20
> Yes, I did, but not that extensively yet. So far I couldn't see any
> difference in the outcome.
> There is in the TI doc just the following statement regarding this:
>=20
> "Note that programming a burst size of greater than a transaction size,
> while not invalid, is meaningless because the DMA maximizes out at
> transaction size." (Ch. 3.4 DMA, p.15 in the TI doc).
>=20
> I understand this as a neutral statement, ie. it doesn't hurt or make
> any difference in practice if one sets TXABL effectively higher than
> TXTS and/or RXABL effectively higher than RXTS,
> FYI: these value are just some index-values, ie. index-value x means real=
 value y.
> 0 for TXABL and/or RXABL means "Limit VBUSP burst size to 256 DWORDS",
> ie. to the highest possible value for Transmit Burst Limit (TXABL) and
> Receive Burst Limit (RXABL), respectively.
>=20
> I'll test this alternative version now extensively in my test series.

If you're not seeing much difference in performance and all your
current testing has been done with 0x00004433, then it is fine to just
stick with that version, the original 0x00004400 values comes from
Allwinner's own SDK, presumably they had a reason for this.

> But I could need an advice on what step I should take next in this
> issue regarding getting the patch merged into the mainline kernel.
> Shall I post a v3 of the patch with RFC removed, some more comments
> added, and switching to the above alternative function argument
> together with its test results, or shall I do these additions only
> after the current version has already been merged into the kernel?
> [actually I'm now unsure if patches with "RFC" flag ever get merged :-].

The next step would be sending a non RFC version, with Maxime's Acked-by
added above your Signed-off-by, you may also add my:

Reviewed-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, above your S-o-b
line.

Regards,

Hans

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/d8a776eb-0ecc-88b5-ab38-c47d8b15ec06%40redhat.com.
For more options, visit https://groups.google.com/d/optout.
