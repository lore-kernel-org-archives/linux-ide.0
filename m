Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA44132133
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260478; cv=none; b=atU/Ss5o6aiaZSGqBwekXVhclTj+bRR/b7YPCa05Ts9PGy+zAOr+cOkQ/l1ex9M1RugPJCpZOHW6Pb5Wf6Qfq4e1IoIEJp+Q6sBxNFq6fIdB3D1IGfXFxDiY1CGmmEGaNlodDMEN0rIrmFo9egftsJw81A8z1sn0NwmeZ6rZMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260478; c=relaxed/simple;
	bh=SUZflCj1kPwQzMVejvVBZ++LrBeT1hRVFzr71Qg1gAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uep48SV0ezpGBVla+pCVDMvTsw4ZBF1Y9Zxi6ZcOb83GnF+Kq9X0TjjlP/kFY9SxtjrVhkfRZ69DrRm4xCefEZGqYJpq2WGrHnY/yzGOadqryyQzKIJax90H7skNF7W1+usQHAALbc3eeNIEwC4HMOC82yglHfpX9oXmosSfmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ditrHb/t; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ditrHb/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718260464;
	bh=SUZflCj1kPwQzMVejvVBZ++LrBeT1hRVFzr71Qg1gAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ditrHb/tKH0UxnCXJZjN0LBTZtkxUfPp9YI86ZZ9bBDoZNxkb896r80jvb3cGjEvE
	 bjGoiiVR+kbQ6NsMz5LLo7Y1t40bh00DZPpEnQiJsnP1Do9LUHAnHCov6nQ4RzoZOS
	 NmAH8sVCP9VIblPgLz8zvWRPAXDrCP6BzhpFpVvM=
Date: Thu, 13 Jun 2024 08:34:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jian-Hong Pan <jhp@endlessos.org>, 
	Dieter Mummenschanz <dmummenschanz@web.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206211352.1664816-3-cassel@kernel.org>

Hi everbody,

On 2024-02-06 22:13:43+0000, Niklas Cassel wrote:
> A hotplug capable port is an external port, so mark it as such.
> 
> We even say this ourselves in libata-scsi.c:
> /* set scsi removable (RMB) bit per ata bit, or if the
>  * AHCI port says it's external (Hotplug-capable, eSATA).
>  */
> 
> This also matches the terminology used in AHCI 1.3.1
> (the keyword to search for is "externally accessible").
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index aa58ce615e79..4d3ec6d15ad1 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1648,9 +1648,10 @@ static void ahci_mark_external_port(struct ata_port *ap)
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
>  
> -	/* mark esata ports */
> +	/* mark external ports (hotplug-capable, eSATA) */
>  	tmp = readl(port_mmio + PORT_CMD);
> -	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
> +	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
> +	    (tmp & PORT_CMD_HPCP))
>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
>  }

This seems to introduce a userspace regression.

GNOME/udisks are now automounting internal disks, which they didn't before.
See [0], [1], [2]

ATA_PFLAG_EXTERNAL is translated into GENHD_FL_REMOVABLE.
(Through ata_scsiop_inq_std(), scsi_add_lun(), sd_probe())

But GENHD_FL_REMOVABLE is not meant for hotpluggable devices but for
media-changable devices (See its description in include/linux/blkdev.h).

To indicate hotplug, dev_set_removable() is to be used.

(Both end up in "removable" sysfs attributes, but these have different
semantics...)

#regzbot introduced: 45b96d65ec68f625ad26ee16d2f556e29f715005

[0] https://bbs.archlinux.org/viewtopic.php?id=295958
[1] https://github.com/storaged-project/udisks/issues/1282
[2] https://github.com/util-linux/util-linux/issues/3088
