Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2428DC4
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808397; cv=pass; b=DsL3IEmcB3WtQp7qJt/LSXx5HcOwtKeljTGS0d/O4ex5nhr0CTlwgeHRHX4ECyCIagrUrpOK8RsHYo5eP+73rCyiXxkhTVrhL0TYxpmY7ykrIOTVzYYXK9RL99myW4lWcTgbIKi+KHFEAi9mTi/K8ixz6k4K2aywSeYLa41BDpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808397; c=relaxed/simple;
	bh=3amgsUVBZK070h1p5gXhzGy/iZ8e7ohCQhoqh6zM1cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdlpD0dq0PRyKDmWyq1A3cA/mg0UToPuZzw33GLqIeFZjXlCUd9vjvLkaYkajyIQCJ7nDoXhFMWQBdcMCi5FPTAGmJDTK0FvNuvBcFunbUO1P28z8/G8pBR4VAuUUxEdXjvYIbLNm0ngP2Kpvgr75GF0JgL1Yxdc0BTUbBqn7os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPh7xUWm; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPh7xUWm"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697edb1bf6eso6149190a12.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 01:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808394; cv=none;
        d=google.com; s=arc-20260327;
        b=NgD3u2Y1v2q8oRl+qDPlrtN4/bASHQY1taJeK1c5dwCg8j46r3hbrgcG96oyWE4wU9
         mCcYN6bKTyP5+HfsTPfEcbD7XubNqwF2gv04iehClO5NFtG7hiKZqbB/LbU6yrOfdgYn
         AezMfhpBjoFoXNJvQHTlid3ybtLw8vXMAZ3h271h7dZahPbuQICDZrRk+kXPNRooLT97
         443FTHdOBguosOjzj+mFsThZzFgP98SAP7WtfYIRJoNtR/3LHmk602QXiXozBSVYP+mK
         0q+jDyaiwExCYezmbY57u4DNbP8MMYtQxnVxsYBTglvdRqklSc8JW+g6LlXhg8GT9yw5
         w/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3z85wUvVFpszs9cO93tFnpa+6ZkbflP7l3WH6a1kHuc=;
        fh=ES9cMHffHR/zEP9p3lHiw5U3LaUjnU5xSRwWiUmdud8=;
        b=ORzb3puAHCQr2iL2O78YQmFJzgq8uHwSahea9TrpqMtqXZG+iL1ycLoDt7QO65zw/p
         LsXVFx/eDKUZERwKERSGoqrRatBolJZJ+U981y6PGjPi2NimBp8hdLjt7MSro0za9J71
         1FkrlMSD2Uym/prUFO7REvJhRCDfp1gtPg0E9l+RG0qW+rTYle7409w2DPduIRlJgZvM
         pFuTipfA5wYvqrgB4luwHdEsvP6aJqqfYcS40xN6mJj/eTOilY1j8I9bLj7cLdOWl7C+
         u63c7Tg8IPIVIX8ALUyYsHENO9Jg5d35131Xx9g+8cLQaKiM6rmjqzpuXy6X7XwwPahX
         0F1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782808394; x=1783413194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3z85wUvVFpszs9cO93tFnpa+6ZkbflP7l3WH6a1kHuc=;
        b=sPh7xUWm8Yh0WpZReuu3AjRokG8ltlTgQQOYKMlX0ne0SjeW4fdU2eOEbY3KdaWFMN
         5kUBacoCH6RBx1M0+8rs3P3q2neI9SCRFUVf458DAvFU5GYiLEK1FsHKh/+iA/mzLyQs
         CrGHbG1At9/P/rvnIk1/31dn70ulyXvu3c+nEY95ij5vH/sGwKcVUT13eLpOqGYd8HRz
         m5MmUDXsLKzfILHhxmT0zRRMwZ/nC7vMpRokhh1xbKluQ9k5OjjblSBH0/F3WJ0Y4OFf
         Ar1/NWKloP2RC6V0TEIIbj7d398GiYA5a7IzFmtEdnmNuZibk9KiNt2HmzVmYtcupGqN
         3sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808394; x=1783413194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3z85wUvVFpszs9cO93tFnpa+6ZkbflP7l3WH6a1kHuc=;
        b=rc5DDEtKeZ9diybPM00iPw0dpif/H2z8YCdHmLgyORu2lURLrhkJhujR7QokSALV6u
         qe8DeXqXUa9j79ch93TjlR4uU9ANBd7yzjX5IU9DrrLCjF96gtLGAHXS+MklSYrKMKK3
         20j3w2TTwhJVh7/+a0brATKyZ1OjxoaaSTOQnBJefBSWoNiJNrenOY0XWe5e09e2mVsQ
         1Kvm7zhfcx3x3+fQ05RYZ69Hf+mjTADqIYOUe2Ee4NSSRsJuwgrxJxmhoD6PPQ90A2Xc
         zSuLv4eydAvNy1PsbrgdfUnmQ/EhkkEqM4P6KoFsbrDCpVTijs5/I+VGVa909c76jVqJ
         pqMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqBQpOmiroZ2qUvQXMbN1UZGtb8PYETSDfbcVYIJFFPjw+vRhfywlnTHdKE2tEGHuR4XWcHauGbJDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXhl7Z80S1RvRcSFszN1CMnkOGqD56jUCeHwZ2QFVUqTOh6mC
	OgteYCh5ukvmDxLiJ9mSHhZydc/r1OAtR5VLjhD3wUtmQJ+vClxcPKDBOJwN+qmrpBSLjZBwr6O
	shuxeOKh2CH9Q8teaT9aK+lF11Q/KbsA=
X-Gm-Gg: AfdE7cl57UPM9OCeKf/s8wz5SEDwSMiSI5ujsWhXiaJ6Uxdib4oA0dRG+K+e461gudj
	KXGpkG6S0ggRQmLi+HESMC6FDhoHvdEiU7zxbr2LlonY6QLoqGd/izNK5o9gW8dIOx6HsJ6LMLx
	s7qturiZ9FyWdVSjZzpfuV+zeMODy7gFubDP61Rop/sSK0cAna2QtFaEZba9MYxMaUA9IhbmuNN
	r18vmo0ETALa5p7UWnjGF6WOXoYdNEJCNLxrpMzqX5wEobdW0eqxJ3n/FzooLmvZgw9l5VNpbPt
	0MBbbgueEtOEanQ3QxW8EJezjrvP+QtegNnTfjddO7jVz75BTM7vU2j+If7oSrYd1ThgoTx12S8
	AIrDHqdEJrjHc29I0mZmKGuNmaBghWakJuWWldvvZR3utzz8=
X-Received: by 2002:a17:906:2092:b0:c12:36ff:6ebb with SMTP id
 a640c23a62f3a-c12872e8c02mr62359166b.44.1782808394157; Tue, 30 Jun 2026
 01:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628230310.1214770-1-rosenp@gmail.com> <akNzEGgiYC5V3rtc@ryzen>
 <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org> <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
In-Reply-To: <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 30 Jun 2026 01:33:02 -0700
X-Gm-Features: AVVi8CedqSr7UNdVdCZS0Sh0zdlOo-Q3PX7sCoXy3dKGpTwho0E3HVB8BO89r_8
Message-ID: <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 1:30=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On 30 June 2026 10:21:58 CEST, Damien Le Moal <dlemoal@kernel.org> wrote:
> >On 6/30/26 16:41, Niklas Cassel wrote:
> >> On Sun, Jun 28, 2026 at 04:03:10PM -0700, Rosen Penev wrote:
> >>> Replace irq_of_parse_and_map() with platform_get_irq() in both
> >>> sata_dwc_dma_init_old() and sata_dwc_probe(). This is the preferred
> >>> way to obtain IRQs for platform devices and provides better error
> >>> reporting.  Remove the now-unnecessary #include <linux/of_irq.h>.
> >>>
> >>> irq_of_parse_and_map() requires irq_dispose_mapping(), which is missi=
ng.
> >>>
> >>> Assisted-by: opencode:big-pickle
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>  drivers/ata/sata_dwc_460ex.c | 18 ++++++------------
> >>>  1 file changed, 6 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460e=
x.c
> >>> index 4fc22ce4bd9a..35aa7f9acdf7 100644
> >>> --- a/drivers/ata/sata_dwc_460ex.c
> >>> +++ b/drivers/ata/sata_dwc_460ex.c
> >>> @@ -19,7 +19,6 @@
> >>>  #include <linux/device.h>
> >>>  #include <linux/dmaengine.h>
> >>>  #include <linux/of.h>
> >>> -#include <linux/of_irq.h>
> >>>  #include <linux/platform_device.h>
> >>>  #include <linux/phy/phy.h>
> >>>  #include <linux/libata.h>
> >>> @@ -226,7 +225,6 @@ static int sata_dwc_dma_init_old(struct platform_=
device *pdev,
> >>>                              struct sata_dwc_device *hsdev)
> >>>  {
> >>>     struct device *dev =3D &pdev->dev;
> >>> -   struct device_node *np =3D dev->of_node;
> >>
> >> While this patch drops 'struct device_node *np =3D dev->of_node;' from
> >> sata_dwc_dma_init_old() ...
> >>
> >>>
> >>>     hsdev->dma =3D devm_kzalloc(dev, sizeof(*hsdev->dma), GFP_KERNEL)=
;
> >>>     if (!hsdev->dma)
> >>> @@ -236,11 +234,9 @@ static int sata_dwc_dma_init_old(struct platform=
_device *pdev,
> >>>     hsdev->dma->id =3D pdev->id;
> >>>
> >>>     /* Get SATA DMA interrupt number */
> >>> -   hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
> >>> -   if (!hsdev->dma->irq) {
> >>> -           dev_err(dev, "no SATA DMA irq\n");
> >>> -           return -ENODEV;
> >>> -   }
> >>> +   hsdev->dma->irq =3D platform_get_irq(pdev, 1);
> >>> +   if (hsdev->dma->irq < 0)
> >>> +           return hsdev->dma->irq;
> >>>
> >>>     /* Get physical SATA DMA register base address */
> >>>     hsdev->dma->regs =3D devm_platform_ioremap_resource(pdev, 1);
> >>> @@ -1173,11 +1169,9 @@ static int sata_dwc_probe(struct platform_devi=
ce *ofdev)
> >>
> >> it seems like you forgot to do the same for sata_dwc_probe().
> >>
> >> Which results in a new warning:
> >> https://lore.kernel.org/oe-kbuild-all/202606301243.9MrXM4WY-lkp@intel.=
com/T/#u
> >>
> >> Damien, perhaps drop this patch and wait for a v2,
> >> or fixup the patch to remove 'struct device_node *np =3D dev->of_node;=
'
> >> also from sata_dwc_probe().
> >>
> >>
> >>>     sata_dwc_enable_interrupts(hsdev);
> >>>
> >>>     /* Get SATA interrupt number */
> >>> -   irq =3D irq_of_parse_and_map(np, 0);
> >>> -   if (!irq) {
> >>> -           dev_err(dev, "no SATA DMA irq\n");
> >>> -           return -ENODEV;
> >>> -   }
> >>> +   irq =3D platform_get_irq(ofdev, 0);
> >>> +   if (irq < 0)
> >>> +           return irq;
> >>>
> >>>  #ifdef CONFIG_SATA_DWC_OLD_DMA
> >>>     if (!of_property_present(np, "dmas")) {
> >
> >Hmmm... np is used here though...
>
> Inside ifdef, that is probably why Sashiko did not catch this new warning=
.
>
> Rosen, I suggest that you use dev->of_node directly within the ifdef, and=
 drop the local np variable.
device_property_present is probably better. But yeah. I'll whip up a v2.
>
>
> Kind regards,
> Niklas
>
