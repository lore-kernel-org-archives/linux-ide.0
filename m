From: "U.Mutlu" <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
Date: Sun, 12 May 2019 18:08:19 +0200
Message-ID: <5CD844F3.5080103@mutluit.com>
References: <20190510192550.17458-1-um@mutluit.com>
 <20190512121245.l3cvg4std6yanwix@flea>
Reply-To: um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Return-path: <linux-sunxi+bncBDJNR5GB6YGRB5UJ4HTAKGQEOY3ZIIQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190512121245.l3cvg4std6yanwix@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, u-boot-0aAXYlwwYIKGBzrmiIFOJg@public.gmane.org, linux-amarula-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Pablo Greco <pgreco-/kQrlZ55X3WoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, FUKAUMI Naoki <naobsd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Maxime & Others,

what follows is a somewhat lengthy technical story behind this patch;
you can just skip it and jump to the end.


As can be seen in the ahci_sunxi.c, the port used in this patch
is this one (32bit):
   #define AHCI_P0DMACR    0x0170
It's a so called "Vendor Specific Port" according to the SATA/AHCI specs by Intel.
The data behind it is actually a struct, consisting of 4 fields,
each 4bits long, plus a 16bits long field that is marked as Reserved
in secondary literature (see below):

struct AHCI_P0DMACR_t
{
   unsigned TXTS  : 4,
            RXTS  : 4,
            TXABL : 4,
            RXABL : 4,
            Res1  : 16;
};

This struct is just my creation for my own tests as it's not part of the
driver source. The patch touches only the first 2 fields: TXTS and RXTS.

See this similar product documentation by Texas Instruments for the above struct:
https://www.ti.com/lit/ug/sprugj8c/sprugj8c.pdf
TMS320C674x/OMAP-L1x Processor, Serial ATA (SATA) Controller, User's Guide,
Literature Number: SPRUGJ8C, March 2011,
Page 68, Chapter 4.33 "Port DMA Control Register (P0DMACR)"

The above TI document describes the two fields as follows:

TXTS:
   Transmit Transaction Size (TX_TRANSACTION_SIZE). This field defines the DMA 
transaction size in
   DWORDs for transmit (system bus read, device write) operation. [...]

RXTS:
   Receive Transaction Size (RX_TRANSACTION_SIZE). This field defines the Port 
DMA transaction size
   in DWORDs for receive (system bus write, device read) operation. [...]


So, in my patch the fields TXTS and RXTS are set to 3 each.
Without the patch, these fields seem to have some random content
(I'vee seen 5 and 6, 4 and 4, and 0 and 0 on different devices),
as the previous code doesn't touch these 2 fields (ie. these two fields
are not within the used old mask of 0xff00; cf. ahci_sunxi.c, function 
ahci_sunxi_start_engine(...)).


Some background story in my hunt for obtaining product documentation:

I couldn't find any product documentation for the SATA/AHCI
in these SoCs by Allwinner Technology (allwinnertech.com),
unlike with such products from other such companies.

I asked Allwinner, but they just said that the A20 of my SBC
would (allegedly) no more be actual and that the support for it
has ended (but this statement somehow cannot be true as the
A20 SoC is still continued being marketed at their website).
They instead sent me a bunch of really irrelevant PDFs which have
nothing to do with SATA/AHCI.

So, the company Allwinner Technology unfortunately was not cooperative
to provide me information on their SATA/AHCI-implementation in their SoCs :-(
Even the ports used in the actual ahci_sunxi.c in the linux tree are undocumented;
it is even commented with "/* This magic is from the original code */"
and below it many ports are used for which no documentation is available,
or at least I couldn't find any on the Internet. And the initial programmer
in 2014 and prior was Daniel Wang (danielwang-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org),
but email to that address bounces.

So, I was forced to research secondary literature from other vendors
like Texas Instruments (thanks TI !) and Intel, and also studying
very old source codes in the old Linux repositories (as it differs
much from the current version) going back to the year 2014, and had
to do many (blind) experiments until I found this solution.

The above given User's Guide by Texas Instruments (and their such
documents for their newer such products) helped me much to find the solution.
It's of course not really the correct documentation for the Allwinner SoCs,
but still better than nothing.

If I only had the right documentation, then I for sure could try
to further improve that already achieved result by this patch,
as with SATA-II upto 300 MiB/s is possible.


Yes, I'll resend the patch with some appropriate comments.

Uenal Mutlu



Maxime Ripard wrote on 05/12/2019 02:12 PM:
> Hi,
>
> On Fri, May 10, 2019 at 09:25:50PM +0200, Uenal Mutlu wrote:
>> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS) from
>> default 0x0 each to 0x3 each gives a write performance boost of 120MB/s
>> from lame 36MB/s to 45MB/s previously. Read performance is about 200MB/s
>> [tested on SSD using dd bs=4K count=512K].
>>
>> Tested on the Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 SBCs
>> with Allwinner A20 32bit-SoCs (ARMv7-a / arm-linux-gnueabihf).
>> These devices are RaspberryPi-like small devices.
>>
>> RFC: Since more than about 25 similar SBC/SoC models do use the
>> ahci_sunxi driver, users are encouraged to test it on all the
>> affected boards and give feedback.
>>
>> List of the affected sunxi and other boards and SoCs with SATA using
>> the ahci_sunxi driver:
>>    $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>>    and http://linux-sunxi.org/Category:Devices_with_SATA_port
>>
>> Signed-off-by: Uenal Mutlu <um-lNbj7F0cCK5BDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/ata/ahci_sunxi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
>> index 911710643305..257986431c79 100644
>> --- a/drivers/ata/ahci_sunxi.c
>> +++ b/drivers/ata/ahci_sunxi.c
>> @@ -158,7 +158,7 @@ static void ahci_sunxi_start_engine(struct ata_port *ap)
>>   	struct ahci_host_priv *hpriv = ap->host->private_data;
>>
>>   	/* Setup DMA before DMA start */
>> -	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ff00, 0x00004400);
>> +	sunxi_clrsetbits(hpriv->mmio + AHCI_P0DMACR, 0x0000ffff, 0x00004433);
>
> Having comments / defines here would be great, once fixed:
> Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
