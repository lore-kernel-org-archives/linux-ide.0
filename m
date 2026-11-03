Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740930;
	b=OwRVj0E8ppGHA4PyCWOEmqC0bbLYJ7phLy7Yk9CGe4AJpwMokxfO/uSWUrTrQNwgZhWd
	 45Nr8v40A9BvZNtdyFhD8zXUEmavpOs6ZnvXLcF2cGmeokJfzYQfkCm2DP10Dj5MCN0G4
	 d6EeE0DklE7owu/dhMsaYCGTKM9lkemAdzZJTebSNaYulgepxpp2AmAE9TOcmoMsIME66
	 pdBoUOY0D8pzeGwCQO0Vb0JDOu1WexK5Bj3m0xzNrROyAWxxmXt5O30slEROgE4SLi/DZ
	 ScAT5Tggcipo9R5mpY9WDFbWkdgBUGB7Esxk3YC79actcrr0vN3ygDx0YRC+eMOmksQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740930;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Z8e1HnUg9iMsADgE9unttqDA2pOjy4iXtj9giCbUdD4=;
	b=eTsXjE18GE2Vl3dkGkQVgh8dsX63J+b6TulmMUh1wltnw/PQ35Kbje23VgftNh228psm
	 NBYIRJLlZNCRvvE1ySAGrOdmBE106XsiRaPDLzdmTG2z11XHfPtxoQ5ENPTf/3Qm77NLT
	 bo3zxPnr6J3GPa9ky7hq2OxyTh1hZc5ajcxqseHo0SH89Mao3NEjuQA6OtIwJnEL+2zuR
	 wZWUUJtpaTOc3+rqSXcgZOxZ/K9xLxQ3/Fi4K9TVg2gWWhjRl8fRsJFm1h+DrS3DCObCY
	 nuC+vd0kD5aRTiE07BHN+WY3e0JnLNOeKJXF9rbIEOgehFe3jvaeGbrIy6he2XgE5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7sQw2sI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA0606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J7sQw2sI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FDF1F000C1;
	Tue,  3 Nov 2026 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740930;
	bh=Z8e1HnUg9iMsADgE9unttqDA2pOjy4iXtj9giCbUdD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J7sQw2sI+XLpwXCvJTn2mI7VkhYKje6zrjA2XYiAHR/p3gyxJqhE1CYF8vTEiASd2
	 P/jKURuHFHmGkh+MJiBWwlzC3CnN/jbeifKY//HIYcTwAJtK7QS0+S6QT2XTWC9iJ2
	 tq5izvGkcqilPBCBT00QObMvY8zCzoVDb3ZdNzglYJgKGgqCETlaSi+TafRyE5D6CQ
	 4DoLG38/RJZl6YEJDHDyYgkoM+Sps0aD+3rabMZwvI/EklgDT4BWSBWH1Vy2/RqBW6
	 3nEI0rb7kfOoqfaXu0YXbmSyCljsOxP7yR48SkFikSthQ3A5eZH/+0dUG0Hv1an2Gw
	 W8p8h8+EzXCDA==
Message-ID: <1af3f18a-5595-4591-8fbc-e5e4d889b036@kernel.org>
Date: Wed, 4 Nov 2026 06:22:08 +0900
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
Subject: Re: [PATCH 3/8] ata: libata-scsi: reject MODE SELECT mode pages with
 a wrong SPF bit
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-13-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-13-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> ata_scsi_mode_select_xlat() accepts the caching and control mode pages
> both in page_0 format and in sub_page format with SUBPAGE CODE 00h.
> 
> However, SAT-2 and later versions of SAT define the SPF bit of the
> Caching mode page and of the Control mode page as not changeable and
> set to zero (see SAT-6, 10.4.9 and 10.4.6), and SPC-7 (6.12, MODE
> SELECT(10) command) requires the device server to terminate a MODE
> SELECT command with INVALID FIELD IN PARAMETER LIST if the application
> client sets any field that is reported as not changeable to a value
> other than its current value.
> 
> Reject a mode page with the SPF bit set to one and SUBPAGE CODE 00h,
> with the FIELD POINTER set to the byte containing the SPF bit. The only
> mode page with the SPF bit set to one that remains accepted is the ATA
> Feature Control mode page (control mode page, sub-page f2h), for which
> SAT-6 (12.3.4) requires the SPF bit to be set to one. The opposite case
> does not need a check: a mode page in page_0 format always has subpage
> code 00h, so it can never be the ATA Feature Control mode page.
> 
> This also allows the mode page handlers to rely on the format of their
> mode page, which a later patch will make use of.
> 
> Fixes: 1b26d29ccd59 ("[libata] scsi: implement MODE SELECT command")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d7923bc664d6..7b0a02903fda 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4629,6 +4629,16 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
>  			goto invalid_param_len;
>  
>  		spg = p[1];
> +		/*
> +		 * Mode pages with subpage code 00h use the page_0 format: SAT
> +		 * defines the SPF bit of the Caching and Control mode pages,
> +		 * for subpage code 00h, as not changeable and set to zero.
> +		 */
> +		if (!spg) {
> +			fp = hdr_len + bd_len;
> +			goto invalid_param;
> +		}

The comment block in-between the assignment and test is odd. Can you move the
assignment right before the if, after the comment block? That makes the code a
lot prettier :)

> +
>  		pg_len = get_unaligned_be16(&p[2]);
>  		p += 4;
>  		len -= 4;


-- 
Damien Le Moal
Western Digital Research
