Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3D394793;
	Tue, 30 Jun 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807722; cv=none; b=EAr3GnAgak58xUqCMvRYECl7mf3tkoT52RXiLmHRk00X9vvIkhvHFf01HHr2TT4oZ3zM+LBM3Jba/868pdaHlnJelCmfdGYyqQMxNXXgn10yBfsaUGE8oHRUYYlvThmd+kkvDTSEAtESCpLb6gjlf0khKDXKpUFxxIc5Hd7wfv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807722; c=relaxed/simple;
	bh=it0ac2cvkqDayEMQtsm9Rt8jrHwQqb272BgD4UMAI9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJnSihjMTBt72R6QlR2wb8LFlPBFANaEHbvXRQaj3GBn8C+W92PZTDQ76dYhrl6DPKm/ACftAeD4yyVxq6grkCEt7QTM2WH4tzOXKmfoj5XkeKlYNQybBDA/8Ql2/KaypRpd6a1lxObTE6kf2pN8v8Cq3GBTKTeeNWyafa8v7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbU+KD80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbU+KD80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AE81F000E9;
	Tue, 30 Jun 2026 08:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782807720;
	bh=Eu/U6b2HH/1X2lOE56J9kNKL0N4+YbaaMpT200k29Sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QbU+KD80uRw4f/bd22jBVLOS7Ev4sF8aaMNNmq8yJKFF8J2EjiaBUlW1dLCibC+f7
	 Xm8ULExt+I0nW09vIfgmtPArXrmLDX913Gw7N6qFnHRZUQgq2qLv6Gok0cRWiQq74t
	 DGa6kTX9AyqMl4dgM2evS2gI5EXVXqz9HsI4R/L+E/Hq/dczJwwSL/Om/tA/2wlG5i
	 dk0Hjt2Lp6tFOvRphs5LI1S3Nv+A0Ayi8zZRDFi/NKKF/4j0OsEq9cS4uzbQSgIgiz
	 iGd7O8ev+JsT5xHokEa3uL/tNzgMDYgT+DL7Fs9z9aihXvw/1WgcLN5upln1v18kFz
	 qpSJYBqcd041w==
Message-ID: <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
Date: Tue, 30 Jun 2026 17:21:58 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>, Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <akNzEGgiYC5V3rtc@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 16:41, Niklas Cassel wrote:
> On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
>> Replace irq_of_parse_and_map() with platform_get_irq() in both
>> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
>> way to obtain IRQs for platform devices and provides better error
>> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
>>
>> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missing.
>>
>> Assisted-by: opencode:big-pickle
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  drivers/ata/sata_dwc_460ex.c | 18 ++++++------------
>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
>> index 4fc22ce4bd9a..35aa7f9acdf7 100644
>> --- a/drivers/ata/sata_dwc_460ex.c
>> +++ b/drivers/ata/sata_dwc_460ex.c
>> @@ -19,7 +19,6 @@
>>  #include <linux/device.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/of.h>
>> -#include <linux/of_irq.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/libata.h>
>> @@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>>  				 struct sata_dwc_device *hsdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> -	struct device_node *np = dev->of_node;
> 
> While this patch drops 'struct device_node *np = dev->of_node;' from
> sata_dwc_dma_init_old() ...
> 
>>  
>>  	hsdev->dma = devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
>>  	if (!hsdev->dma)
>> @@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>>  	hsdev->dma->id = pdev->id;
>>  
>>  	/* Get SATA DMA interrupt number */
>> -	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
>> -	if (!hsdev->dma->irq) {
>> -		dev_err(dev, "no SATA DMA irq\n");
>> -		return -ENODEV;
>> -	}
>> +	hsdev->dma->irq = platform_get_irq(pdev, 1);
>> +	if (hsdev->dma->irq < 0)
>> +		return hsdev->dma->irq;
>>  
>>  	/* Get physical SATA DMA register base address */
>>  	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
>> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
> 
> it seems like you forgot to do the same for sata_dwc_probe().
> 
> Which results in a new warning:
> https://lore.kernel.org/oe-kbuild-all/202606301243.9MrXM4WY-lkp@intel.com/T/#u
> 
> Damien, perhaps drop this patch and wait for a v2,
> or fixup the patch to remove 'struct device_node *np = dev->of_node;'
> also from sata_dwc_probe().
> 
> 
>>  	sata_dwc_enable_interrupts(hsdev);
>>  
>>  	/* Get SATA interrupt number */
>> -	irq = irq_of_parse_and_map(np, 0);
>> -	if (!irq) {
>> -		dev_err(dev, "no SATA DMA irq\n");
>> -		return -ENODEV;
>> -	}
>> +	irq = platform_get_irq(ofdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>>  
>>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>>  	if (!of_property_present(np, "dmas")) {

Hmmm... np is used here though...

I will drop the patch for now and wait for a v2.

>> -- 
>> 2.54.0
>>


-- 
Damien Le Moal
Western Digital Research
