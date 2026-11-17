Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920852;
	b=GjJ3+De6PQoYtgOJmx5jzxW6orliLIf4SgdAXH2JnjKtfK+kmTqLavq5uZ8DHqsRdz8f
	 L7JL9Lgc2kPW3XtG/HDHh9peiqA3QbXwaLUUEqcYYua/2zdZsfBnwqa6pKYO10iqhO7cD
	 Rzpn1ne0aEWVm8sLSAGg0eiUywemkppCH/7FH5pIOYfafzb2qkCMBXkQPhV4H05T7jdP+
	 ng9jE2Q7XZoX5VZO4K5JDFh4qQcvf/n2252dMVsIQEiBWsXf5EKhrkx1zccLhKhmiLxgm
	 sLXcCNRVZiOodQAdMwxNwK7QIhcWLUotzo9uAfd9zTDbXnQI/AdoJP483XQJXLQfd/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920852;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zUlD2LCHXnnZ6xVTG2mz7NEmuxcgyi4E3SSuhiRPK+g=;
	b=NNoNevqVTLkoRCOnsJaUKyHso08Yr2pnbote3L8MjRohNqQDp8Ne0fShau8YM1uH52MV
	 Yr0/UIicGIWmYMgu9X4ZAfZJwiHuIefTKrEpYDlfgRNkDIEbxBMOn3ymoh1NtOuzGGnUg
	 FMapSMZ0NlXZJb1Dvew5YcHzvb2pU8Ny4m08JWqoQExdkbjWCtYXI6kqf+/g9b6K9pgk5
	 F49+AzDkBqMw3l8URkJxTuUPGqEx+pN/0xb/QGuPIyQllZ8g/cAgTTypAXw//GafTP3Ht
	 pwRrie2URLvjB4d/feZJANhylLuFRotpHqnELXwJ5jRqJ15I9byB8bH3OE68/R6J9Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D39wCsiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07F60A3817
	for <linux-ide@vger.kernel.org>; Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D39wCsiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2469F1F000CB;
	Tue, 17 Nov 2026 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920852;
	bh=zUlD2LCHXnnZ6xVTG2mz7NEmuxcgyi4E3SSuhiRPK+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D39wCsiH0r0DAhanapZF0RvserbjN1i9Z83UGXSlxWKywnFjqdKOWQn6Y3b6sypmZ
	 sHz8bCEBDYIoQjc7HFZi3IMkjm4ILp8dcSomwiabLc0E0zonNJ7QMfwKTV/1N5okYr
	 P45dbGL88TB4fJLglGj+JVxJYICWAVelXY7woB6YPwrNhYvRhT5/NLhdRaR7glFjKK
	 HQEWfUTFSDJckQyACvqaRG72cw7QMvRCOyfELDPewgIerVqyUwkp33i6UpdvYyogPw
	 dQwviUr2bRFrvJDZU646nkKMSAtjyyvYdN2Xn1tFRhiIUo0IT4tKFYp9oCwFJKMIxW
	 s5df9Z2KyRopw==
Message-ID: <9d63ded7-c5a9-4bd0-9e3a-7dcb6579f900@kernel.org>
Date: Tue, 17 Nov 2026 05:07:29 -0800
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
Subject: Re: [PATCH] ata: libata-core: remove two WDC BROKEN_HPA quirks that
 never match
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org
References: <20261117130238.3472718-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261117130238.3472718-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 05:02, Niklas Cassel wrote:
> The second field of a __ata_dev_quirks[] entry is matched against the
> firmware revision of the device, which ata_dev_quirks() reads into a
> buffer of ATA_ID_FW_REV_LEN (8) characters. The ATA_QUIRK_BROKEN_HPA
> entries for "WDC WD3200JD-00KLB0" and "WDC WD2500JD-00HBB0" instead
> contain "WD-WCAMR1130137" and "WD-WMAL71490727", which look like drive
> serial numbers. Without wildcards, these 15 character patterns can never
> match a firmware revision, so the two entries have not applied to any
> drive since they were added in commit 16c55b038033 ("libata: implement
> BROKEN_HPA horkage and apply it to affected drives").
> 
> Remove them. The quirks applied to all drives are unchanged: these
> models keep getting their quirks from the "WDC WD2500JD-*" and
> "WDC WD3200JD-*" entries.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
