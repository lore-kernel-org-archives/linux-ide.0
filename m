Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503341F91E3;
	Thu,  9 Jul 2026 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575959; cv=none; b=HJnfoH2C5R4nBsnYhMiab8fY+pTwmE7mPHlzzvJn/GYalpb+w4mnrGjTEy0WXXTnOERZMmuz+pLTqJCrADqT8QBy8ymS9LQCwmYCgKbvo6gRJZD5/IXgjJHJYpb6towS7u08kQqK7wLn4LF/JqkLmclYmeBnAnmGwRyBuExxaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575959; c=relaxed/simple;
	bh=GL44HKmWNJmSI6y6CSgv0bIkhN9Fn81KRTXol7LrnMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TctQblh5TT35+OTt0fyZWK9NNDDFamJqhyNd8ETPnesUD0aI4AiAsZdSXUv1oe5mOeAGazdSi7ieTgIcBnwLtYLlL/jsBF2hF6TRF9y34FEsJ43zM84Kb0A84Frj7mUBBF0ouRXoBm8vJrWaAf+0Mzu/cduiG1R1An6Lz0zDtLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvggwoS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvggwoS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DD71F00A3D;
	Thu,  9 Jul 2026 05:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783575958;
	bh=WrgKbJOBZ/63xZ9J1vrIJ2OeB0zX2RK/abEGXlXC8GM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SvggwoS5uAQ6RcIGzLh30/h/RccKKysJQ3rgi0Kuhl++afZi/ke3EnNj6XBuzm4Bh
	 JevVBeND+vRxYHOUs3+NhffYwyBDwpYjQylvbeYDnyQL3TKgK1+1B4U1D1muQ2YJJY
	 7CN9i9W5sEEeOrowRMQSD64JRgjiGWojmpsDn9c7ruCupep4YCCI2JE5RgwBnBo1Cd
	 2WX7hH4GlXX+5TM31IsqXWR8EK2DViCdEiEFGHuPMzAnPucFVjU2NbkzYPhFMqYVNs
	 S+2k0CWQW0XQk8CZIL2i6gybzl0F/CBnlnVRsua9W67HEv4EA6ZNCTZaZYbuQLcBOg
	 L/U4C8Mt3gHhQ==
Message-ID: <9381e503-6668-4afa-a514-a1926d790046@kernel.org>
Date: Thu, 9 Jul 2026 14:45:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Karuna Ramkumar <rkaruna@google.com>
Cc: sashiko-reviews@lists.linux.dev, cassel@kernel.org,
 linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 TJ Adams <tadamsjr@google.com>
References: <20260702020142.3399851-1-rkaruna@google.com>
 <20260702021411.B01331F000E9@smtp.kernel.org>
 <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org>
 <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
 <49cb57c1-d7d6-4f30-b628-72c083981da6@kernel.org>
 <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAD50Xqra-_2CnJdGPJtWeOZT-Ne4wRRcQEL+6uy1--jPRYwACQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/26 12:34, Karuna Ramkumar wrote:
> Hi Damien,
> 
> I went through all the SCSI actor functions in libata-scsi.c and
> calculated their maximum size consumption.
> 
> As you mentioned, most command emulations triggered via actor
> callbacks write a fixed or small amount of payload, and are well
> within the 2048 byte limit of `ata_scsi_rbuf`.
> 
> There are two functions that can potentially overflow though:
> 
> 1. ata_scsiop_inq_b9: Writes 64 + nr_cpr * 32 bytes. If nr_cpr crosses
> 62, then this can cause an overflow
> 2. ata_format_dsm_trim_descr: Writes trmax * 8 bytes. If trmax > 2048
> / 8, then this can cause an overflow too.
> 
> I will prepare a patch to add bounds checks to these two functions and
> send it over for review. Please let me know if you have any
> suggestions/concerns.

Sounds good. Thanks.

-- 
Damien Le Moal
Western Digital Research
