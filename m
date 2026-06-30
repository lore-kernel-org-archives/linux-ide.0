Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525022EBBAF;
	Tue, 30 Jun 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814019; cv=none; b=BIaH5z28LVSIM/LfoapLdB6Q98vLC982/BLWVcW8LRMMJ3+XB+VS1PXkNLHt1U7KLKgdMSScmnzh8vLskCFaQzAmyDhR8kUXzKWCLetD3x0uhj1pr9UPk71fOffhyg7tu4FByFMu3k6YA6e+GmAw27Pite3nJ854iyDAJp+rb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814019; c=relaxed/simple;
	bh=SCQEbFzYo6u50oAtDRaPbS4UOr651VpEyAEWHaAENzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN+ZLPC7kUfhdIYndQW/UimAxIybzyjN8srhwpASrJ5xZ7Hi0CHX2smF9fSvbYaXNfPrRogc1EH4f3z2sxUHAqoRM8rtEWI9qB4gV/1skMi4WkWjmXbHLf8cZ3OGKcTu7ljLSfQRR1OfHOorTgpnDsnBupt5pk6JW2ARuyqmjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONbQdOFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONbQdOFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDC1F00A3A;
	Tue, 30 Jun 2026 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814018;
	bh=us4aIASLZHd5M2CRTlcBbVHgVaDLy5Akn5NBkDFGfTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ONbQdOFSVcPkX8gbWkCG/GvKPDTmyqwk6DKtcAVqCE6Ph0kAxXfxhV+zwAVX7CJHO
	 jN6w9H+XEDISeWo0gaw8R9j7mS/TPxgEXeyUWuGvVBRhgYbxmL4jkmjiSRXWLc/78L
	 58W8kK/8deAwgqPgb3Xyw2/P4qJE3Mc1QLdp2QUkyQAmeW6KvnGgNeRkwsyeHCxtJD
	 HDAcJzhQVj5GAgEFFWEgP7P+mKh8LAK0NVtqFjOAnxU95ywltLCWqxgkXy5UxTNW/A
	 Os1La6pxMHxEeY6IlCrCTCvKJrQ4JNIMWI+wWBaY4+zT2b2gbk3WScMRIC0SaxO/bb
	 YrcCD+20kjTsA==
Message-ID: <d691ff29-6712-478f-90f0-467394d6e84e@kernel.org>
Date: Tue, 30 Jun 2026 19:06:55 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: sata_dwc_460ex: use platform_get_irq()
To: Niklas Cassel <cassel@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-ide@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20260628230310.1214770-1-rosenp@gmail.com>
 <akNzEGgiYC5V3rtc@ryzen> <9327f32a-5037-477c-80dc-f99b97ed9740@kernel.org>
 <DF85BCA7-B344-4AD6-8F6B-22CB3A3DF823@kernel.org>
 <CAKxU2N8uWY3k3nHTmdxEn86zEZ_hGJgyPvHWuHt=zRaPk-29kg@mail.gmail.com>
 <CAKxU2N_2N0YWBrF1k82qXCYYyvZxa26GYi09xiyKbBAtUoC_mA@mail.gmail.com>
 <743a2748-a458-4e65-a1d2-f54a6657e7a6@kernel.org> <akOHEDdu3zw9Uhph@ryzen>
 <2865750f-9bab-47d8-b4c9-9cf1cbef7834@kernel.org> <akOSrMbpFIO_VLul@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <akOSrMbpFIO_VLul@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 18:55, Niklas Cassel wrote:
> Sure, we could create a dummy / stub for that function, but to be honest,
> I think my earlier suggestion of just using dev->of_node directly within
> the ifdef, and drop the local np variable would be the smallest change.

Yes. But I am not against replacing that ifdef with IS_ENABLED().
That's prettier :)

-- 
Damien Le Moal
Western Digital Research
