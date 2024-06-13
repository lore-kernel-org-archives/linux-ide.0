Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7113E3F9;
	Thu, 13 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283387; cv=none; b=LN80ooesRoSdSNV3277lJXnYeRUXAHp42WWb2gGgM8LR8IpCj/15GK4GzTZgzmOy8SNxJ4aj4QD1AC+dbXTjdbVtrERbpeBjLbVLIwUrJqL+ZQE1QUUrIyvIR26+Olfp4SeihDll+MvkP1zCigV6xaQfhKalAo1pgmjweUjjaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283387; c=relaxed/simple;
	bh=PErDpwfSF06g3WVkwUq8fQ1sTFQVPl9LaAOByMCr+so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BosZyat62oIpKBKIGuX7SFg0D7pwfea5MB/1ss+M5RLfui2MTkiOTARpQNcV4pBTupo4uyl6D3uhMfqft1P+NacErN4ln5jSyyk65thjnQ7/Ndldztgf+2Oz05GsY1klg1LYr7RciUfeJvDK1C8fKKN7pNDyeVFVE6+NL0czZZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gGo7rrIp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gGo7rrIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718283380;
	bh=PErDpwfSF06g3WVkwUq8fQ1sTFQVPl9LaAOByMCr+so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGo7rrIp9b0b3ESvqV8dAbMoGgf66fOJSY9nwUM7VPKXLMStkqwZhTi4hqr4KJK4C
	 XYRSgc3qd91qw7kXtUZeq6e8xlDB/uXbQDeuAiCIMbWR5Hf88qmY5ZuYdGOqx9tBgo
	 NjwhpeznBdp6g2jTAU3Ss1LfBmA7uwPZ9KdgnhjQ=
Date: Thu, 13 Jun 2024 14:56:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Werner Fischer <devlists@wefi.net>, 
	Daniel Drake <drake@endlessos.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz <dmummenschanz@web.de>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-ide@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <d1b3642d-45a8-4550-ae04-af3897a33571@t-8ch.de>
References: <20240206211352.1664816-1-cassel@kernel.org>
 <20240206211352.1664816-3-cassel@kernel.org>
 <c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de>
 <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b12a50-7921-4f61-b41f-74e074c5ceb3@kernel.org>

+Cc LKML for people to find it more easily.

On 2024-06-13 17:29:31+0000, Damien Le Moal wrote:
> On 6/13/24 15:34, Thomas Weißschuh wrote:
> > Hi everbody,
> > 
> > On 2024-02-06 22:13:43+0000, Niklas Cassel wrote:
> >> A hotplug capable port is an external port, so mark it as such.
> >>
> >> We even say this ourselves in libata-scsi.c:
> >> /* set scsi removable (RMB) bit per ata bit, or if the
> >>  * AHCI port says it's external (Hotplug-capable, eSATA).
> >>  */
> >>
> >> This also matches the terminology used in AHCI 1.3.1
> >> (the keyword to search for is "externally accessible").
> >>
> >> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> >> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> >> ---
> >>  drivers/ata/ahci.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> >> index aa58ce615e79..4d3ec6d15ad1 100644
> >> --- a/drivers/ata/ahci.c
> >> +++ b/drivers/ata/ahci.c
> >> @@ -1648,9 +1648,10 @@ static void ahci_mark_external_port(struct ata_port *ap)
> >>  	void __iomem *port_mmio = ahci_port_base(ap);
> >>  	u32 tmp;
> >>  
> >> -	/* mark esata ports */
> >> +	/* mark external ports (hotplug-capable, eSATA) */
> >>  	tmp = readl(port_mmio + PORT_CMD);
> >> -	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
> >> +	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
> >> +	    (tmp & PORT_CMD_HPCP))
> >>  		ap->pflags |= ATA_PFLAG_EXTERNAL;
> >>  }
> > 
> > This seems to introduce a userspace regression.
> > 
> > GNOME/udisks are now automounting internal disks, which they didn't before.
> > See [0], [1], [2]
> > 
> > ATA_PFLAG_EXTERNAL is translated into GENHD_FL_REMOVABLE.
> > (Through ata_scsiop_inq_std(), scsi_add_lun(), sd_probe())
> > 
> > But GENHD_FL_REMOVABLE is not meant for hotpluggable devices but for
> > media-changable devices (See its description in include/linux/blkdev.h).
> > 
> > To indicate hotplug, dev_set_removable() is to be used.
> > 
> > (Both end up in "removable" sysfs attributes, but these have different
> > semantics...)
> 
> This should take care of the issue.
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 37ded3875ea3..170ed47ef74a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1912,11 +1912,8 @@ static unsigned int ata_scsiop_inq_std(struct
> ata_scsi_args *args, u8 *rbuf)
>                 2
>         };
> 
> -       /* set scsi removable (RMB) bit per ata bit, or if the
> -        * AHCI port says it's external (Hotplug-capable, eSATA).
> -        */
> -       if (ata_id_removable(args->id) ||
> -           (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
> +       /* Set scsi removable (RMB) bit per ata bit. */
> +       if (ata_id_removable(args->id))
>                 hdr[1] |= (1 << 7);
> 
>         if (args->dev->class == ATA_DEV_ZAC) {

Thanks, looks good.

Tested-by: Thomas Weißschuh <linux@weissschuh.net>

> BUT, need to check what SAT & SATA-IO have to say about this.

Who takes care of this?

> > #regzbot introduced: 45b96d65ec68f625ad26ee16d2f556e29f715005
> > 
> > [0] https://bbs.archlinux.org/viewtopic.php?id=295958
> > [1] https://github.com/storaged-project/udisks/issues/1282
> > [2] https://github.com/util-linux/util-linux/issues/3088
