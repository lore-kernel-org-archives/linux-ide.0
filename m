Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF518B12;
	Thu, 14 Aug 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138646; cv=none; b=JDVB2yaajXH3YAQroK2spTxDpFcaoFrkC3LCN4Y3SR0cBpkWsXdFpIfqstDlmivSR0CcOjW50kOJCP7fsihV/Z1xdY18n2RFzs8RiDV8JGMdkzZFwuP1YH0c5FNzxYXDTNXCxnJXWMlE040DW3csVZeJBr2qttrLxF3Q01gPrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138646; c=relaxed/simple;
	bh=UiQ0pWMZceATghV+cJ0sTxk4Qb+0GTBZpEkONvTvt8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8cO4KhBYh9j3dntu4LXwD5BDACGftYe+ThOY5dl6NQHNWupYgriRYZW6n/7jRrXGR2idj1RKseK+hYSBXyfDkBEy4YdRHA/C51HZV7fSKB0PkjWnZOZEB2hQEP0ssppmuQGOtWi/dO4oa/xfZIL4vl7TGw+Qe97Nk0rcgtAxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULGUGolQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULGUGolQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29395C4CEEB;
	Thu, 14 Aug 2025 02:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755138644;
	bh=UiQ0pWMZceATghV+cJ0sTxk4Qb+0GTBZpEkONvTvt8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ULGUGolQkt7Dgqm7JJqVQRb5/3KzHKUvArZP2lWxX53sEmB69bKxaISxke8W86MnX
	 QRHLdju60f11hag7em4WR4JDJm+zWSG0i6kfkB09WZ4wDnxW3KTk9G8dyhAh3C956y
	 kjTYIpLfJeXyd4sQwUhMWtrSdOf23OEJS1br1OPsskXAw1tM82UXDiB44IQj5avav0
	 KwB2si5XA2umyl/DCLtE0qW1GfthuUixt92PhzQqAGRZ2bChtMup6YN427QX5wBRGe
	 VfQCVzDpe3IbU7v0ye1EhMEP4KCMuIt1Re8PW1WnkuodYjXJjOSLyqZmeyZom8fqvE
	 C969f2lr+YkSA==
Message-ID: <1d33a2b0-8811-474a-8399-71eeaa05a2ea@kernel.org>
Date: Thu, 14 Aug 2025 11:28:02 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-scsi: Fix CDL control
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814022256.1663314-1-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250814022256.1663314-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 11:22 AM, Igor Pylypiv wrote:
> Delete extra checks for the ATA_DFLAG_CDL_ENABLED flag that prevent
> SET FEATURES command from being issued to a drive when NCQ commands
> are active.
> 
> ata_mselect_control_ata_feature() sets / clears the ATA_DFLAG_CDL_ENABLED
> flag during the translation of MODE SELECT to SET FEATURES. If SET FEATURES
> gets deferred due to outstanding NCQ commands, the original MODE SELECT
> command will be re-queued. When the re-queued MODE SELECT goes through
> the ata_mselect_control_ata_feature() translation again, SET FEATURES
> will not be issued because ATA_DFLAG_CDL_ENABLED has been already set or
> cleared by the initial translation of MODE SELECT.
> 
> The ATA_DFLAG_CDL_ENABLED checks in ata_mselect_control_ata_feature()
> are safe to remove because scsi_cdl_enable() implements a similar logic
> that avoids enabling CDL if it has been enabled already.
> 
> Fixes: 17e897a45675 ("ata: libata-scsi: Improve CDL control")
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Thanks. This looks good.

Of note though, is that this is all due to the fact that we set or clear the
flag irrespective of the result of the SET_FEATURE command, which may actually
fail... But we do not have a simple way to wait for that command to complete
first before manipulating the flag. This will need some bigger fixes later :)

> ---
> 
> Changes from v1:
> - Changed the patch from revert to fixup.
> - Restored debug logs and the comment about mutual exclusivity with
>   NCQ priority.
> - Dropped cc to stable and added fixes tag instead.
> 
>  drivers/ata/libata-scsi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 57f674f51b0c..2ded5e476d6e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3904,21 +3904,16 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
>  	/* Check cdl_ctrl */
>  	switch (buf[0] & 0x03) {
>  	case 0:
> -		/* Disable CDL if it is enabled */
> -		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
> -			return 0;
> +		/* Disable CDL */
>  		ata_dev_dbg(dev, "Disabling CDL\n");
>  		cdl_action = 0;
>  		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
>  		break;
>  	case 0x02:
>  		/*
> -		 * Enable CDL if not already enabled. Since this is mutually
> -		 * exclusive with NCQ priority, allow this only if NCQ priority
> -		 * is disabled.
> +		 * Enable CDL. Since CDL is mutually exclusive with NCQ
> +		 * priority, allow this only if NCQ priority is disabled.
>  		 */
> -		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
> -			return 0;
>  		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
>  			ata_dev_err(dev,
>  				"NCQ priority must be disabled to enable CDL\n");


-- 
Damien Le Moal
Western Digital Research
