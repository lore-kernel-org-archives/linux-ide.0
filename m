Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9A2459D7
	for <linux-ide@vger.kernel.org>; Tue,  1 Jul 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363019; cv=none; b=oswa2QjoXdptEo0WmzCVq7n5fNE0805jH1ZidzYjpTPI2bRkrj+qs/BXhvGnGpXNpSEDugvwH+kIWhsyANM3rT6KI4zZxhnfbe79d8Jz/X7U/SKC0KZAzda1fi55dNpGgK30mr85Mqm7jYc+x1mxR/kRvfORcxdHQRJBp7fBIPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363019; c=relaxed/simple;
	bh=ht01Fmer+/VfZVNt/29Kdv3FUexWIEH57GJM50OpPB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHhbeIDDlVrKAjhvh8oZuCSgZFqxYjMU5a/jtQqhVKkm5OW4pcBbClogkoN8fmAYkVu7F+dWNyl1iLv7WCfwFoX7tNBSzB3BqDLnNZV4wg/agTRhGCPKwqna57qjpPzdobZ21W6TumalAtU3aMIQWhuYdo2USBh7sLyyD/2ZX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm0bU/9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm0bU/9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D9C4CEEB;
	Tue,  1 Jul 2025 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751363017;
	bh=ht01Fmer+/VfZVNt/29Kdv3FUexWIEH57GJM50OpPB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hm0bU/9FadG5U5muaCNZJo/1H4EfoSvFwlUDRPx1140Hcfh6a/DO5HQyKmF7lDLJ0
	 yCXisUZlUrGnFHg+GF+KAn97hWW4QD8nfUMhAIjjLxX6GJm82PPMGTyWR1LZQLs3L+
	 IqGQmh/X0RfdDl4vpENp1X5jDPZIRl7sh/VLXZD8Ca9qjKyebWvLi7JWLl1yFprG2j
	 otuiSu4zzgwqH9JCuU1M63x1ITj4EA4IEy5d10J3GnpdAt8oYV59BDE92pIFF3t2JE
	 lh6GMltHCbDgHiSaHkKt7s1ixRXTT9l/xWZrhOZRu9OHA6Di5EqSD2QUXJ2eim/FVp
	 3vXd2rNz+maog==
Date: Tue, 1 Jul 2025 11:43:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 07/10] ata: ahci: Disallow LPM policy control for
 external ports
Message-ID: <aGOtxhQUNy0OJLA2@ryzen>
References: <20250701001408.330364-1-dlemoal@kernel.org>
 <20250701001408.330364-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701001408.330364-8-dlemoal@kernel.org>

On Tue, Jul 01, 2025 at 09:14:05AM +0900, Damien Le Moal wrote:
> Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
> added an early return in ahci_update_initial_lpm_policy() for all
> ports flagged as external with the ATA_PFLAG_EXTERNAL port flag (e.g.
> eSATA ports or hotplug capable ports) so that the target_lpm_policy of
> these ports is unchanged and set to ATA_LPM_UNKNOWN. thus forcing libata
> EH to not be called for external port. The goal of this change is to
> preserve the initial power management policy to not break the hotplug
> capability of external ports.
> 
> However, this change is incomplete as users or system daemon (e.g.
> systemd-udevd) can still apply the system preferred power management
> policy through sysfs, thus potentially unknowingly breaking the port
> hotplug capability.
> 
> Modify ahci_update_initial_lpm_policy() to flag external ports with
> ATA_FLAG_NO_LPM to prevent changes to the LPM policy by users through
> the sysfs link_power_management_policy host attribute. Also set the
> target_lpm_policy of external ports to ATA_LPM_MAX_POWER to ensure
> that the port is not in a low power state preventing hotplug operations.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Perhaps also mention that debug message is removed because since
commit 439d47608bb3 ("ata: libata: Print if port is external on boot")
it is printed unconditionally at boot.

With that:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

> ---
>  drivers/ata/ahci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0760fa47d90e..a061aa3299ef 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1776,7 +1776,8 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	 * LPM if the port advertises itself as an external port.
>  	 */
>  	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
> -		ata_port_dbg(ap, "external port, not enabling LPM\n");
> +		ap->flags |= ATA_FLAG_NO_LPM;
> +		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
>  		return;
>  	}
>  
> -- 
> 2.50.0
> 
