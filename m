Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238C2253FD;
	Thu, 31 Jul 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005713; cv=none; b=j+4k53FfWcTQbKZn/uEfSCfWOJaTxUHcG6p7O7ZypFYu0BLQ3vZEe9WFCx7ofV9YQd5Zsxz5XaLFW0714r3J8klCQJGPEMJiPJP0RQl5+fYgIeowJr1K0BNXNyoRh+J1Qj4W8y/b5nwTLfFX8I2CHfU511SLdjmmUYbggc6caHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005713; c=relaxed/simple;
	bh=UMpdvHUkByqtXfhvxb6aduo1S+p5JJ/EGVXT1qX5hF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFuMuWbkoX9+dey7RMD46JbXml4zkNmRe00GxypJlA1iuhawr+/Oaoud1j5e4WKWzEDygS9EVHMAqDFnTBG8+USq1g4fr+NZ4lgNwAyvB3xu427XHmDc318fa3KOknQprRhyTYPxo3nikCRdpmgi3zvcBKZSSmVhBvCHe8IpQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEL6Z8kq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEL6Z8kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B019C4CEEF;
	Thu, 31 Jul 2025 23:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754005713;
	bh=UMpdvHUkByqtXfhvxb6aduo1S+p5JJ/EGVXT1qX5hF0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEL6Z8kqalNYsh/DzoJkQ154EPpBfiWtDPX7+GK6C+PTv2bAdutWnjOoN2ZKvhXBd
	 N9eG3TVc5ZQhG25/A91obzWdhxIZ/MmhaOQsNoWw8hxvfcoKJgCFh+sIYTLKgsT2rV
	 fcbgaX+OrvS7jXNCLs6jVKQ3rKBFsjao18IqTJjxJhS1ocXO3tRIVc+jt8F001W7/S
	 vIbxayaMkuIqRHRPh8+10oPwQPDcNbBKDShhvjqzE4hvHXsctg0sIuli6Yy++YOh75
	 sXBqnwQQi/+NoZKZyXH4zNkdmN0qyjKXJYljKgGfZitCZRybdXB+suOwb9WDm/RUY8
	 /KAfzmlQR17Hg==
Message-ID: <ef95e438-6a4f-418e-8729-0fa81cce8448@kernel.org>
Date: Fri, 1 Aug 2025 08:48:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next][V2] ata: pata_pdc2027x: Remove space before newline
 and abbreviations
To: Colin Ian King <colin.i.king@gmail.com>, Niklas Cassel
 <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250731080203.2119000-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250731080203.2119000-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/25 17:02, Colin Ian King wrote:
> There is a extraneous space before a newline in handful of ata_port_dbg
> messages. Remove the spaces. Capitalize pio, udma, mdma.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied this patch and your 2 other patches too. Thanks.

Note: next time, when you have multiple patches that are related, please send a
patch series with a cover letter.

-- 
Damien Le Moal
Western Digital Research
