Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4892C11E1
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809555; cv=pass; b=WXlu/9b4VI2RCmqAQp8cLex1C5JfLN7G5YYwMjQGdVXJBe+7pO7b6hQQE/Y2oMcl/wr8F23sdQQ+6uNERcJ9kuPYFcxlQ5UBG3JQ59A1rLmOoA8zrBL7ZadoLia+1hP0lkN3OeOyEHl09oJ6HAoGuaJUPt8Om5Y5ynHTUwFq4Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809555; c=relaxed/simple;
	bh=axdi1pBi8AQUJSPXkWTSrySZAAOeVWRn2OUjZrxfltY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbmG0Xcd4WLG2Bn63kj6h4jfulM/L3BJJSN6RPnfBlO2aqQQ3XlhfcuwPiHBjA/QiOAG7Zo0KKM16aZdQe7bUWd6C+ho3D4LP8W9Y38vZ2OHFegJiFkJcvgwePvbE8RNbaJX2T3s7cZKuYd+1tcc5PFcj8SFXWrYuSa8YC5BNKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsB0ZQN3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsB0ZQN3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983f5c1c52so5213115a12.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 01:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782809552; cv=none;
        d=google.com; s=arc-20260327;
        b=bkq+LL5BXY5ySNS0M4c2zDpJCIQTBawv9RHEhrdpWX6F9YicTAKgNrMSv2krAS9H/L
         oAvFfyrSmkgB9tjngOonEb61nTCjhp5v/wIhJ8VWUUbBIoGw1yS6Jfoob3MAO86f6v8p
         9nSEqWPbwbqSKtIJgBAuouQXwIayp2E8cDpoJNdYtLVGrn8bgH7LF7EobCp6vVC1re2o
         gz1UeWBj1p8xxmC+AbvK7tMTIEu2tjn2ebD32XJFIYou94Jx+rzpDvh4Uky5Z73oYrW+
         bZfdMGicEgWxbj/qB2pqBWBNoAfIeGG6dqhCmVLide4U8Yzaa4Mf54LxUdwhtlI/x5d8
         zQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQ8eNgDuBcQ2xbr0VxEioWI2jew56oLaroABFc2LqVQ=;
        fh=vBBmyPYZ4xhi1GZ3mrpBrI1M9m0hwetYjaw2yeWfxqI=;
        b=qEzrh8FkcXjpyFrYLqPo9MdNVTmWltSKTqmPN3UdEEho1M43eq6FSr24UOAkTqa9Bu
         usn/+INgwmhSV5DtsByojE5EojaUowYuFYwwusP+JrPhLEd85fs9PFbBVxaKAhaolfJp
         mIIyTtRmgdULd/tmQVmweM/80PSgAibg4NKaKltIANynaBZxA+a1CyVtCBqIOkJh51Dw
         +R4IOE5NnGq4P0k2NN7cfdLxueOjsLX2eYS0NTNUoT7gk6M1qtCN/0zBx58915MIwHux
         3jeuprj8jrDDIDYEVA+DoRLKYvvJfitHvb/I5BY1CPwwLaDkzJHQiXjL6MDJpxBuHwqP
         y91Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782809552; x=1783414352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ8eNgDuBcQ2xbr0VxEioWI2jew56oLaroABFc2LqVQ=;
        b=hsB0ZQN3W1ifZ3ekwHqNN1F6G0U9VslIzx9hr9hrRsUwdp6P/3BQ47QzivkiO7gDBn
         UhJHUFv7luh7TBRI/uVejQHxe2cmkf+BWuA1+FHKY5CJuQqeRG0dicSJT7g5A9vnMbNt
         SnwIoxGakeLnQlrKWqZpzdPnF8zfZRD6TW+WFf948H/JkygpjXcE34o7OFmHffdfryTe
         UV4ZUCiWXrayU5R6gO1sbLxuezVKeS/ZFz19tEEKNTTHr7iqR+papZeywzsnLmMYaAqk
         DYAcNSEKhZCeuH2s5NLtMWcopu1YzDPkOBzO+spxWtG1hv8PAxgI36n9W035M9WblR7G
         QaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782809552; x=1783414352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQ8eNgDuBcQ2xbr0VxEioWI2jew56oLaroABFc2LqVQ=;
        b=oM/6TxcAfCquobYgy9Hv1dyPgtScAuCc+5O8/1SR9hE/wPtHvPMgnOiK7YxPqZTTIp
         FgoZZdAok86ZSx7T6otAOlNJ7xEK3Vs41qKPDMzWbVXHIjp7GxkiL3iIGeQfMGe4HDVB
         4lHzCIqNUitgVwORzM9edp02H33wYIVd1arc2DXAVuQ2Pb4y4cG63eK2OINoOOibT7ht
         mK6VHX+P2jcc1Elwgk+P4B6ISc2Qu1zwo5uPJjUMAJwPTu2KnKUYg0x6KgHT0UigBCn0
         fPH7unEnrR/J+JQTXVBHuL373i87I23BGpSAuiLlkRpnW1awf6TPXnOOm/gYWJnnlK0J
         /kwg==
X-Forwarded-Encrypted: i=1; AHgh+RroPHeqo26ChtvO2Fm3OZDXBzma+VBSKIDSP0vyJvQ+HUKI8JAYHql7a+BlU6dOsZhsiv0MUP8BM5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nq/SLxIuEbd4gftLjz/O0y97oP6seutkkCrhigi3DidB1nsf
	jlD9b/gd/zKkWQKl/7mMXClLXyFfekWNTEX3oSqK1gw/c8J0QqA1DT1YL/0hrY1hyx7e/8SRQvw
	UzuwUgqZb8+lhf9LSBFaYd3XlbaFBaaM=
X-Gm-Gg: AfdE7cnYRxTABIEYiiwwu6o8j2Rl6USsH/ZVRFbR8oP8qeoLF2lfrQD3yRfDozqbA57
	zWwMkXzCR31cZI9hsbjm/4oo6EEpMqjQ+qSg8+49ei//Pu9ePjp4Oz8bIUOak5fgwb8hj0VLMpW
	zLavwKYGB70gwlJoHrOCuDnF7lShWNSbxj0X2IiluSprQ/D9vqOc+1QOWxkebkl4yHWJ00hyWf/
	NXRoSW+nfe4w3johWf3u4PJWU46FDR7ueDrhTFYDZM6pUVytkwWxivgw8gpNWMAGgnqgNFcA1X5
	1FZBtjWHFDlfgFICH8UOglYvk4tLJZcdrwnSRbtft3iYHaXtCPbByNajTpNUa33UT1K3pqtXCZu
	AEMGQHfPCORf3ObLRH+QwKp8phKb/efjp4Le75dCROrvUU7E=
X-Received: by 2002:a05:6402:2691:b0:698:415d:318b with SMTP id
 4fb4d7f45d1cf-69879df07c4mr1004064a12.13.1782809551718; Tue, 30 Jun 2026
 01:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628230310.1214770-1-rosenp@gmail.com> <akNzEGgiYC5V3rtc@ryzen>
 <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org> <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
In-Reply-To: <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 30 Jun 2026 01:52:20 -0700
X-Gm-Features: AVVi8CeD-K8XcFDzTkin8de23EkzlHHtwZzJ1BlQbno0DUMTpfQC1QcFoGS_LmQ
Message-ID: <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:33=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Tue, Jun 30, 2026 at 1:30=E2=80=AFAM Niklas Cassel <cassel@kernel.org>=
 wrote:
> >
> > On 30 June 2026 10:21:58 CEST, Damien Le Moal <dlemoal@kernel.org> wrot=
e:
> > >On 6/30/26 16:41, Niklas Cassel wrote:
> > >> On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
> > >>> Replace irq_of_parse_and_map() with platform_get_irq() in both
> > >>> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
> > >>> way to obtain IRQs for platform devices and provides better error
> > >>> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
> > >>>
> > >>> irq_of_parse_and_map() requires irq_dispose_mapping(), which is mis=
sing.
> > >>>
> > >>> Assisted-by: opencode:big-pickle
> > >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >>> ---
> > >>>  drivers/ata/sata_dwc_460ex.c | 18 ++++++------------
> > >>>  1 file changed, 6 insertions(+), 12 deletions(-)
> > >>>
> > >>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_46=
0ex.c
> > >>> index 4fc22ce4bd9a..35aa7f9acdf7 100644
> > >>> --- a/drivers/ata/sata_dwc_460ex.c
> > >>> +++ b/drivers/ata/sata_dwc_460ex.c
> > >>> @@ -19,7 +19,6 @@
> > >>>  #include <linux/device.h>
> > >>>  #include <linux/dmaengine.h>
> > >>>  #include <linux/of.h>
> > >>> -#include <linux/of_irq.h>
> > >>>  #include <linux/platform_device.h>
> > >>>  #include <linux/phy/phy.h>
> > >>>  #include <linux/libata.h>
> > >>> @@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platfor=
m_device *pdev,
> > >>>                              struct sata_dwc_device *hsdev)
> > >>>  {
> > >>>     struct device *dev =3D &pdev->dev;
> > >>> -   struct device_node *np =3D dev->of_node;
> > >>
> > >> While this patch drops 'struct device_node *np =3D dev->of_node;' fr=
om
> > >> sata_dwc_dma_init_old() ...
> > >>
> > >>>
> > >>>     hsdev->dma =3D devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNE=
L);
> > >>>     if (!hsdev->dma)
> > >>> @@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platfo=
rm_device *pdev,
> > >>>     hsdev->dma->id =3D pdev->id;
> > >>>
> > >>>     /* Get SATA DMA interrupt number */
> > >>> -   hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
> > >>> -   if (!hsdev->dma->irq) {
> > >>> -           dev_err(dev, "no SATA DMA irq\n");
> > >>> -           return -ENODEV;
> > >>> -   }
> > >>> +   hsdev->dma->irq =3D platform_get_irq(pdev, 1);
> > >>> +   if (hsdev->dma->irq < 0)
> > >>> +           return hsdev->dma->irq;
> > >>>
> > >>>     /* Get physical SATA DMA register base address */
> > >>>     hsdev->dma->regs =3D devm_platform_ioremap_resource(pdev, 1);
> > >>> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_de=
vice *ofdev)
> > >>
> > >> it seems like you forgot to do the same for sata_dwc_probe().
> > >>
> > >> Which results in a new warning:
> > >> https://lore.kernel.org/oe-kbuild-all/202606301243.9MrXM4WY-lkp@inte=
l.com/T/#u
> > >>
> > >> Damien, perhaps drop this patch and wait for a v2,
> > >> or fixup the patch to remove 'struct device_node *np =3D dev->of_nod=
e;'
> > >> also from sata_dwc_probe().
> > >>
> > >>
> > >>>     sata_dwc_enable_interrupts(hsdev);
> > >>>
> > >>>     /* Get SATA interrupt number */
> > >>> -   irq =3D irq_of_parse_and_map(np, 0);
> > >>> -   if (!irq) {
> > >>> -           dev_err(dev, "no SATA DMA irq\n");
> > >>> -           return -ENODEV;
> > >>> -   }
> > >>> +   irq =3D platform_get_irq(ofdev, 0);
> > >>> +   if (irq < 0)
> > >>> +           return irq;
> > >>>
> > >>>  #ifdef CONFIG_SATA_DWC_OLD_DMA
> > >>>     if (!of_property_present(np, "dmas")) {
> > >
> > >Hmmm... np is used here though...
> >
> > Inside ifdef, that is probably why Sashiko did not catch this new warni=
ng.
> >
> > Rosen, I suggest that you use dev->of_node directly within the ifdef, a=
nd drop the local np variable.
> device_property_present is probably better. But yeah. I'll whip up a v2.
thinking about this some more. Should use IS_ENABLED to prevent hiding
this code from the compiler.
> >
> >
> > Kind regards,
> > Niklas
> >
