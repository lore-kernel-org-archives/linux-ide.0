From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [PATCH 1/3] RFC: AHCI: libahci is missing DMA
Date: Wed, 04 Dec 2013 13:36:06 +0100
Message-ID: <529F21B6.1020909@schinagl.nl>
References: <1386159055-10264-1-git-send-email-oliver@schinagl.nl> <1386159055-10264-2-git-send-email-oliver@schinagl.nl> <20131204123234.GC3158@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBDWE7SKAKGQEXRXXW7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131204123234.GC3158-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hey Tejun Heo,

On 04-12-13 13:32, Tejun Heo wrote:
> On Wed, Dec 04, 2013 at 01:10:53PM +0100, oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org wrote:
>> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>>
>> The Allwinner sunxi platforms have patched in the following to enable
>> DMA. This patch enables DMA controllers for the SUNXI Architecture.
>>
>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>> ---
>>   drivers/ata/ahci.h    | 6 ++++++
>>   drivers/ata/libahci.c | 8 ++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>> index 2289efdf..2bf2423 100644
>> --- a/drivers/ata/ahci.h
>> +++ b/drivers/ata/ahci.h
>> @@ -138,6 +138,7 @@ enum {
>>   	PORT_SCR_NTF		= 0x3c, /* SATA phy register: SNotification */
>>   	PORT_FBS		= 0x40, /* FIS-based Switching */
>>   	PORT_DEVSLP		= 0x44, /* device sleep */
>> +	PORT_DMA		= 0x70, /* direct memory access */
>>   
>>   	/* PORT_IRQ_{STAT,MASK} bits */
>>   	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
>> @@ -209,6 +210,11 @@ enum {
>>   	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
>>   	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
>>   
>> +	/* PORT_DMA bits */
>> +	PORT_DMA_SETUP_OFFSET	= 8, /* dma setup offset */
>> +	PORT_DMA_SETUP_MASK	= (0xff << PORT_DMA_SETUP_OFFSET),/* dma mask */
>> +	PORT_DMA_SETUP_INIT	= (0x44 << 0),
> Ummm... this doesn't belong to ahci proper, right?
I have no idea why Allwinner added that and what it really does. We have 
no documentation, only code drops.

I had high hopes someone around here knows what it could mean and where 
it does belong.
>
>> +
>>   	/* hpriv->flags bits */
>>   
>>   #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
>> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> index c482f8c..d697a74 100644
>> --- a/drivers/ata/libahci.c
>> +++ b/drivers/ata/libahci.c
>> @@ -570,6 +570,14 @@ void ahci_start_engine(struct ata_port *ap)
>>   	void __iomem *port_mmio = ahci_port_base(ap);
>>   	u32 tmp;
>>   
>> +#ifdef CONFIG_ARCH_SUNXI
>> +	/* Setup DMA before DMA start */
>> +	tmp = readl(port_mmio + PORT_DMA);
>> +	tmp &= ~PORT_DMA_SETUP_MASK;
>> +	tmp |= PORT_DMA_SETUP_INIT << PORT_DMA_SETUP_OFFSET;
>> +	writel(tmp, port_mmio + PORT_DMA);
>> +#endif
> If this is something platform device specific, wouldn't overriding
> ->port_start() which wraps around ahci_port_start() make more sense?
Again, I don't know, this is where Allwinner had put it. We don't even 
know who's IP they use. I'm happy to start experimenting moving this 
around a bit and will take your clue to figure out what you mean and if 
it could work.

Oliver
>
> Thanks.
>
