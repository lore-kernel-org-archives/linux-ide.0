Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABC11CBA;
	Tue, 30 Jun 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808243; cv=none; b=pAYkQPRraTlduAMCNBViAzj4XJvoHtO12JdFXkgOjRMfMWzVA9balr67a7AVfX/0RvNWpcK9WUMJ1do6n8ssvh+v/++k5rF5UwlqS/NF/qp8EJQ5046UYpO1qDsHEqHYTnH4+Nv3eaWmfiz05GP/Yy/8mAT/nB5HAp+7ei7lOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808243; c=relaxed/simple;
	bh=cre7R12Cs718l5fAKHGR67TPuLhmpExqdRCC8UaMh8E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TZEEaKU0get9PsiA36BCLAlZoIdqiTgqxPE14Jlu0IXEFqmShGZjuLxG/LO7rNeOEv49SzGT+MNb49xDA5YU3OtnXECvdrYXPbMMvVJSbp/fkBmnNCrCiW6HiuQq43e3Bp70Ovu4orB2kf/kGIi3JlYJ7RQfaSKwuA/SBzsqBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcI8fn+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcI8fn+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE931F00A3A;
	Tue, 30 Jun 2026 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782808241;
	bh=IlDi9T3K+cwvIwVqccFFf+cCT0Vh/LW1AMZqyjikReQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=NcI8fn+P6+Xw67gUwTClfg88qcZsYMUu1eEs4d7TCwBezrV9pBAtW3ZtZLwhnRgR9
	 ruaArWiJZU3IpcQtYIAjjjvv72wNNjoXQ/9do/7/W4WktzLk3IeIdFh6AVe5hgp/TV
	 2BUGlKG1YuS34fillyMJNozG0cmnTMhJd8XZSf7FDvJlo1EGHYQMpGYk2xOelIES1x
	 GupUFBv8gQB6GzbwkTbk/ypWznS8vXUsbusO9/h1irT+dXCT8XBJPNcxvIy4Zdu0Oj
	 BN4RiZt1OneS38sr+ubCNhEcFiRtSS/AUcP5K31K/fJCmOvv+qsi92D+o0A5ShjXUA
	 H3deYhEQaQnIA==
Date: Tue, 30 Jun 2026 10:30:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: linux-ide@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
User-Agent: Thunderbird for Android
In-Reply-To: <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com> <akNzEGgiYC5V3rtc@ryzen> <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
Message-ID: <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30 June 2026 10:21:58 CEST, Damien Le Moal <dlemoal@kernel=2Eorg> wrote:
>On 6/30/26 16:41, Niklas Cassel wrote:
>> On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
>>> Replace irq_of_parse_and_map() with platform_get_irq() in both
>>> sata_dwc_dma_init_old() and sata_dwc_probe()=2E This is the preferred
>>> way to obtain IRQs for platform devices and provides better error
>>> reporting=2E  Remove the now-unnecessary #include <linux/of_irq=2Eh>=
=2E
>>>
>>> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missin=
g=2E
>>>
>>> Assisted-by: opencode:big-pickle
>>> Signed-off-by: Rosen Penev <rosenp@gmail=2Ecom>
>>> ---
>>>  drivers/ata/sata_dwc_460ex=2Ec | 18 ++++++------------
>>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/ata/sata_dwc_460ex=2Ec b/drivers/ata/sata_dwc_460=
ex=2Ec
>>> index 4fc22ce4bd9a=2E=2E35aa7f9acdf7 100644
>>> --- a/drivers/ata/sata_dwc_460ex=2Ec
>>> +++ b/drivers/ata/sata_dwc_460ex=2Ec
>>> @@ -19,7 +19,6 @@
>>>  #include <linux/device=2Eh>
>>>  #include <linux/dmaengine=2Eh>
>>>  #include <linux/of=2Eh>
>>> -#include <linux/of_irq=2Eh>
>>>  #include <linux/platform_device=2Eh>
>>>  #include <linux/phy/phy=2Eh>
>>>  #include <linux/libata=2Eh>
>>> @@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platform_d=
evice *pdev,
>>>  				 struct sata_dwc_device *hsdev)
>>>  {
>>>  	struct device *dev =3D &pdev->dev;
>>> -	struct device_node *np =3D dev->of_node;
>>=20
>> While this patch drops 'struct device_node *np =3D dev->of_node;' from
>> sata_dwc_dma_init_old() =2E=2E=2E
>>=20
>>> =20
>>>  	hsdev->dma =3D devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL);
>>>  	if (!hsdev->dma)
>>> @@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platform_=
device *pdev,
>>>  	hsdev->dma->id =3D pdev->id;
>>> =20
>>>  	/* Get SATA DMA interrupt number */
>>> -	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
>>> -	if (!hsdev->dma->irq) {
>>> -		dev_err(dev, "no SATA DMA irq\n");
>>> -		return -ENODEV;
>>> -	}
>>> +	hsdev->dma->irq =3D platform_get_irq(pdev, 1);
>>> +	if (hsdev->dma->irq < 0)
>>> +		return hsdev->dma->irq;
>>> =20
>>>  	/* Get physical SATA DMA register base address */
>>>  	hsdev->dma->regs =3D devm_platform_ioremap_resource(pdev, 1);
>>> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
>>=20
>> it seems like you forgot to do the same for sata_dwc_probe()=2E
>>=20
>> Which results in a new warning:
>> https://lore=2Ekernel=2Eorg/oe-kbuild-all/202606301243=2E9MrXM4WY-lkp@i=
ntel=2Ecom/T/#u
>>=20
>> Damien, perhaps drop this patch and wait for a v2,
>> or fixup the patch to remove 'struct device_node *np =3D dev->of_node;'
>> also from sata_dwc_probe()=2E
>>=20
>>=20
>>>  	sata_dwc_enable_interrupts(hsdev);
>>> =20
>>>  	/* Get SATA interrupt number */
>>> -	irq =3D irq_of_parse_and_map(np, 0);
>>> -	if (!irq) {
>>> -		dev_err(dev, "no SATA DMA irq\n");
>>> -		return -ENODEV;
>>> -	}
>>> +	irq =3D platform_get_irq(ofdev, 0);
>>> +	if (irq < 0)
>>> +		return irq;
>>> =20
>>>  #ifdef CONFIG_SATA_DWC_OLD_DMA
>>>  	if (!of_property_present(np, "dmas")) {
>
>Hmmm=2E=2E=2E np is used here though=2E=2E=2E

Inside ifdef, that is probably why Sashiko did not catch this new warning=
=2E

Rosen, I suggest that you use dev->of_node directly within the ifdef, and =
drop the local np variable=2E


Kind regards,
Niklas

