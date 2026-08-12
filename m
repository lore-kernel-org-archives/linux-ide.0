Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDA6331202
	for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560574; cv=pass; b=AU2Q4i84s7pqCD9lFtT7L+7C+oQlGjL0iG2P7V8xi+Y39q6htUAJnVXYoGihFLDsbPylihVC1dxyVuOn1fLL7EP6PRA7K+WiFw5JjXTTzylJ7uUZvSirnmDJtBEEffN7rnV/mSXdXF4pgU2yW1HE+ufcRzU2GtCFlq513C94jY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560574; c=relaxed/simple;
	bh=lEikoKzMSTyT0XM+tm/L4rvzEFbg0oA0rnsGnviv3NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4kCJVi88hd1ft8Z8WGAi7xWFPsMDK4/fcX+zFi299mPDm53zWz/AQqQ9CR1kYLxPr7VWtW0jE310EPZi4IKgcuAblVJA+414LAfQV4BNL4cXx+BHEz8jJg5xyTWSk+MekZh3ad1I1O9rwOI9KQExxmo6rZZ/Zaja4iOdXrLRns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hau97owY; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hau97owY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a1f80fd2e4so345648a12.1
        for <linux-ide@vger.kernel.org>; Wed, 12 Aug 2026 11:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786560571; cv=none;
        d=google.com; s=arc-20260327;
        b=f5iAUUQzu8fOJw4qzSHHYkTs267Agmy5gBLLy4HImeIUVtRZGwbPqGiKuKTw+GTY1S
         VguE13u6WpzNw2n7U1TPmXaWFYadkhc4bmNa3SR/bPVNtiauvE9DbDjlgy3Xt/HG7Xst
         ecbN/FGVTHnufl56wTyLkO76OIs9phtpmJI3onvztumFiDrJwjx7pdkSVJqLwEQkq5QQ
         vqtLYEPw7R1z09Lyjy8zz9et0977g/dCln4jjCGsHM/wZPS22vgAxZt+E2x953Y22hfv
         IT49V3YLNyuyoq+4BodcSUzq4llSZe4lWP1UnUFwItYSJwr64Xdjw5YFTwIUeALa6D6O
         A5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JPlSM3/QC5/kiRzsYd0YVGvLcgoaVNcY97PavpjGTQM=;
        fh=NOcz7qnIQR6z3t1l9qZJhkS+4WOt7t/Zz39mDLKw0gY=;
        b=Ty5gicHZMrBSxZCqQU6DMzPUhXhlSjo6rsoNQJjhMyg0F3bk2xiAloYAX2tzSufEVR
         nmflA5rZV5/LNgV6WiXHjHLRstD0dhRFxnF3QO6uBZLKUibmPV4MBqeW+cb3r7k2vBrq
         /6EfhMv4GJ6jDxenV2XNxdOrPXYEprCOCv6eQXdDwdKTbt3PIUHaUqO+pGMGcEh9+xcX
         9qJxalwoewPAQ3GyEnnmtxwoSfND+8lAFJVVNM3M8UgnlcDWYTu3o4nGVvsRFYQsO2aQ
         UwUdOW5hc68mjz9VXwSmP04MTb9gNhI6DiCR3or/6XSbXqeLEI/B4mHrCfO1aMa6Puuv
         2ktQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786560571; x=1787165371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPlSM3/QC5/kiRzsYd0YVGvLcgoaVNcY97PavpjGTQM=;
        b=hau97owYU3CAm0K2uDRxQWGH3mHlxVtISEGfFb9uOv0y8nDMaQTKIy+X+HTEDhZmzQ
         djnnoALepeh+yjmTJTCBQGOZ4T3FrHmgJONuj94SAY3+MhEpaMy76cTHYpoNfpFYlwbZ
         rdZvmTrBulE0dgTWY9Gtw/7ERLnqiSwwfkgW+Z+UXvMZTwpsEyqiMrst8f+7XkeLfbmq
         QslxkwmnM7eZYtA4s6RLQusnFg2iPCxc0uMxsijbPvl4rjJQpdgAIF+7/vUwqjRD6c0w
         VuVnKuq9LWTbMZkyf32TmLDPMlUR2cda60QcyMhqrTqWcC8JajC56bWjU3aC5kA5/6IG
         aKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560571; x=1787165371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPlSM3/QC5/kiRzsYd0YVGvLcgoaVNcY97PavpjGTQM=;
        b=nGurJ6a9fv9nMKogpfGBuRljxhcL3cbED7ZERFJvF94EvJPTmI20iNUVumydLc+VHR
         tTiOuJueF/c6KR//z+xIYPgE3xv246eAuD2XHKVWWIQeKc2l93kHEsr7rJe89KwPBTcP
         3UU7bZo97OsWnqulvuma5ys/v3o36JBZGDy6eF23Vq4rpXliKL1Wi29WIT8wc4gB9GYJ
         67CrfemtDR7XwB2LJfXI2sCFBAK6zro9XRi5qkH+Q9Y0S9cfwi53+dY3TkTZHu2d6UO5
         WifGcqFkhwJ7/mvvlTYqVF2F+kZXli6/DhM3/AupZ/O6f4CpVOKiAY/jwJjcXp+Gvc6M
         lbuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNS4aWcRXs+voEUN641T0cOYjMB5j2TYUqabwJFvMyDw/AIjewx44e9RleDKwsWVEawnZtHYg8Tys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhJ93Udo+J+v8EWe2vtbVmOXXcZVObiaRoaVJaeHnqr2Qbv1q
	kA0MAlFR0+wPoJ7CbDf7JjYeSV6jSz+3JO1/AoEVl9JEkQrWcfPRQyM81ySyC2kNlsXxMq3klj1
	EvVP5YHEIE2guXj1VlM2Q3shVW1M6IGN//A==
X-Gm-Gg: AR+sD10SS8Vvol63yp3oAt3hqKCHkCzePYoOX/5qeD6WiNRcgbenfXtmvnDTOvjvvY2
	/ciCfQQmbWXhr/Gg6Qlqrcw1HFyYpUn7Ebg68sz+zVClhObT/wyIZK8FcR/9h+GCHOg4ly0AUcP
	WvCE8vMO8YXfZLXm3dd6DyDdHN0kOIY8RtbHccDceFeNU7+1r03e3+hrusHBRrpwVetLVZ3ndh5
	pqtRvMwfNDlIHfrQwgEeGLbBaIJjSf6TxsFc0LzqsD5comP4yju9XmQaM0zTy2z67gospMmHm3M
	MYE4O2OBpAvjfkC307sWqb8J0h+zH+LWzMddkis4uewYZsBePme25LAsxDXJ3I2qUAWZ9r21Mcc
	2hJoChUZF8feVCyWVYNu71YqfgGK4zVCbQtt0Wce1DaIQfn08Kmz6NGxuvXaGtWRi8g6OkBgKFk
	OVRXwJ6gQM1yHyjz6YwmbsOrWP/mjl8+aR1G7j13Y33FAflRRfQty8KPk=
X-Received: by 2002:a05:6402:5608:b0:6a3:603a:745c with SMTP id
 4fb4d7f45d1cf-6a37f110c4emr498997a12.5.1786560570831; Wed, 12 Aug 2026
 11:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712213728.824420-1-rosenp@gmail.com> <7c69e55c-1877-4bdd-aa18-9154acada32f@kernel.org>
 <anw-k62wK-GhkHSI@monoceros>
In-Reply-To: <anw-k62wK-GhkHSI@monoceros>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 12 Aug 2026 11:49:19 -0700
X-Gm-Features: AUfX_mxDrCVhMMF_V3ilu0hS9bn4b5CKw--q_85DxkV0vp-ULyRazI3sziq64f0
Message-ID: <CAKxU2N8oOmeRK2=2Shb=5WMYBq9gmpiWip4w-g=vmzNA_bNSMA@mail.gmail.com>
Subject: Re: [PATCHv4 0/4] ata: sata_dwc_460ex: cleanups
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	Niklas Cassel <cassel@kernel.org>, Jeff Garzik <jgarzik@redhat.com>, 
	Mark Miesfeld <mmiesfeld@appliedmicro.com>, Rupjyoti Sarmah <rsarmah@amcc.com>, 
	Prodyut Hazarika <phazarika@appliedmicro.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:41=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Mon, Jul 13, 2026 at 04:31:53PM +0900, Damien Le Moal wrote:
> > On 7/13/26 06:37, Rosen Penev wrote:
> > > Fix various issues flagged by Sashiko against the original submission=
 of this driver.
> > >
> > > v4: remove interrupt fix
> > > v3: Shrink series to Fixes on the initial commit.
> > > v2: sashiko fixes.
> > >
> > > Rosen Penev (4):
> > >   ata: sata_dwc_460ex: use platform_get_irq()
> > >   ata: sata_dwc_460ex: enable SATA interrupts only after IRQ handler =
is
> > >     registered
> > >   ata: sata_dwc_460ex: fix clear_interrupt_bit() clearing all pending
> > >     interrupts
> > >   ata: sata_dwc_460ex: fix infinite loop in NCQ tag completion
> > >     bit-scanning
> > >
> > >  drivers/ata/sata_dwc_460ex.c | 38 ++++++++++++----------------------=
--
> > >  1 file changed, 12 insertions(+), 26 deletions(-)
> >
> > I applied this to for-7.2-fixes, but I reversed the first 2 patches.
> > Thanks!
> >
> > (if you have time, please send further cleanups to address the other is=
sues
> > that sashiko signaled).
>
> I think the analysis for the fourth patch is wrong (or incomplete), the
> original code was (a bit simplified):
>
>         unsigned char tag;
>         unsigned int tag_mask;
>         ...
>         tag_mask =3D ...;
>         ...
>         tag =3D 0;
>         while (tag_mask) {
>                 while (!(tag_mask & 0x1)) {
>                         tag++;
>                         tag_mask <<=3D 1;
>                 }
>
>                 tag_mask &=3D ~0x1;
>                 ...
>         }
>
> Given that tag_mask is shifted left (and not right) the inner while loop
> yields an endless loop whenever tag_mask's least significant bit isn't
> set initially. Given the outer loop this results in a hang if tag_mask
> !=3D 1. So the issue doesn't only trigger for tag_mask =3D 0x80000000.
>
> Either this never worked, or the problem doesn't trigger reaching that
> code with tag_mask !=3D 1 easily. And I also wonder if the change's
> urgency was considered carefully enough to justify a commit in -rc4 to
> fix a bug that is already roughly 16 years old.
>
> And similar for the 3 parents of that change
> (c2130f6553f4a5cbdc259de069600117a995f197):
>
> For 4bbc16a353a98023e5ddfca7c1fc0e49971cf4d0 I wonder: Does
> ata_host_activate() already need the irqs enabled? If yes, the commit
> is wrong.
>
> For a4af122106f73ea510bb35a9ea1dedd980fc0db7 I think it's bold to claim
> "Also fix unused variable when CONFIG_SATA_DWC_OLD_DMA is disabled."
> given that the unused variable warning (I guess about np) was only
> introduced during development of this patch.
>
> For 66c4e310ad71f41e41736d33dd8a1fb5eaaec7f3 it disturbs me that the
> commit log has: "If INTPR uses standard Write-1-to-Clear semantics,
> [...]". Without that the justification of the patch goes away, nobody
> checked that?
>
> All four commits have an Assisted-by tag, and I have the impression that
> nobody involved in these commits has the hardware or even the hardware
> documentation. But maybe I'm just to picky about changes that enter the
> mainline in the stabilization phase. =F0=9F=A4=B7
I personally do not have the hardware. I know of one OpenWrt user that
does. I'm sure I'll get notified if something breaks.
>
> Best regards
> Uwe
