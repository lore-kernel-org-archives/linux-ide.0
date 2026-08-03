Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10398382F08
	for <linux-ide@vger.kernel.org>; Mon,  3 Aug 2026 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798939; cv=none; b=Kwbe9bFRIA2hlzOau9Vmvs9VetsIltKWJQijH1ZgTXhKRdFI4SwVnKZZDQcItdQyMCWaVds5lJoO8Y9d9fegGWCOKI0I+dwibLuhiVDqial8qxThvYFizRq1sUF1RYD9n2vNYWvrB64yw5aUjSxUU84b/ySzyY+rP7SDaNhv7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798939; c=relaxed/simple;
	bh=JRX2HX1pdvmStXT+Wc7ZJP5aqA4e5LsGgdG9vQjJmu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQUvVHIq2wUdKTTurhLgctOSAM6lIG0dMPISZqhKJWdZqAkV9KoDvCzRRb6Jg7uQKKQk9fikDCAUncXkW91yESbERQOdE18l8hk792Sekf2Rsw8zCCfaNVpRgPNq0ktTmAIe+uBNBl9HTNk0KalhhNR64nag5T6zv7I/UZSinfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY9JmLi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY9JmLi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C6C1F000E9;
	Mon,  3 Aug 2026 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785798935;
	bh=CxTlOL1+ejMThNS7dvCgErx0IU4hDvmOUt67nXhmOs0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TY9JmLi/iXlNpy6qVRkUDQxKS0OwPA85hSmfpMPVU24tMSS+lGRFnIVOriIOndHeW
	 zUWJ80tiNKwebdMTI721CoPCBZxvd44JIHFEbSaDBFDUpZXpa894befEHg4XJByrCS
	 JhECaWsAKdG/z23Mwv1wU1pmBSoHGLxhW/wJ+3N8he0oNsFritV1SHD32rfbbVTsrg
	 G+fJm6lALYzdgH8LBJmWCTzfplxUQZr6u5MtZhLc5KNarVp01hltdrQQ6IyViAY8Jj
	 ZbaWQpvlHnoMwG00AdZ8UKJmvPxq9tiS4Tr42KEazGw2YOh14HfOPqKM/OqP4LZa7R
	 4k3bWiKD+3njg==
Message-ID: <728bf197-6774-4776-a963-5334dd99b209@kernel.org>
Date: Tue, 4 Aug 2026 08:15:33 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Disable LPM on WDC WD141KFGX-68FH9N0
To: Niklas Cassel <cassel@kernel.org>
Cc: James Turinsky <zerodata@gmail.com>, linux-ide@vger.kernel.org
References: <20260803143004.362806-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260803143004.362806-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 23:30, Niklas Cassel wrote:
> According to a user report, WDC WD141KFGX-68FH9N0 has problems with LPM.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220693
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to for-7.2-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
