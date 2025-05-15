Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38BD27A935
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313866; cv=none; b=Q+R6Nk4+2YrDTW8JYRtl+8jgFH2glXIlPHAfQ2C7mRma9Ac5ZLtOw1Ge3Ts06moVXWvfdPdZNLK5t0BpV5WjfgeWdoV2S+9z6sRxLkFyGQuz7M4nM+i9PTUUQ3uLEzE+/2UeG+ARHAlpayjhmMesKUKpUwHiCgRYA96FfCwJ99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313866; c=relaxed/simple;
	bh=IZnAFUm0W8NE2rbNQFC2xXOyOz91b+HhywkSy095fsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqXrTf47nXvdu3vMDmJE97bO/FOmwEV+ds5JSBmUdUr4UnLLboVEKfPxWMq0Cc2MaqelkM8x8tlzPMMnOVB02+aQYIZ0P5xoh3LcJZkALHxYkoLpkclpCwvEJZedBJ9rxf3t+FR9DMZ6N2lT3K92dvqmRkJ2RuXOvfSnSEFjZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON4yfq1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON4yfq1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96AFC4CEEF;
	Thu, 15 May 2025 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313866;
	bh=IZnAFUm0W8NE2rbNQFC2xXOyOz91b+HhywkSy095fsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ON4yfq1oY0QQPjA8AicX5KT2cU3wAo0U5tofuiiBV+IC4QifZw+bQsW8Aj2cOvDiL
	 l+QX4e2k7votrtBeTGwvLyFhKPttKGR2GA8wjHofVxCtL2jC8UvXsbHYG+YzvqjOfn
	 dStpVFkgnXqJFleWL/TTTZeu72vdY18JT+mfNTw9mypJ6LO1lWunSiBbKCwdbvdM/k
	 c0ZfemMotqCxbfNvlc8C8QrHI3RKO92m69+/TnWFBKkgcss5T4tSgUjEvtR28MwFYe
	 X95RZ+oG7Mb6XKccHMM29mDwh5tl7n9fqoNPQZ1KO3BFbJW7lY2XjCUa4you3MgZwj
	 cVvahIxMu3iJg==
Message-ID: <6cf0fecf-0161-49a5-b49a-34622d69918e@kernel.org>
Date: Thu, 15 May 2025 14:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_via: Force PIO for ATAPI devices on
 VT6415/VT6330
To: Tasos Sahanidis <tasos@tasossah.com>, linux-ide@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20250514183107.152785-1-tasos@tasossah.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250514183107.152785-1-tasos@tasossah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 20:31, Tasos Sahanidis wrote:
> The controller has a hardware bug that can hard hang the system when
> doing ATAPI DMAs without any trace of what happened. Depending on the
> device attached, it can also prevent the system from booting.
> 
> In this case, the system hangs when reading the ATIP from optical media
> with cdrecord -vvv -atip on an _NEC DVD_RW ND-4571A 1-01 and an
> Optiarc DVD RW AD-7200A 1.06 attached to an ASRock 990FX Extreme 4,
> running at UDMA/33.
> 
> The issue can be reproduced by running the same command with a cygwin
> build of cdrecord on WinXP, although it requires more attempts to cause
> it. The hang in that case is also resolved by forcing PIO. It doesn't
> appear that VIA has produced any drivers for that OS, thus no known
> workaround exists.
> 
> HDDs attached to the controller do not suffer from any DMA issues.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/916677
> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> ---
>  drivers/ata/pata_via.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
> index 696b99720dcb..11dce43c6b7c 100644
> --- a/drivers/ata/pata_via.c
> +++ b/drivers/ata/pata_via.c
> @@ -368,7 +368,7 @@ static unsigned int via_mode_filter(struct ata_device *dev, unsigned int mask)
>  	}
>  
>  	if (dev->class == ATA_DEV_ATAPI &&
> -	    dmi_check_system(no_atapi_dma_dmi_table)) {
> +	    (dmi_check_system(no_atapi_dma_dmi_table) || config->id == PCI_DEVICE_ID_VIA_6415)) {

Long line. Please split it after "||".

>  		ata_dev_warn(dev, "controller locks up on ATAPI DMA, forcing PIO\n");
>  		mask &= ATA_MASK_PIO;
>  	}


-- 
Damien Le Moal
Western Digital Research
