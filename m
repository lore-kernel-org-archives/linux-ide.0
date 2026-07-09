Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA726A1C4;
	Thu,  9 Jul 2026 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602682; cv=none; b=Cb+lEEUub6c4DFUhvflyjo/3rpU21dXfYNr3Ixfikkw9cCqEFPEdH5h0jp5G3ycFPNy+1QnKz+hS4zLuJH2Y6Tjn+pzCVdo5C07lHcPWKfZIH49Ht2a5obJaJ2owqwxUcs0o/dvQ5vb+Z+ewpufBv4mfUkT4H9NdBfM68Qm2ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602682; c=relaxed/simple;
	bh=pElath9wgKST/JapIWzhFNnrA0P5yzTL1xn/hS0Z73w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TYQT30VzKOKsEHQl4wLXEFluHyoBP+mc/PZVR8vLS/MKs0P+FjTDbwkpdWCPEi48oEH4Ad5HYBRmrzF3ygdloC8u9hrU3HP3Oa3vSyOjVinloSNKrjelA/lZhlt4tVrt38/sVJQsA6HpvAyK7yVyHM6YaRcSOGDf8/HHHrcGJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwGRUdO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwGRUdO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC211F000E9;
	Thu,  9 Jul 2026 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783602679;
	bh=pElath9wgKST/JapIWzhFNnrA0P5yzTL1xn/hS0Z73w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=mwGRUdO4Hsqh9eeZ/RTEtYWt65Ez8CLlCKtnuKyGp/R1T3wOYMal1iYpcst48eYK5
	 gDU+MlL7VntKofZYydzgvv1HqZ7vy4INNXC+do3pEIq+Mi+QglIdafwmoGo0f5cAWb
	 KkLwUlKGDfIg1G5lf/4cPRHw3Apho7Vlk6TgZYs4adCrSoTh8ZI9ZLYDfSQ1ajsUfY
	 hR/Bv4vsvBBM1D+Vdl3erBGyI5SWEaRP66G7CDkak9s2PWLXuSKg94H2faSkuYRTn6
	 7Lg+u+GWaFjtKkqoeft8hmbHRpCd0YCiyoek6jfYozVhy7iJfsRtAd7Os8WonFEIsC
	 j7ZnCQmDZ35Iw==
Date: Thu, 09 Jul 2026 15:11:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Karuna Ramkumar <rkaruna@google.com>, Damien Le Moal <dlemoal@kernel.org>
CC: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org,
 Igor Pylypiv <ipylypiv@google.com>, TJ Adams <tadamsjr@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_ata=3A_libata-scsi=3A_limit_sim?=
 =?US-ASCII?Q?ulated_SCSI_command_copy_to_response_length?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
References: <20260702020142.3399851-1-rkaruna@google.com> <20260702021411.B01331F000E9@smtp.kernel.org> <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org> <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com> <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org> <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
Message-ID: <0E78BE5F-B4EE-460A-A6D5-F0CE47BFC7DF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 9 July 2026 05:34:14 CEST, Karuna Ramkumar <rkaruna@google=2Ecom> wrote:
>On Mon, Jul 6, 2026 at 6:10=E2=80=AFPM Damien Le Moal <dlemoal@kernel=2Eo=
rg> wrote:
>>
>> On 7/7/26 08:10, Karuna Ramkumar wrote:
>> > Before I start working on this, I would love to hear your feedback on=
:
>> > 1=2E Whether you think this API update (passing `rbuf_len` down to al=
l
>> > actors and helper functions) is the right approach, or if you prefer
>> > simpler, and more localized checks elsewhere=2E
>>
>> I do not think it is necessary at all because rbuf is statically declar=
ed:
>>
>> static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
>>
>> So the buffer address and maximum size is known to all functions using =
it=2E
>>
>> > 2=2E What would be the best way to test all these simulated command
>> > paths to ensure the fix is verified appropriately?
>>
>> Most functions for emulated commands generate only a very small amount =
of data,
>> far below ATA_SCSI_RBUF_SIZE=2E So I would suggest that we simply add c=
hecks to
>> the functions which may potentially exceed that=2E Off the top of my he=
ad, I do
>> not know if we have any, but we should just check=2E
>>
>> Note that ideally, we should have each function allocate their own loca=
l buffer
>> to handle the translation=2E But this is right now a little hard to do =
because
>> these translation/emulation functions are called with the port locked, =
so we
>> would have a memory allocation for a potentially large-ish buffer under=
 a spin
>> lock, which means no reclaim/no wait allocation, and thus potential for=
 failure
>> which we do not have right now=2E A proper/ideal fix would need to drop
>> ata_scsi_rbuf, have some helpers for managing the internal buffer and r=
edesign
>> the submission path to not have the port locked until the translation i=
s
>> actually generated=2E That is all more work and more changes=2E
>>
>> So as a first step, let's check the emulation function if any of them c=
an exceed
>> ATA_SCSI_RBUF_SIZE in size, fail them with internal target failure=2E
>
>Hi Damien,
>
>I went through all the SCSI actor functions in libata-scsi=2Ec and
>calculated their maximum size consumption=2E
>
>As you mentioned, most command emulations triggered via actor
>callbacks write a fixed or small amount of payload, and are well
>within the 2048 byte limit of `ata_scsi_rbuf`=2E
>
>There are two functions that can potentially overflow though:
>
>1=2E ata_scsiop_inq_b9: Writes 64 + nr_cpr * 32 bytes=2E If nr_cpr crosse=
s
>62, then this can cause an overflow
>2=2E ata_format_dsm_trim_descr: Writes trmax * 8 bytes=2E If trmax > 2048
>/ 8, then this can cause an overflow too=2E
>


Please note that ata_format_dsm_trim_descr()
was changed recently, on libata for-7=2E3 branch:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/libata/linux=2Egit/log=
/?h=3Dfor-7=2E3

I don't think that this function can overflow anymore=2E


Kind regards,
Niklas
