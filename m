Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741017;
	b=vCIlrCExWcjhSPgj4WZTThVcC+KRVOQpEFA6/qvMRnHkj4yOIbEueXdJUsi4woYuPh51
	 pMsMB6MoKgG0n5qssZEtXqxSAJSYAZjY7C1Xmfarc4LgTshIBBYPTg+YczIqpNrwfD9u6
	 Uw8jxLeMCLhS/B3r/kyFt6ji4yAQzou6EF10d7LWDaz5ls/8pu+LcvmfivvM9dtPORjMR
	 HAJ0igY38zlelLs4VUsBOvftf+0PzN8rWqgdrpUC9Lpq+gyT1FGyST0DhRznp8cX9fQHR
	 Rf8jHVD532wOo10aKYxOLnL3u9sFYD1iUXjZlUbG8YueNTBEjYP3+TBNchvQqwqTFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741017;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CFZx0qWCtR4+5717af6FQ4kEqHOAYHOKNZFKWXHpsHw=;
	b=a3tGqrP3Dou19UkvRGni/MGL1tu6kFPMka3i845/eAKUbTUaZuSIR7x68looLWUIqKMz
	 ch7RLNRBmw0tzeUJ+3MsSdiJZR1pjMzLCkxeCGneGn0DJ8eNQyC2sW/+qmljBipkc5+qc
	 FS6t1vj7KtC2R0ayT7hZpRtZ3KXhu037jbdpdnJWFunxn3q/Etxvv2xbfTuHIQpn1gcX/
	 3yZygMrb3kY5tNYwqHdAyj3yrbcdC/TqRdZyIUOmCjTDAWO9pO7TWMJZWdnJ9nrFwGfkf
	 qh1H8MGGMk4gX+VL+vOtIf+Nguh7rj/6Cqr7GSMjyPcge2/7wE5H4LZOXwGBvvdw5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKd4tPxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CE606A337
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKd4tPxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C33B1F000C1;
	Tue,  3 Nov 2026 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741016;
	bh=CFZx0qWCtR4+5717af6FQ4kEqHOAYHOKNZFKWXHpsHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KKd4tPxAsL9nZYSS7HXQMJvBVhKOgfnsraLqD+ViWcs+ifGvSd0/Srpr0y+DHxLBL
	 0JhI8iES8qPVySU+Y6hxm8hkN80mwjeaPAzxGqM4k+yS7Cz5AAoesWA8E+rYDZ23Dy
	 DofnQAGl9LT6m5jeHP7KGS7BWc4o04jCHGCiYJRvdFhUFefaXdn9LR78XGX4GWzqAS
	 67yUFPG88Gvo9gPs2ejJi+S1G8wI4rurcGGTSgfUs7e+OTTdT/E3h31reKieWnmrtA
	 FhuDB17tyK6X9/5O7VyPcmgU9TPvTmSENIX1FaxsZ2Vswctu5YGMpVDxXBAHQ/j/Pm
	 3plIZnVq6N6vQ==
Message-ID: <dbeb6c83-6b57-4985-9c1d-bfe31b76175b@kernel.org>
Date: Wed, 4 Nov 2026 06:23:34 +0900
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
Subject: Re: [PATCH 4/8] ata: libata-scsi: fix MODE SELECT field pointer for
 unsupported subpages
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Hannes Reinecke <hare@kernel.org>
References: <20261103205448.931471-10-cassel@kernel.org>
 <20261103205448.931471-14-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261103205448.931471-14-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 05:54, Niklas Cassel wrote:
> When the mode page of a MODE SELECT parameter list has an unsupported
> SUBPAGE CODE, ata_scsi_mode_select_xlat() sets the FIELD POINTER of the
> INVALID FIELD IN PARAMETER LIST sense data to the SUBPAGE CODE byte of
> the mode page header (byte 1 of the page) if the SPF bit is set, and to
> the PAGE CODE byte (byte 0 of the page) otherwise.
> 
> However, the SPF bit is tested on p[0] after p has already been advanced
> past the mode page header, so the test reads bit 6 of the first byte of
> the mode page data instead. If the parameter list ends with the mode
> page header, it even reads the byte that follows the parameter list in
> buffer, which is not initialized when no data beyond the parameter list
> was transferred.
> 
> The test is not needed anyway: spg can only be non-zero for a mode page
> in sub_page format, i.e. with the SPF bit set, and the field in error is
> the SUBPAGE CODE. Always set the FIELD POINTER to the SUBPAGE CODE byte,
> which follows the mode parameter header, the block descriptors and the
> PAGE CODE byte.
> 
> Fixes: 7780081c1f04 ("libata-scsi: Set information sense field for invalid parameter")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
