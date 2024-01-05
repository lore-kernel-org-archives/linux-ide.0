Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AEC2C857
	for <linux-ide@vger.kernel.org>; Fri,  5 Jan 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1jJUrjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E71C433C9;
	Fri,  5 Jan 2024 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704457532;
	bh=dLuW7yru6kJXq7k1Fz60DqHQNvV+8OZCMxevtyFYvhQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K1jJUrjc8eQ2yl9zBk1TNVstWqXXxdQ5r7egnuF00aAEYiJL6HyE5JKFSHKZabckB
	 4nIjf/gBgRle8P6uvtvhU5cbyXZ/KNcJX52NHkWPIm4FnKhIDu3wPfUTKAuvEOp6No
	 drfBKe3gvQ5HasQZDZxE5ODg1qGCVAhdgDr2mFZHfGg6lIM4dhZ6JN+oOXIGyGcEc8
	 vEPiilkvVHk9zKALNquVYnc5zIbuWRfaJ4rsNvwo9JHV4CPtiW/VzTH3CZPlS04EZt
	 8Tn2HsIg5JbMeyd78K6xA5p/UrHo7BJj52McaV44fVQ380WSHC+2N/rUgU0C30tpJ8
	 q/BMzZZblnN7w==
Message-ID: <864cd267-b113-417e-82ea-c760d5e8c664@kernel.org>
Date: Fri, 5 Jan 2024 21:25:30 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] libata: don't wake sleeping disk during system
 suspend
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ide@vger.kernel.org
References: <87y1d5kxcc.fsf@vps.thesusis.net>
 <20240104223940.339290-1-phill@thesusis.net>
 <20240104223940.339290-2-phill@thesusis.net>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240104223940.339290-2-phill@thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 07:39, Phillip Susi wrote:
> When suspending the system, libata puts the drive in standby mode to
> prepare it to lose power.  If the drive is in SLEEP mode, this spins it up
> only to spin it back down again.  Don't do that.
> ---
>  drivers/ata/libata-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a2d8cc0097a8..1244da8f77e2 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2030,6 +2030,10 @@ void ata_dev_power_set_standby(struct ata_device *dev)
>  	    system_entering_hibernation())
>  		return;
>  
> +	/* no need to standby if it is alreqady sleeping */

s/alreqady/already

The comment should also be improved. It is more than a "no need" given that a
sleeping disk will not respond to any command... So something like:

	/*
	 * If the devices is in SLEEP state, issuing a STANDBY IMMEDIATE
	 * command will fail. But given that the drive is already in a low
	 * power state, we do not need to do anything.
	 */

> +	if (dev->flags & ATA_DFLAG_SLEEPING)
> +		return;
> +
>  	/* Issue STANDBY IMMEDIATE command only if supported by the device */
>  	if (!ata_dev_power_init_tf(dev, &tf, false))
>  		return;

Other than the above comments, this looks OK. And this probably should go first
in the series with a fixes tag.

-- 
Damien Le Moal
Western Digital Research

