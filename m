Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA228B7E9
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295039; cv=none; b=oYwTthed4qEVfog0oO4KOA8/sCEzEyicnBWHycspna1qEoOjgyZRPctRvrgoZEZ0i92q7iEJJy7jbd+wRyX8Irvzva6sw9JMsHqoFsfJq6uFEhbpQFqlTq7w3PMG3/H5Dr6GoQgEvHc2Ob4PaXTu+oPwMZ+woVgmvkdhErg7Ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295039; c=relaxed/simple;
	bh=e0e7tUvybZloHvemZ5MTzH7Wqy8ZvjKYNt5cjU/FLp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7T7bdZ6VXkMNF8HTADbES0tdkXCAXNi4SmGCQhAxZTetg1dc8AE3kEQSz7n4QKv2mepuatHpKsfw8EShJKiiSQu69oBJ0MnLopnBjocP2o7ZLe9eOP55bFKH4FdR7m/pEuCdrV3/zPIoXxI77LbIBoiLrUnE36CaV+nVn5v8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVjHVFhi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVjHVFhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC8C4CEE3;
	Mon, 30 Jun 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751295038;
	bh=e0e7tUvybZloHvemZ5MTzH7Wqy8ZvjKYNt5cjU/FLp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVjHVFhicHbgr4N1cCwYviFVE+a2jWoSeWcRpUoKdofDG6ARKaXXlD0cDLbBwNPP2
	 JOhMZeKOGYfwBMZtLDNeM/dYzWFb2a3jEcG7eah1riJuOm7KEDXjv+Bl5MdbLjReS9
	 D5wck8RYSUolvNrI+0pJVIc3VE7UPxql98YNVg6W+y0VZqUG8DC2oQoICE04Ku5vxA
	 zeJJgXClBX6bE0JkQnRGmPNUxEsyj3FKKqsoLhPeXiFTJFuvAUZs3C3k5KK3hEEIWp
	 8pwuh9Igj9sGscAL6s0fsb+I1rS7fCARrQGVSAiQARUT8K5AN1iKSz0XRYBVON4jxi
	 wgqrubr55zMmQ==
Date: Mon, 30 Jun 2025 16:50:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 07/10] ata: ahci: Disallow LPM policy control for
 external ports
Message-ID: <aGKkO3I1SmZiwVLR@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-8-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-8-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:34PM +0900, Damien Le Moal wrote:
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
> ---
>  drivers/ata/ahci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0760fa47d90e..34698ae39f55 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1776,7 +1776,9 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	 * LPM if the port advertises itself as an external port.
>  	 */
>  	if (ap->pflags & ATA_PFLAG_EXTERNAL) {
> -		ata_port_dbg(ap, "external port, not enabling LPM\n");
> +		ata_port_warn(ap, "External port, forcing LPM max_power\n");

Should this really be a warning?
External ports are quite common, so it seems like this could easily trigger 32
lines of prints on a controller with 32 ports.

We already have the " ext" print when printing each port during probe,
perhaps that is enough?


Kind regards,
Niklas
