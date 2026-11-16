Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.13.36.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819429;
	b=l6jlFMgEDZa8Z9jUwm/IAlLva/bNIhk/RBgAn7MdaJz7laeDA7YGgrzOf62Yf3p1pRvF
	 hjmfMUCe1Z1aA+gasAuLHoIuJwc2eO29Sv7Xs9xUtx8Uw/bOe6p5YGPftu08ONSEZ4X1z
	 H/BJI4Q9MOhYAcH4GdHkzA3ZJCmUVl+azgOXD489o64Xsck+0Brv3cNB0X3idGNY02DVb
	 +sY5E+Ob19VoNwarVbkGI5mYi3TaOqCX8eNQuyeBi/LmhE4hsFOW7ZzFRBLIy16pIoxvX
	 5ZnoG/SGOpjrQTqrsgxV03C/skwgyP2kZBRf/A3sGrz+nF+NbCDgT5zHAst8xwwSS5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819429;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ud/wZOswMsx2iuccBU4bAhnEskbFwy2N6+Y67mwQms4=;
	b=mSKfJ7sSNEJPd3YEj9skqCPKoLXlm61B9Gc7ZnNdNQQ5okCqxC3gXgZxQ6NCBTiCNyQI
	 UIrHs9ZJ/91ioskVlXtF/fSKtLgDREUpbYCdrmSMD+7ZgjOsGk87KzmdcVen6/QWAaEjj
	 jjAulm7hbCp5JzXG7DaRYKZQL0vTvzUChiIo61ePuQ12x6l8mtscmUqGAjt5AyakKGmep
	 LTQCz6s4pQdhKgyt9tSkJv3fAk2iafgH9szsdShhlUK4kLEZMNdhQvorCgOXCf98S09On
	 +OzCjkH1GvJfONVopbTKaZ504kYZ7DELs3x4IQwultZbkm34CegboC2tp3cZ0GzqFGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tecbeast.gmbh;
	spf=pass smtp.mailfrom=tecbeast.gmbh;
	dkim=pass header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=s2026 header.b=1o1FpSrr;
	dkim=pass header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=ed25519-sha256 header.s=e2026 header.b="onGMa/EW";
	arc=none smtp.remote-ip=49.13.36.206
Received: from smtp.tecbeast.gmbh (smtp.tecbeast.gmbh [49.13.36.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B51606A323
	for <linux-ide@vger.kernel.org>; Mon, 16 Nov 2026 08:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B51606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecbeast.gmbh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=rsa-sha256 header.s=s2026 header.b=1o1FpSrr;
	dkim=pass header.d=tecbeast.gmbh header.i=@tecbeast.gmbh header.a=ed25519-sha256 header.s=e2026 header.b=onGMa/EW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecbeast.gmbh;
	s=s2026; t=1794819427;
	bh=vAdsp2QU/cu34l0JlBm75Ul+6U2AyY7ZuFqMo8eMYDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=1o1FpSrrTDbGKRZF5gdSn+IKJtVTekzsEO47obISrlbICWmzsA6/2LrzERL9N84Tl
	 55bJyyMgUXgvG31HjTL55bi7eLmPBjh0KllUOMQ+c0dgFTs9ErwnGiYM40XnFscvYb
	 zMxMr9XqeXDTWpXirI56hPUHQRy7g1fc0aJ9zNO9lRGw34uwX+JZ0fJe+8vvCcOFoY
	 GLCUKUtdYTZELDX0wWIsNaKLprGrFFB5tajnjKtOPG9VoIsDkmOeKN6AfFqf2sCZ7c
	 dll7HsTHM79/m9itdz85qkHHWPss0JVF0tZ222wwSUunrf5A9fpVU4XGSsZdX0YH0E
	 1phglOtXGKCxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=tecbeast.gmbh;
	s=e2026; t=1794819427;
	bh=vAdsp2QU/cu34l0JlBm75Ul+6U2AyY7ZuFqMo8eMYDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=onGMa/EW4cvuqpXc524cUN6wwiIDQdri1WzaFeO0Czc7GYfGz08WspokJRdgozx9S
	 zgiZhQ5zkufqfnRILZ/BA==
Received: from [192.168.2.10] (unknown [91.106.186.171])
	by smtp.tecbeast.gmbh (Postfix) with ESMTPSA id 4209911F855;
	Mon, 16 Nov 2026 08:57:05 +0000 (UTC)
Message-ID: <7b9d212c-6cc2-4211-ad1c-1b72e7948d2b@tecbeast.gmbh>
Date: Mon, 16 Nov 2026 09:57:05 +0100
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add NO_NCQ_TRIM quirk for Samsung PM893
 (MZ7L3)
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
References: <20261109134541.3766394-1-tobias.kriebisch@tecbeast.gmbh>
 <avHfKaY-skamodEr@ryzen> <71332274-ae9d-4d2d-bbc6-22c559102c4c@tecbeast.gmbh>
 <avL2GHf5tXhiXmPb@ryzen>
From: Tobias Kriebisch <tobias.kriebisch@tecbeast.gmbh>
In-Reply-To: <avL2GHf5tXhiXmPb@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Niklas,

On Tue, Nov 10, 2026 at 11:46:48AM +0100, Niklas Cassel wrote:
 > On Tue, Nov 10, 2026 at 09:19:58AM +0100, Tobias Kriebisch wrote:
 > > The three drives hold a ZFS pool on a production server. OpenZFS does
 > > not support 7.4 yet (the latest release supports up to 6.19), so I
 > > cannot run 7.4-rc2 on that machine, and I don't have a spare machine
 > > with this drive and controller.

A correction first: OpenZFS 2.4.4 supports up to 7.2, not 6.19 as I
wrote above. So I tested with 7.2.14 instead of 6.19.

 > I think it is reasonable to accept quirk(s) for this device if you test
 > with 6.19 and actually verify that the patch solves your problem.

I could not reproduce the problem on 7.2.14, so please drop this patch.

This is also why the testing differs from what I offered in my last
mail. The plan was to test noncqtrim and nolpm separately on 7.2 and
then boot a kernel with only the needed quirks. But the first step,
7.2.14 without any libata.force at all, was already clean.

Setup, unchanged from v1: three SAMSUNG MZ7L37T6HBLA-00A07 (firmware
JXTC304Q) on the AMD 600 Series chipset AHCI controller (1022:43f6).
Each kernel was booted without any libata.force parameter, and a full
zpool trim was run over the pool while checking the kernel log for ATA
errors.

On 7.2.14, the drives report "Features: Trust NCQ-sndrcv", no quirk
applies to them, and the link power management policy is
med_power_with_dipm. Two full trims (about 16 minutes each) completed
without a single ATA error, and the boot before them was clean as well.

On 6.18.63, with the same settings, about 45 seconds after boot, before
the trim was started:

   ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
   ata3.00: irq_stat 0x40000001
   ata3.00: failed command: FLUSH CACHE EXT
   ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 25
   ata3.00: status: { DRDY ERR }
   ata3.00: error: { ABRT }
   ata3.00: revalidation failed (errno=-2)
   ata3: hard resetting link

and 16 seconds into the trim:

   ata2.00: exception Emask 0x0 SAct 0x800000 SErr 0x0 action 0x6 frozen
   ata2.00: failed command: READ FPDMA QUEUED
   ata2.00: cmd 60/20:b8:d8:bd:a0/00:00:53:03:00/40 tag 23 ncq dma 16384 in
   ata2.00: status: { DRDY }
   ata2: hard resetting link

So the problem still exists on 6.18, but something between 6.18 and 7.2
appears to have fixed it for this drive and controller.

Thank you for the review, and for pushing me to test on a recent kernel.

Kind regards,
Tobias

On 11/10/26 11:46, Niklas Cassel wrote:
> Hello Tobias,
>
> On Tue, Nov 10, 2026 at 09:19:58AM +0100, Tobias Kriebisch wrote:
>> On Mon, Nov 09, 2026 at 03:56:41PM +0100, Niklas Cassel wrote:
>>> Please boot the latest kernel, 7.4-rc2, and verify that the problem still
>>> exists.
>> The three drives hold a ZFS pool on a production server. OpenZFS does
>> not support 7.4 yet (the latest release supports up to 6.19), so I
>> cannot run 7.4-rc2 on that machine, and I don't have a spare machine
>> with this drive and controller.
>>
>> Would results from the newest kernel that a released OpenZFS supports
>> be acceptable? On that kernel I can test noncqtrim and nolpm separately,
>> and then boot a kernel with only the needed quirks and no libata.force.
> Normally, any problem where OpenZFS is involved is ignored, because the
> CDDL license is incompatible with the GPL...
>
>
>>> If the problem still exist on the latest kernel, apply the minimal set of
>>> quirks needed to fix the problem.
>> Understood, the v2 will only contain the quirks that are actually needed.
>>
>>> And yes, build and boot a kernel with your patch to verify that the
>> problem
>>> is actually solved.
>> If testing on 6.19 is helpful here, I will build and boot 6.19 with the
>> patch, verify that the problem is solved, and send a v2 with the results.
> ... however, since it seems like almost all Samsung drives already have:
>
> ATA_QUIRK_ZERO_AFTER_TRIM and ATA_QUIRK_NO_NCQ_TRIM
>
> (ATA_QUIRK_ZERO_AFTER_TRIM is actually a whitelist, saying that the data
> after trim is guaranteed to be zero, so this one tells the upper layers
> about the FW behavior, so that it can use the most optimal commands.)
>
> I think it is reasonable to accept quirk(s) for this device if you test
> with 6.19 and actually verify that the patch solves your problem.
>
>
> Kind regards,
> Niklas
-- 
logo

	
profile image
Tobias Kriebisch
Gesellschafter/Geschäftsführer
Email: tobias.kriebisch@tecbeast.gmbh
Tel: +49 4508 21099 83
Mobile: +49 0170 604 9778
Website: https://tecbeast.com
Adresse: Grüner Weg 3, 23628 Krummesse

