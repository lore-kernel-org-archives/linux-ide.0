Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A599F388E62
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755416; cv=none; b=bvkaZStn1HI2wVoU4RGBJirQOQpVBPSKMX9EfMZSsjzTnxae5qZG1lowy6H0YRmLXSfwsehx8b7Vr9B3WSkC+x/osxHIRv/h8H5mPuhkd11GgRcniDFX8MyFpU/tWd5GvV2ayUFLuuOXNn/D6FRkIIpK0APPG0jYdH2DrGyxvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755416; c=relaxed/simple;
	bh=F//gvl7vwE06ijkZsFIisdWW8Iu1m8HN5mwELOX9EzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukKCxOYKlDO9a1AqEzSjN01MWwjUCFGRbcymiyl9/0DU2cJD+cKZurU3m73+bKeA+amR449B7hcuGXewo9fxz8QQOh9NRfQfGJOCsmQztz3EsX78BH16n41Tdofce6mTBhtG7Iw1enlvCcwBPfT89pkoQHAOIOY/q7nt4+uYebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=EcyoyyQ/; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="EcyoyyQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778755413; bh=F//gvl7vwE06ijkZsFIisdWW8Iu1m8HN5mwELOX9EzE=;
	h=Subject:To:Cc:References:From:In-Reply-To;
	b=EcyoyyQ/lojQjrUtsMsXrCEVR2/OljelxzxO30USuFXjca6N7XjzIhThHbTbwicws
	 9iMWAnoQA5GR5a5J7Gv/q1W8Yb9bX2b+TweFGi9uN4luWEeOGtTbg8giIKvLy1i5QW
	 z9sGukn3ssQPeymKSlycZ2eYJlXjPAHpiFtg+8HJPXCzXRscVaYIy8Dxch6Zz4OcI0
	 3maPCvKXlMNwKELzm6O4GA83BT8HZ3/ciiFEfAGDnxL5ElASIrMbJWK3tgZPju17+D
	 yEFaODYp7jR3uBnJI8aFB7AAVT+Jth3VLfk5WNXpj6SPgBf4B7DSifr7jeUkj2fA2T
	 d7QFQrCowKK5A==
Message-ID: <87402a36-57ef-40a5-8668-988f58e31ca9@tkel.ly>
Date: Thu, 14 May 2026 03:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/4] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
References: <20260514073858.1175072-6-cassel@kernel.org>
Content-Language: en-US
From: Tommy Kelly <linux@tkel.ly>
In-Reply-To: <20260514073858.1175072-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 00:38, Niklas Cassel wrote:
> Changes since v4:
> -Fix ATA_DEFER_LINK_EXCL to use the correct goto label. While refactoring,
>  I accidentally used the wrong label goto defer_qc instead of goto free_qc,
>  which of course broke PMP CBS in v4.
> 

Good news!

Tested with Linux v7.1-rc3 + v5 patch series.

Both FBS + CBS worked fine, no errors/warnings or visible issues.

Thanks!
- Tommy
