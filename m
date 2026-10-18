Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB83DE45B
	for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364703; cv=pass; b=UzgPLk+HuO3rWuj7vv6HhXRgWsQ+rfMvn3uOi3SK6buxkbxPtKfy3Ac/aFsKiQQu91WMRgsJNy54rjN1G1AoUPp7/zdabcHhGtjgkzo+1e9OGZwpckTJcFjC3ZrN9HgG/7I97u7I+R+s/eH5vZD1hTEyMMoU6UHhKzIGDsXiOB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364703; c=relaxed/simple;
	bh=5hlKbxxcI0prTGWkY2kVG+ktXHIzZp+G584+bSjB6Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNlX5tYouLQ8oqDVtF7gzIbaLn+vHnAivF2MExoHvBWnNWyy1ascy+TRXz7lcnIechtHyGv3kbACFeh8AjsRgaVeoN/Nrr7T0enQj1UlnA1ZzLmr+8TDPGFMkfiCbSfpJFEc2WT1uQaq3uxgFpkfOGP4cnCuc6/fIGEO4zqPEMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Sq80VPeD; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Sq80VPeD"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so3856062eec.1
        for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 16:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792364700; cv=none;
        d=google.com; s=arc-20260327;
        b=gPLLL8zxbatCTN+wdR7Gh5ckfm4JnjjJRQfbRyCubwL4+yY3zOW/gSTWYROzYDuOC2
         W9f+7dUbcpiHjfEkfP/sKNo73abeQjjzOOnsfmDkNrU9+6B67SCUqaopWZ9ImChNXP05
         MXBxnMDXx/stqxF51SftEQ9gIxrtFuTek6ILlBr7/tUhIkY7u5pQtiHbX8DBE+2Fwbnh
         WiGpifNrAGz7UIPxNYykbgfHaVVkGuGbvhTdqebq10hzMBVXsSWn9bby9Prw/YbWIBfp
         1xK12zE2dFGeyQ4j6Zb70SOsbsuNQDDtZOADZTv21uI4vWuuNNslLcCCDwIzGS4sON04
         m47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        fh=fvHGs3xFo7TKe9JBGNGivAOdC+BTKZVUH/GLusAb3K0=;
        b=LhVuwA+Ge1tyPd6A8oSVTGvU3HNC/LKy/Tdl2OesTRhqqo8PpLH1tCnq7zcKSRBfKc
         L+kzGVH2xFyIk7g/ksjI6BavvfxOA4ss2Bbleo2/IavQ+Pv0QrgTEtfTUtKf9yE8QpXk
         wcYaIeVBLoYEk0/kBHfoyFrgj9YBQ5ECU436VgFa9I64nx6Trd/UsTIz4CCMfuPUCPnh
         EvP6MM8NNSCtrXeMKvXFyUlFbq40B2khQebURcI7ixaz8+ycLpEtyLgYpOWczk+/dVu8
         EXLqs74ZIdWyAY1Z+hn2bhRHu1oCRedWyMy9VaK1OeB6lH0j594QkbSwnQEBAvIwKE6w
         QWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792364700; x=1792969500; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        b=Sq80VPeDEhmhoLpqqAvUTNuHS1WxtdEkZ+e+9Zu/DUSZ9g9lj7wEvYRM3TaX3hzezq
         R7G87o9zmI3cLru+IoItLxQ+R/S5PhyKjtOSDtN90/Seg/3Sil15q3joal94Ks8QKt/g
         Qdng0JwJS1HpIeivDj+2UiJEYo+nDtJCiWx/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364700; x=1792969500;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pdNuBmcWi1wZSwfuz2mNY+kCv6367R1XFhsEmvefW7M=;
        b=OD/eTh1kCPRh2KOP8AzuNZ2snRU4BOgXyeWq+mt8JEVrs8TwQ42RM0kp9bKnS4JdZi
         EGpIz+sC970yOK6UyrT6HFEMSakYPF2M/6Avx61NZT7Qs6IIVXnLpCxxtJ0mkBOegOno
         UZoZAZ97CnvZ+GlYkT6h5wzOBsE9uT+3YaUuBfHH5yMrFw1000yOmyn8kqd17IsO7duw
         VQctsN2BOH0JJtLe0FYSGjowllPJ0QcEEgQ2652XTuEwEaGBjCVekuP8nwIGr0FR23zq
         77HU9HdzzZBZw8bgIDwmjFuPcf0mGcrhlJPXGXo8dNJW4AltS2icf2NpBbLvfdIF6WuX
         9pzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdHZxntISK0h4clNlu2UCMhfSnneZtONy00ggDK4vON6I1yx0EcTyS3wVpOouMnogpbkO4fkK9giw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw6b8NDM3pHEPRYDTsxvTVHpptcDBMUJDp67FcIMfaVmJOrLMk
	whkK+xMG2vY0XbyFMsWX5v1/HXyCRjvZljS2S1nW8ZRG94glMH5aYz2koab3c2KLsy09/jQ6qfa
	QOHpIuSXd8ahkioEve7KDLBME4EkywLAUDHM0T2VMKw==
X-Gm-Gg: AYBFou0T9oIKOniLb7pNoO7lHvU/OPAVIqj7qLfbBLKnsvnIKYGti5eVEbhoxjQyc08
	E3xxIxgCS7UfyYPvyoJsz+M6EIMmo2ssXp1acuKFaLTdY1XfQehnE2hFyc0Gfm9StHEDodmK7x+
	gGmE++Dgw/pf0GFwyG2pYhs3bcyVcWwqkyBeeEDOsE+JQ5ekPzU6hjyBo1PdJhufH2N963KUG6C
	Xe4S55yfCdgFonzSoO7+l0kknGo+ew5o8HFB5/wTOzmm13dTkXatYaPMy1Ap674TwTmK4V54hBH
	Vjz26i6T6DYaTJK7EWEn09yTMCTQInmF7I5uEt4x/5nBqHISAVUtxTbs5Dwi2/1048zdi11VZss
	XCwSy2lGPAnEFdnw=
X-Received: by 2002:a05:7023:a84:b0:188:e51:e86a with SMTP id
 a92af1059eb24-1880e51e89bmr6391719c88.2.1792364699526; Sun, 18 Oct 2026
 16:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <4cdb2939264e0b7d767f44289fddffd40fddf504.camel@physik.fu-berlin.de>
 <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
In-Reply-To: <CAMuHMdXmZash+8PmfSVrT=Wwob-mkq0x4umyRgX2-yikV9kaVA@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 19 Oct 2026 08:04:46 +0900
X-Gm-Features: AclHuK-LLYBKws1C5cc1iDE2Bj1jC73GLJaKrThGJoscsEcvrzPj8IjxBlev-5I
Message-ID: <CAFr9PXn4henL=rQ3n73H7Mjwd7v6XX6Jt63h=Sywu-boOPggKw@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, dalias@libc.org, dlemoal@kernel.org, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yoshinori Sato <yoshinori.sato@nifty.com>, fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

On Sun, 18 Oct 2026 at 23:48, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I hope Geert can test and review your patches and I'll pick them up
> > with his Reviewed-by and Tested-by signatures.
>
> Sorry, I must have different hardware, as mine doesn't have an
> ATP865 PCI device:
>
>     # lspci
>     00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 20)
>     00:02.0 USB Controller: NEC Corporation USB (rev 43)
>     00:02.1 USB Controller: NEC Corporation USB (rev 43)
>     00:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
>
> My CF rootfs uses pata_platform, which is enabled in my working .config.
> landisk_defconfig lacks CONFIG_PATA_PLATFORM=y, so it hangs during
> boot. After enabling that, the boot gets further, but it still hangs:

I guess you have something like the USL-5P that uses the SH's onboard
CF interface.
Since Florian has confirmed their hardware has the PCI IDE controller
like mine and reviewed the change I think we're good.

Daniel
