Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028248;
	b=FB2z7rddviuPlPyurxoJcR03RPXOaTIqnuX5i9ViFMgb58bhXSmBbMMjBIObVmloRMvR
	 uC45LuIwmyZ+6rbnL0dFtqXPmsCUJG1nijtTwk6ZtOUtZ1ZaXSb2bKO+Oa5eGf0HAjyNl
	 1HPH2N7vhF6uTSE/VSUPcUtDs/Y+RfTA6fXdg1BNcX3mUmxL1XZAa4LUL3QWowZOOb2+w
	 ZmSZpUd4bhljF0wp1JKnBqgmay6+iSFgb1WJNz63M5De+G/NuSbVqfeftXwjcHv5XADc3
	 MiXVcEi1xqR709JpTMwcfRUbBCI9fgDvxn19TMpJOnku0M8GTt0dO52bFaysJVhxpoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028248;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vzWTPPFPbkyAAg+n8zpJp99IXLPjZAd7WZqur3+4wR8=;
	b=P6SUE4oNBQ5cQKyJos8SzACOwY3UD8QE/e7l0zbq8u6lZoUEzZp8sEK8Mio9XsSchP/1
	 G3q1dCAiGPbVGwVbbiWAcppwLydI6jBV+FFBGy2KdSKb7TlqOEwFksMCgRSwNp4tBYGFW
	 CChOYGlyKW/oh7z/xCSUA8rgXsqeWSUVSlZBWbWQcAB0cLucCVV6OjWPUUyGluf8L888B
	 uByJrkVPCM/hMltCTBQwqz1zElhhEk8+LA0fpp8gp6WiHodJZg58dIDpZq7sdUz2STaj9
	 4kapgB/e2JIIizsA6TPENXNH/UMxxUEUmrOjZyoCsHF/uk9jtn6dWYgId1uFKTGY0NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCdqChLE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E12606A31B
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCdqChLE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5691F1F01828;
	Mon, 26 Oct 2026 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028247;
	bh=vzWTPPFPbkyAAg+n8zpJp99IXLPjZAd7WZqur3+4wR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CCdqChLEO04Lp5ZHV2XqbESSutjpNR2sCZ5HjsmXamwpaO5j1kbhF6Z7lDrxUPbRj
	 2K1aNZQkmDL11u3ChANWL196vCM5UsSLt4Vv9ADCIWYsO4v0G9HTR+4EMVs2qw+E57
	 KfjikBwbwI9joO0QgmjvihI9kFDAKcg2UyWWtOXGxM0iDh6fwyQ8kTSUwgTOs41Wt3
	 04Lkoi60viMof8t0lcSVh0XuSwPjJsLn8l6cUpJ4rXowhCrRcCDCDdcwPFsyM4+uX0
	 RTFxMZG7kuj36yS32/sMhnAp26n2e5GakwNGtWtP56/aWw3hUjYscsXxHv/X05lsLI
	 lVpwhlVv6QlmA==
Date: Mon, 26 Oct 2026 16:24:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Vignaud <tvignaud@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
 916a
Message-ID: <at9wk18uhg-H18ge@ryzen>
References: <CAHSMvrH4YRmNaw3+FnKv9-Dwf9PS6R_kNMPGEoOe2=pKwewgBA@mail.gmail.com>
 <CAHSMvrFn+gvgsfM9WPJgPCWFUy2cjR+A7-fqFtDJc=JOD9L7Jg@mail.gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSMvrFn+gvgsfM9WPJgPCWFUy2cjR+A7-fqFtDJc=JOD9L7Jg@mail.gmail.com>

On Mon, Oct 26, 2026 at 03:30:00PM +0100, Thierry Vignaud wrote:
> On Mon, Oct 26, 2026 at 3:09 PM Thierry Vignaud <tvignaud@redhat.com> wrote:
> 
> > Hi
> > This fixes https://bugzilla.kernel.org/show_bug.cgi?id=220693
> > Basically my SSD was having issues with NCQ since I got it last year.
> > I workarounded it by disabling NCQ for a year but it turns out that
> > disabling LPM fixes it w/o the huge performance hit.
> > I've seen other reports in some forums so let's fix it for all.
> > Please consider it for backporting to stable releases too.
> > Thanks
> >
> 
> I saw you submitted the 7.4 initial MR
> Is there any chance the above patch could make it into 7.4 ?

Yes, I expect Damien will queue it up and send it for 7.4-rc2.

However, your patch appears to be corrupted (it fails to apply
with git am), so I think you need to send a V2.

Make sure you generate it with git format-patch and send it out
with git send-email.


Kind regards,
Niklas
