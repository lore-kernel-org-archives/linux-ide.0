Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099715AF6
	for <linux-ide@vger.kernel.org>; Wed, 14 May 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229889; cv=none; b=B73vWq3whQOMXfsCkJkzjPzp2vI+AJYiQtfYUpoYBCZTHaM8ZYT7XOcR/4JJRteYcbIgc2UjFPrxjW8OXKGvf5Bfh7WRdz7AXF8yRUDwO5XBBz+EztqiMNwHZpE/F5bMoFZABhdd9DygU4cYXsUL60MlrSmYzhSI0qBlPEbZuDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229889; c=relaxed/simple;
	bh=KMgWcif5X2SFGG6VKz1ABSZPt33Hm0EE5uXCO3oTLcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj4ebZpjrla9tNe53ClpccNwemm3UUOAWVhuPrIPiy1lvBgreKnz5ze3XqfYP9TLtMwcFJDzFLVjdXxSYzD6inKULI+l5VkI4HK28oDI1Mj5Aphns4EqrqIqQ/8aQ2FWwUGRKqESuApQKWmKBH8mopn/iZhMOSZTpVkCBPbRSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUScXoT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUScXoT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71EEC4CEE9;
	Wed, 14 May 2025 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747229888;
	bh=KMgWcif5X2SFGG6VKz1ABSZPt33Hm0EE5uXCO3oTLcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JUScXoT3Wx2Bk4bxAvoKo6QL1dK0JEjps/XrjLHhvLtDQ1zyNmAQTkvlQEzVTpcUa
	 pZz5nmfsgDPKrjaB4xuCon7adkREvblV1OutgQKFa6kpSDQ8vfWlsIIgD5d02KyY+t
	 XiZmzfnr/W0flf3bwKotb2tROlJ7wfyusJ1H1EI890XxLk1AnjnBpvoF1kUWBIi7J3
	 BahWLW4PBHGlwyPhXAmtfsVgP3XxXmffbOmW+2EU1jAgYLHKB8rfXGIshUxbsRKCO3
	 6QWybGdR10P9FfD1g8c3aQOoxu7vStMI0PkNZ0H9Xbqf7OtoRPRgsDwZWUDfyi1lLT
	 e0//duSd1+r1w==
Message-ID: <30ba2e36-8957-4dc0-a5d7-85ba71ad0a59@kernel.org>
Date: Wed, 14 May 2025 15:38:04 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] m68k: pata_cswarp: Add Amiga cslab ata support
To: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20250325155613.352680-1-p.pisati@gmail.com>
 <aCSBV_L-NcNX4n7G@akinoame>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aCSBV_L-NcNX4n7G@akinoame>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 13:41, Paolo Pisati wrote:
> On Tue, Mar 25, 2025 at 04:56:11PM +0100, Paolo Pisati wrote:
>> Here is a driver (and the subsequent defconfig change) for the pata/CF socket in
>> the CS-Lab Warp series of Amiga boards.
>>
>> Changes in v4:
>>  - refactor pata_cswarp_data_xfer()
>>  - ioremap WARP_OFFSET_ATA region
>>
>> Changes in v3:
>>  - suppress a comment
>>  - properly return ata_host_activate() error code
>>
>> Change in v2:
>>  - fix style, remove duplicate swap macro, driver version, etc
>>  - rework the zorro attach mechanism
>>  - remove the unnecessary zorro ids refactor
>  
> Gentle ping about this one: can i get an ACK or a NACK?

Sorry, this fell through the cracks.
This looks OK to me.

Geert,

Any comment / ack ? Or do you prefer to take these through the m68k tree ?

-- 
Damien Le Moal
Western Digital Research
