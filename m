Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41727358D12
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223838; cv=none; b=ueKV+AfFEEZGZZUkxbF9AosiIBOpu0laTBWXPpCMaHo4ERQLjUVpJ+3xTep9KSxma1cd0lU8eTe1Ps1o6d9nzN2BoICP/0YjfsR4zbunJmSEb7Z0KnlKXgGGqQXkKP9SQtXZU11NW+q3jBsY0iRC1O/TCuzyBJEYJEEJg/4gY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223838; c=relaxed/simple;
	bh=fVFgrl1NblTsD3Vx9hXgzSQgWi630u8dDucJ2I1csKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4CrEIE94f9M01U2B58v0yJtIujzX2eGIYCD5wZuCzp83P0TvCVJEwzzaCnkBzqFAH5jsGp55VgJ+JVz7sfDU21RwO+e2GPjmL3vRdmZIX1cDVBNwEtfJuadvDiDmaSt/0psTrlabCZJy3x8JoCIxYSUKr4Lc7tW1oaIZ1MDdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oob+1UNp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oob+1UNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1731CC19421;
	Mon, 12 Jan 2026 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768223837;
	bh=fVFgrl1NblTsD3Vx9hXgzSQgWi630u8dDucJ2I1csKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oob+1UNpVR5vYzR+HVRORawH8gus1neQrqvOma2cmGJ3fgAkiuGqKTHDhbD0anVsh
	 /F9AwAgYGBgmqYofkjzW6opA+LF7adKIKVPCyi5rC+yNMVkvP/kT28+FlD/70f1x5G
	 jigglsjc679m7WeoDEp4PU18Cdn8qojR1xJkRpQl1nq9UvKVcyAkYV3WHWY4mb7EBt
	 Iapm4OtQxrTvx/0K/ilP0nOv5iMPzrqRCob1K5cCJcVLQDd9tAIyHqP/uYoqmnHsJj
	 8lxFrXdj1L71T41L4jn6WDBrAjHaTg5DrSNiPyU/IQ9qK40/8iYbNIX4/r5sGqFwaw
	 ojPyPeJx6QJ0A==
Message-ID: <5b945fcf-059d-409c-9475-630483c14a5e@kernel.org>
Date: Mon, 12 Jan 2026 14:17:14 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ata: libata-sata: Improve
 link_power_management_supported sysfs attribute
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, wolf@yoxt.cc
References: <20260112122044.143637-8-cassel@kernel.org>
 <20260112122044.143637-11-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260112122044.143637-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 13:20, Niklas Cassel wrote:
> The link_power_management_supported sysfs attribute is currently set as
> true even for ata ports that lack a .set_lpm() callback, e.g. dummy ports.
> 
> This is a bit silly, because while writing to the
> link_power_management_policy sysfs attribute will make ata_scsi_lpm_store()
> update ap->target_lpm_policy (thus sysfs will reflect the new value) and
> call ata_port_schedule_eh() for the port, it is essentially a no-op.
> 
> This is because for a port without a .set_lpm() callback, once EH gets to
> run, the ata_eh_link_set_lpm() will simply return, since the port does not
> provide a .set_lpm() callback.
> 
> Thus, make sure that the link_power_management_supported sysfs attribute
> is set to false for ports that lack a .set_lpm() callback. This way the
> link_power_management_policy sysfs attribute will no longer be writable,
> so we will no longer be misleading users to think that their sysfs write
> actually does something.
> 
> Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/libata-sata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b2817a2995d6..04e1e774645e 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -909,7 +909,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
>  	struct ata_link *link;
>  	struct ata_device *dev;
>  
> -	if (ap->flags & ATA_FLAG_NO_LPM)
> +	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)

Can't we set ATA_FLAG_NO_LPM for ports that do not have set_lpm implemented
earlier when scanning ? That would be safer.


>  		return false;
>  
>  	ata_for_each_link(link, ap, EDGE) {


-- 
Damien Le Moal
Western Digital Research
