Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB5143C46;
	Thu, 13 Jun 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284441; cv=none; b=AldFOTIsch+VSg/hSezd29ZWS3fSEWpn15m/YAp6ZCWJLQbZLiSuaPpmmKrKZ5NyduDHe2E0NSdHoKZQ53OIrzlmVHk+1l7tzhJfEyJgM4QLqzWi8lck2D4zPt2GxTyxpEg1QDyv7DoFE3OvRxhXM20f60ugMjxpg3TRPchfP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284441; c=relaxed/simple;
	bh=czkE7W7quSijCVTM08yOeyhnXpErCJT0ihgxy4/MXXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HClDYG8q+IwZWAdykr4lzfq+iTf3s41jIXLL1pZf0ALQ968z+SdtXnf4nodkqkRSPYz08tCE8xriODKmFyJhTaMK68fED5Jk3+R7mhAL4nelrbMRXCz8vbMfDWZpyKJalY9LnMWTvBFojw9MJnyOkGoI7kA9XGlTRJ73bTvfwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7xx10V1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7xx10V1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA69C2BBFC;
	Thu, 13 Jun 2024 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718284440;
	bh=czkE7W7quSijCVTM08yOeyhnXpErCJT0ihgxy4/MXXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7xx10V19wpVo633ebWtNmHsWyyjNO0R0/LBFy/3CAMhlyQm8sQSfruwV012J8qQV
	 BjO2eeS/tXR4R3EHfM0sFfjwNwIqBajuVV7dqXHYx9h7A+AHEAOpnn3NN927SKB1iK
	 N1x4PaxdtlSpTxa7SGzxqgM8hYBSm0s8rcCN/BJ6MtHXNWfbOBcshua49s3zTCmkGi
	 1mEpHp9xTqEKPkoYcDqW2XdLWVDETb7K7kMro2fZBiE1LGRHOSBNgAKzUobCpcBEZA
	 XgLtYW8jcWnc8dPFWkE/FK3wlg/AScQnwQg9oSacWUBLOZFsb2HDLvILubsBNFZ31G
	 P0L8yCMei+faQ==
Date: Thu, 13 Jun 2024 15:13:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 2/5] ata: ahci: a hotplug capable port is an external
 port
Message-ID: <ZmrwksRyOkQq1OPV@x1-carbon.lan>
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

On Thu, Jun 13, 2024 at 05:29:31PM +0900, Damien Le Moal wrote:
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
> 
> BUT, need to check what SAT & SATA-IO have to say about this.

This is the correct fix, and we should merge it ASAP.
(We set the RMB bit only if ata_id_removable() is set.
ata_id_removable() is defined in CFA / CFast / Compact Flash,
that can insert a card in the SATA connected reader.)


The SCSI Removable Media Bit (RMB) should only be set for removable media,
where the device stays and the media changes, e.g. CD-ROM or floppy.

This bug was originally introduced in commit:
8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as removable")
which sets the RMB bit if the port has either the eSATA bit or the hot-plug
capable bit set. The reasoning was that the author wanted his eSATA ports to
get treated like a USB stick.

This is however wrong. See "20-082r23SPC-6: Removable Medium Bit Expectations"
which has since been integrated to SPC, which states that:

"Reports have been received that some USB Memory Stick device servers set the
removable medium (RMB) bit to one. The rub comes when the medium is actually
removed, because... The device server is removed concurrently with the medium
removal. If there is no device server, then there is no device server that is
waiting to have removable medium inserted.

Sufficient numbers of SCSI analysts see such a device:
• not as a device that supports removable medium;
but
• as a removable, hot pluggable device."

The definition of the RMB bit in SPC was then updated to highlight this fact.

Thus, a USB stick should not have the RMB bit set
(and neither shall a eSATA or a hot-plug capable port).


Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
external/removable") later changed so that the RMB bit is only set for
the eSATA bit (and not for the hot-plug capable bit), because of the
exact same problem as reported here... However, treating eSATA and
hot-plug capable ports differently is of course not correct.

From AHCI spec:
Hot Plug Capable Port (HPCP): When set to ‘1’, indicates that this port’s
signal and power connectors are externally accessible via a joint signal
and power connector for blindmate device hot plug.

So a hot-plug capable port is an external port, like the commit said.

If we want to fix so that a eSATA port or external port is actually
listed as removable, then, as Thomas said, dev_set_removable() seems
to be the correct way. SCSI does have a "HOT PLUGGABLE" field in
"6.7.2 Standard INQUIRY data", so the proper way to mark the SATA
device as removable is probably to let ata_scsiop_inq_std() set
the "HOT PLUGGABLE" field correctly (if ATA_PFLAG_EXTERNAL),
such that SCSI core can call dev_set_removable() with the proper
arguments. However, right now SCSI core does not call
dev_set_removable() at all. In fact, it seems to only be used by
drivers/mmc/core/bus.c, drivers/pci/probe.c, and drivers/usb/core/hub.c.


I suggest that we:
1) Merge Damien's fix.
2) Modify SCSI to call dev_set_removable() and modify ata_scsiop_inq_std()
   to set the "HOT PLUGGABLE" field.


Kind regards,
Niklas
