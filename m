Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795600891;
	b=a7ljNfrBZjWokL6+Kl3ICCzXsoaA9pKf4/86IcYYeqn0TDYCDOkiH5xGJDdYFpPJ4e0A
	 sjpPfKV5c3Tw7dfJHDNWlgJNrkXNJ8LMBuFyQoUVtx02F3IwxnQK1kr38yqVfxhPS1uvm
	 D2WZJWHcemcK23xCNSMMgffLnIT9rQxTRkUcY+E7tYBk8I16EA92Z55TWwhHfefNye3Dt
	 ZBAqpidMih/8ZP9nuzPvWs3LrXtIw5JrgM5BxMCuIzD7k/Xxl2XZe3/oJZKsIgzZH9hNT
	 FrB4dq7UlnUReupnp8FlKopS4o1TksLx2+gCXH6Hk5GDbXCXenPdmJTtAg9DQKA+TJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
	b=KlLo9ZA9pO+tGEzqLUymrMtQO6TuPt8Nb+xBpPdfEZg7Wk6tMD5LYoHBMZOOw82d4Gx/
	 bg7XBrFw3IAdzwnYVXCKePtRrdpVnuus5siyJkP09lOb+D5uX90EZ6zMo/sr/00PK6dkC
	 HsPeR1R5Xa5jUwf2U2eiKNuNGk2U90RMM4ST6j2UADEK+ajIwraqLUqwp6EwcT+DULlq3
	 RphSl1Yejo/0RJXTzsk9JFG+7JWq4yodjK9R6y4CAeV3IM4YiO3MSY/p06wfLuoEtDq+z
	 aUw7ZJR4Jw9gDrlOl8+wu2goIFEWWZjcVseypSKpg3tWVPQAISB/KIjgio0hczDIaTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IHqhO7XB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5E606A321
	for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 10:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA5E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IHqhO7XB
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38431138772so7176667eec.1
        for <linux-ide@vger.kernel.org>; Wed, 25 Nov 2026 02:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795600890; cv=none;
        d=google.com; s=arc-20260327;
        b=SRYSpMqw/b6u4vsgkXS0AJF6sNHq++A0B0fpB7QpAz85UK2pSIbM6TKs1kyaubN2Lq
         kTg9ezBaoVWCcPUqc82r9ebzXUvluGr5uZFDK/iuAsgla47TdDClkWDThm2Rdg/O0wLK
         sTxmsHVA0f8MsBGe/PoxhX7h+6CfEsvP4iAMTngjLjyceNU1oFsAA1EkGPtP8HdjHUfb
         1PIHwP9pCvhNKXdNoziUQNCfg4S1FhJ9XFZm6qhuEKsgGbWF4QrkSUVq81ys77Br+Qh7
         yrAUW/8CW7LJRd0n+3Mm4qZMy5zm0TsezA82YkNdwdcLGUie00rhoU/gkYnG2sOfM/o8
         dOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        fh=hv9n3QdkbT0KdQouXqJ/38rIC39dTjG6oHXVQLvFqMQ=;
        b=kHQbf77bM2iv2nX+MV23VczgL5MOq9yi4ITKsC6RC/vA3aU5V241dzAILMz6dfkem3
         z3BUH1B4vNJZK1wFMPLZDcvf36FnvlxpmTC0Zj5YYEdlEFuzCKNeNiei3CNy2hE0mHJ3
         LsPnvVtkciNnCYDeZ5bZDJqXhNV2QkN+H4Gvev6CG72fpRzKiiKhxNQ0C23QsRDmlGLI
         guem6FLXxrT9DBYru3xQHbjG2JfTkePcuBGSsLv8SR4c1qY8lfIOuWTgFRkSeXHT3J3L
         +T44hiGV/U+LdwMp7EVM7oJF+dEbiX89kLOCB3Y6Se1CcTeYA2tXFDJbZGm6WRcXlFAi
         lbMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600890; x=1796205690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        b=IHqhO7XBb2m6VjigS6OmQDrdCPQsHL1CbqWkw10FyrmeJCMk2yfYtOz8vHO6NItTIY
         cbhU5KxlSEpwmJvn8XgDttPQZUnzb/nIl55zQ7o6oWP6YaRH6oM6y5ImllzyA3r3QTCB
         PMnpoON1MvI0E8nUCpEAXBBG64Z3bkR2mYCofzO1SHFcI5ldTH6fznTZqQslRWF2w+GC
         NLqxmX5lY3iFfYD4WfXGzIoPmD/YTw8aKoKzAI/ABh0HjaO1K+WtqmzXrd1iVoJF/Efp
         n+FraS4qa3uxVHbxg+yrSGio1Oro4wP4aG7KKQgsvarDVfCjbEeaqtUvw7twp1NK1nap
         Vodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600890; x=1796205690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0jNf9LvDeUT8dvX3mev+TB2gDDnK8ObeBjOtFwflXew=;
        b=sZzhUJMa3dWZak8GeN8iP9NKVm7quB/+P5yaJuQJbhydemNXVSk/wkw+2WAGkit3+h
         00PVJtr+0NnTo+0CaBUs82I+EU1L3SHQnVkyCKCiuuu+OM6+llWBKLGuECCNZSlVM6d2
         hmcROsGkvfZbymsi593xbBoctj/oUDLYZgo2sHAZB0pzlCUSSwd7GTSthpxBsw7phRnE
         PVJ7wCCv/xH26mMZZu427Y1SgpCADFWDaqBRpWtIHOZHIvUqLTV0XPHRX0g7L0xaOPKR
         KYRq/CrzkD6bBRmyRGVScXEZ+VFFl9PaXXgQv8NZEvd7WNnbtQBlgo1z9l1rknWOqmsR
         pD6g==
X-Forwarded-Encrypted: i=1; AL+hErEqRBWo9xRLN2MSm2ogLcsnbm4GDh1o8dAWuHGuVxkcmpkulQTIKwCMTNjtMaB164w8+ydXbsSa4R0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FKGnW+0UKzDRSR7ShUprL/7erQ3Nod88fdrc8TudI/2JA57EJ
	HMCtB5ato9sxGuvTr8IyEqSb1fPOJ8KqNq/CpFCTOKHq2FvCtUSeGDCS/DB/eqAVtCusKBrmq/p
	OXpBtB2mkgpaT2wyUzAUDIy7yyuhg4X4=
X-Gm-Gg: AZFdTZeYbX9zkcQaoRafTeoZaNAgDCOFIvGK+HLxO4D4ijTMc80KJIdtx64FEqJv6Cv
	p8DcMftCAGtgKy4ZGI/xADumPRFpTQ3bH1iB4K5gTO5m858W9B0o9ITky/2/aG1u7bhGy84hgMU
	EWzermcZ8yK7g3jQMc+gdBFETHxZ3h7hM2pnioF7c6frmto3keVrFuWCJCWnNCKXya3j/Pm6mtn
	lZtMyEhmNd1u5ByTVQLJ28VJTmkhqzkfukwn/P8PuJuQpV7BPq0ToL+8P8pJj8vJVynBbGBE6aH
	gi96dvij1KG1IsRheK7h4Nmy04IeRbyLo3LWk3RjnQQR7cMd1mI9owtKHc1ObPyXPGwDTy2IIRt
	BaVKHEG88VEj8nCSf70eTZuZDHtpVI2iszIih
X-Received: by 2002:a05:7301:dd8b:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-38571510675mr19622055eec.33.1795600890367; Wed, 25 Nov 2026
 02:01:30 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen>
In-Reply-To: <awX_cNOqtTjAP33a@ryzen>
From: Pe3k <pe3cek@gmail.com>
Date: Wed, 25 Nov 2026 11:01:17 +0100
X-Gm-Features: Aa3M54ouYqv21AOU9bWmU32JsLWokXrHwGO0cLR9AEzpEGq_IOCrbC6QpcKWpwA
Message-ID: <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP Gen8)
To: Niklas Cassel <cassel@kernel.org>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for the pointers.

bugzilla 221713 looks like the same bug. The ML10 v2 in comment 15 shows
"DMA PTE for vPFN 0xf1f81 already set (to f1f81003 ...)", which is inside
the same HP RMRR (0xf1f7e000-0xf1f94fff) that I see on 6.12, and its 7.x
symptom is the same "Emask 0x40 (internal error)". Their bisect of the 7.x
symptom points to d373449d8e97 ("iommu/vt-d: Use the generic iommu page
table"), but the RMRR overlap is there long before that (they saw the
PTE error back to 6.0, and I see it on 6.12). So my guess is that
d373449d8e97 only changed how the overlap shows up.

The H97 thread looks different to me. There the faults are "non-zero
reserved fields in PTE" at 0xff4xxxxx, outside any RMRR, and they depend
on the request size.

sp_off: on this machine the only DRHD reports no superpage support
(cap c9008020660262, SLLPS =3D 0), so I would not expect it to change
anything. I tested it anyway:

7.3.4 with intel_iommu=3Don,sp_off: no change. It still has 0 DMAR errors
and 221 failed commands with "Emask 0x40 (internal error)" (121 READ
FPDMA QUEUED, 100 WRITE FPDMA QUEUED). 3 of 6 copies lost 8 MiB each
(zeros), and the iommu:map trace again shows 21 maps with
iova=3D0xf1f7e000 size=3D0 from iommu_dma_map_sg.

Thanks,
Peter

On Tue, Nov 24, 2026 at 10:19=E2=80=AFPM Niklas Cassel <cassel@kernel.org> =
wrote:
>
> Hello Peter,
>
> On Tue, Nov 24, 2026 at 07:08:13PM +0100, Pe3k wrote:
> > Hi,
> >
> > On the HP ProLiant MicroServer Gen8 (Xeon E3-1265L V2, C204, BIOS J06
> > 04/04/2019) the AHCI controller is handed IOVAs inside an RMRR that the
> > firmware declares for it. With the default translated DMA domain this
> > corrupts disk data on every boot under write load. iommu=3Dpt avoids it=
.
> > Seen on two machines of this model, on 6.12.118, 7.3.4 and 7.4-rc4.
>
> You are not the only person who is having problems with HP ProLiant
> MicroServer Gen8, see:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221713#c16
>
> There is also:
> https://lore.kernel.org/linux-ide/5ad27a97aafbc08a8702d5b90d09cd59@posteo=
.de/T/#u
> which I'm not sure if it is the same or a different IOMMU issue.
>
> Does:
> intel_iommu=3Don,sp_off
> on the kernel command line workaround the problem?
>
>
> Kind regards,
> Niklas



--
