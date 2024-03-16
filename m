Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730E18E0E
	for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597672; cv=none; b=HWmF4lKUncAEqs6u5dTUpbdy5nf3/PN7ka7O6cEloV43V4JSaXhsT7Z0/CWRFRmEv7llgtRCvoMnkM7keMtCShSAbHR6UnOBnw1LMIMdCW7BEbeZnBuNjMWosDYU8Lx8Va+oU5QRYVOFVTbse0WUbTwPcxmnP/wiyt8TsNPckOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597672; c=relaxed/simple;
	bh=1ZeuOuF6qcFUs5aG5NMNwu+lStWbKH9ma2AETFjgt10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA7uBRXyQt/khGyvz/3Rbneh6r0/xcSjr5ZLNUC8LWMCjH65oh269X27gZOuDaDV4rRk3/mPr3BsUZjWWgxWCht0RFMLXS3kgW4kZGuHXicXOlXd8BQCSk/FH699yyByrnQ2idyxpGnW1jgryUmPzHICf6z17Yt8q135d4Ncqes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzscX+ct; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzscX+ct"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d094bc2244so41249631fa.1
        for <linux-ide@vger.kernel.org>; Sat, 16 Mar 2024 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597667; x=1711202467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmW7AXhAGbVko/FgNcW8uBHBxMjV6jCTrQOHr7c3FdQ=;
        b=DzscX+ctwyqT9vmfWG0bDHJY129ZDOiD23RgUoM1bNTyE01Ban/SKHElVqmn9BFvhI
         PjzdCK+4p9u+K6F5bigeRrtyV0XP7W6evKtQwYVoOoVfeQSVV3hSy+jMy3XiBIU7BIy7
         ZjGb7NpBCOqpa4AwEvvxe9M/OJREjM71uAXOUay5Ixt5tnTf1u37hMz9bi+gLbtn28v1
         qpa39qBjPmDcg5odYxn+t0NErLFO0Yh/zIhkBdL2fNxOHn0cCHRynVM3OZPvoawMFz+A
         cN0xlGFk0kTPb8h5iGsT4fAh20akngSeb1MVYvqSY2EJGF+x7vXD0m/aHX5xGzNpj/bW
         LPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597667; x=1711202467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmW7AXhAGbVko/FgNcW8uBHBxMjV6jCTrQOHr7c3FdQ=;
        b=T5lEbmEMNP2Q6XW5UvMs3N5Tbd2Q+AktebQjX5q7l8xtEqlDJH0qkIUiHlSLxrlY35
         evXpxTWpcaB+kWG477ptQu59w46zLEPVdgtm8uZ/5pqrYmhMPqRsW7ZduzF9O0dABd3q
         AP3LivlxA6yhYms5RcAWFd01mgkZ3dF319v4fedEIQ7SBfTXQ39hZeBSv6HyfZrKf+4f
         dLDna3NYMRj9Z4PhJ9O0hlb9g9piCGxMwec6ZkZXSvt++2DH0qtmFyCzEc8C4NDSfAFl
         Pb/pzYdbb5pMd77YNPrMAbbtrMBDjJ/am4eUHuO7OU8hY9m6O5oaP3TgtwZ8+wI+W2/D
         KkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUt4MtHG7hMaHMbpO46cVP2Zv/5BKlAM5NQMtV+4A5lGPpZ79KK9V8RbITwuJoqceN325ISOezgp+gTCfaCLIdC7SR60lN26TD
X-Gm-Message-State: AOJu0Yy8RxdwdwqDOWer0i9Dpx6pod+H8LPu4f08cmorWGiwP2wArKPQ
	YCuy3AIZMSv1V+hiU86eKjeN+hOJwYwfdLEB8Lg4Uq2YezsULWih
X-Google-Smtp-Source: AGHT+IHosyFGvC6j38Xh72sN2fhpkAAU6CeuUIxLEpGCWjKpdgPuBZNSzDuUkYcfPjVskgWAyYbauA==
X-Received: by 2002:a05:651c:1a13:b0:2d2:c7ab:6396 with SMTP id by19-20020a05651c1a1300b002d2c7ab6396mr5921629ljb.37.1710597667347;
        Sat, 16 Mar 2024 07:01:07 -0700 (PDT)
Received: from ppc.Dlink ([91.223.70.172])
        by smtp.gmail.com with ESMTPSA id p19-20020a2e9a93000000b002d42b1c3750sm789266lji.67.2024.03.16.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 07:01:06 -0700 (PDT)
Date: Sat, 16 Mar 2024 17:01:04 +0300
From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Conrad Kostecki <conikost@gentoo.org>, 
	Cryptearth <cryptearth@googlemail.com>, linux-ide@vger.kernel.org, cassel@kernel.org
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with
 port-multipliers
Message-ID: <yje3amxvq6is5padpzd27krlatyn5j7qxfwejmbankkuq3xjt7@5zqxlw2xyuyz>
References: <CAFDm6W19R3KHDO09c94Uwry9mdG+whAVy=u4Sdpt30A2MK1KPA@mail.gmail.com>
 <CA+PODjqxYcBMc=R792uOava1u0EYZtrWTOw9HvKUBG4=zYbzcg@mail.gmail.com>
 <CAFDm6W2dWu5+Dz2DiWG_9L-VatM6Wj=pMHM2th74Wh144kvqvg@mail.gmail.com>
 <066b051d-f092-4ba2-9a26-1c73f3df4252@redhat.com>
 <emd39240ba-840a-4d09-a992-7a4b15cd8189@588c6196.com>
 <e09f1db6-2720-4fbc-ac64-2be498be8e4d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e09f1db6-2720-4fbc-ac64-2be498be8e4d@redhat.com>

On Wed, Mar 13, 2024 at 11:20:18PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/13/24 10:52 PM, Conrad Kostecki wrote:
> > Hello folks,
> > 
> > Am 13.03.2024 22:21:51, "Hans de Goede" <hdegoede@redhat.com> schrieb:
> > 
> >> So on this 4 port controller we actually get 4 + 16 ports.
> >> which isuggests that port multipliers are handled transparently
> >> inside the controller and that ata15-ata18 are likely the ports
> >> on a 1:4 multiplier on ata7, ata19-ata22 are the ports on a
> >> 1:4 multiplier on ata8, etc.
> >>
> > do you have any idea, if we could make somehow an non-default option to disable such ports?
> > 
> > The initial problem will now persist again. As for example a 16 port x4 pcie card (4x ASM1064, each connted to one pcie lane, so only providing 16 physical real ports, no SATA PMP) will take about 3-4 minutes to slow down boot, as 128 ports are being detected and waiting to timeout to continue further.
> 
> I think you can already do this, see:
> 
> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> 
> and look for libata.force
> 
> So lets say the virtual ports for the transparent PMP support are ata8-ata31, then
> you could do:
> 
> libata.force=8:disable,9:disable,10:disable,...,31:disable

Too long. libata.force=8-31:disable is better, but unsupported.
 
> Although I have to admit that that is very verbose and it relies on
> the probe order to be constant which is not guaranteed.
> 
> So being able to specify some sort of port-mask override to disable
> the "virtual" ports would be better.
> 
> I guess you could even add a disable_transparent_pmp_ports bool module
> parameter to the ahci.c code which defaults to false and then simple
> change:
> 
>         if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
>                 switch (pdev->device) {
>                 case 0x1166:
>                         dev_info(&pdev->dev, "ASM1166 has only six ports\n");
>                         hpriv->saved_port_map = 0x3f;
>                         break;
> 
> to:
> 
> 	if (disable_transparent_pmp_ports && pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
>                 switch (pdev->device) {
>                 case 0x1166:
>                         dev_info(&pdev->dev, "Limiting ASM1166 to its six physical ports\n");
>                         hpriv->saved_port_map = 0x3f;
>                         break;
> 
> And then you can activate the behavior with ahci.disable_transparent_pmp_ports=1
> on the kernel cmdline.

Non-standard vendor extensions should be enabled with user attention, so - invert logic and param name:

       if (!enable_transparent_pmp_ports && pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
                 switch (pdev->device) {
                 case 0x1166:
                         dev_info(&pdev->dev, "Limiting ASM1166 to its six physical ports\n");
                         hpriv->saved_port_map = 0x3f;
                         break;

 
> Although some generic mechanism to set an override for the port-mask on a
> per controller basis would perhaps be better.
> 
> Niklas, do you have any remarks / ideas ?
> 
> >> Conrad as the author of the patch adding the original port limiting for
> >> the ASM1166, can you submit a patch upstream to drop the port-limiting for
> >> both the ASM1164 and ASM1166 for now, with the following tags added to this
> >> patch:
> >>
> >> Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> >> Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> >> Cc: stable@vger.kernel.org
> >>
> > I've send the patch
