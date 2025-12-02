Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8218BC3D
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643327; cv=none; b=kqN3JqjHegAbwf69p9PQX6k63JE4abVjetUwkb2adcarVt+/UtwxTrJtzgd9/y+i9vVuRmGLDACSxcPtpy+kAwCNTg18wCzSxohVuW0Kom9ml1JQEMPLSOOqPVsoyH34uYg8JehYsROoTb2j6vaB7KmSv82Iml1TzNPXkSvYUYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643327; c=relaxed/simple;
	bh=iDT4th3c5GWwj2PfrlGWQzwzTRrG1xVUr+tMkwjsEFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlEFl/DhbLddZNopBHgQKz3FGbnV4mNVuzVkS88WOE/w5qgltAJqaNzuOhlbmoWkelhCwebQN6oqY17kKPcop/E2lPwawWQUjVUbYF8+QNhwTw1hBIz+JFhyUp6mpiGz9SERP9eUtANWaf6TX+4vDfgmEGtO/sWk4gZ8muzvWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4PXiaCQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4PXiaCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC86C4CEF1;
	Tue,  2 Dec 2025 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643325;
	bh=iDT4th3c5GWwj2PfrlGWQzwzTRrG1xVUr+tMkwjsEFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P4PXiaCQLfcwwNy9t2a6M3q+fA6VEVT6DaSENWxxDwqe0zpNEWaSMK86CU6Kt83Fe
	 pQVP4oxoG8wMlZje6Ctr1+HizzFniL+5PiNO0ZelxqOG396cpdzjWvwrBTEG7CxIEt
	 1i+nu9tyylcyXs6iUmIVu39syzadiXSg0XV8iZEiB4KISCZ8CFqNO0uUSrN8FmqFvp
	 fgJWSLwF/LEO+4ddmzu/uYjZkYjXmpcBIwz3bjipiX5/YkvQj1zjLyGdJ0vbiNWQ7r
	 bXnQxSLs4gT3nytrsfatZiLjgz7/3isu9eqS8yb4bdizRkLVZmg9hjEkDchd9Ieb2A
	 EACPgVa9ZMI7Q==
Message-ID: <38e6b40c-c9f0-4509-a31c-968cb5a38c0d@kernel.org>
Date: Tue, 2 Dec 2025 11:42:03 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] ata: libata: Allow more quirks
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, xxjack12xx@gmail.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20251201123501.246282-10-cassel@kernel.org>
 <20251201123501.246282-18-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251201123501.246282-18-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 21:35, Niklas Cassel wrote:
> We have currently used up 30 out of the 32-bits in the struct ata_device
> struct member quirks. Thus, it is only possible to add two more quirks.
> 
> Change the struct ata_device struct member quirks from an unsigned int to
> an u64.
> 
> Doing this core level change now, will make it easier for us now, as we
> will not need to also do core level changes once the final two bits are
> used as well.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
