Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841F353A74
	for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943894; cv=none; b=Jpv+tOech+cOzsy/dPrUQU8w6x27lCf2ZfSeW/Cld2SlOfUajciCxnIX94GmIyL7KvEra+7vE7CYjF0m+3Z6TPJ0A+aNKKTgpQTSbCHgYWv2sR/MJ3F633n6o0UxS7QwVFvU3c8CnmlvyIcWOM5NyYVrgLpwbmeAZ/hfsNBZDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943894; c=relaxed/simple;
	bh=DhLO+J2p2uzXx1cL4Wn3uGQmc11yzo3STsVZdwFYiOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvCQXsUD2+MjC5cNfcnJQ2asdK2MhtTawHTVwkI3iy4Zu1Tgp6oVwzCKKE+wDPLVTeJ3czBHh+713lCbK5RbmUJdfPPfpj47MwbH/ncgSy5/7KFSXMiSHcpeE45Sl+uhU/8wcwWKX/buxDTb+CQWgt/SQyhCXrLYVWiOKQxvmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Mtjcsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Mtjcsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA831F000E9;
	Fri, 28 Aug 2026 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943892;
	bh=Ea0sHq+wpD6PPHw8US8jIo700rhj2JKOb+r2KXTiZUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H9MtjcscQ9F/tygfWxlFMFbU8rGoillnhmRvYVLFYi+tnBs2R7mkKbjMnFMfJlVYI
	 lZNoVBm72HVhYUZSpoAe4KfdLdUKRHIJGdbT4zt7ov7cW7/OnefD8dFKZS0Pc7XUkr
	 EEctkhwPMTKmp4sM0tjxMwc1aXG+indJPH3jD2SMXgxrkqwOOqQXHnDcEtURpZ+La6
	 CE9kDW1PWKxEi5RNLNn8kStKbT5jUSQtx+IJLkC43qF98cKp4YJ+u0Wv37+hTr/9qM
	 0Mt2dvD2lgmiqsXzKTgNRv1Ycg5Hsc8KWThLlRZFKCGKCqHgS5KLjUg5jvvYlemT/R
	 vGZSjTIDIrvPA==
Received: by pali.im (Postfix)
	id 48F7F4E4; Fri, 28 Aug 2026 21:04:52 +0200 (CEST)
Date: Fri, 28 Aug 2026 21:04:52 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	risc4all@yahoo.com
Subject: Re: [PATCH v2] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
Message-ID: <20260828190452.ic5j5bdnnbx2hs4f@pali>
References: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
User-Agent: NeoMutt/20180716

On Friday 28 August 2026 09:05:21 Hajo Noerenberg wrote:
> ahci_single_level_irq_intr() services the ports first and clears the
> global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> looked at again, and the command in flight only ends in a timeout.
> 
> Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood,
> 88SE6121 rev B2 behind PCIe) by polling the AHCI registers from userspace
> while an IDENTIFY was outstanding:
> 
>   t=303.046  irqs 127  PxIS 0x00000000  PxCI 0x00000001
>              IDENTIFY issued
>   t=303.057  irqs 128  PxIS 0x00000020  PxCI 0x00000000
>              CI cleared, DPS set, one interrupt taken
>              ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
>   t~308.05   qc timeout after 5000 msecs
> 
> The command had completed - PxCI was clear and PxIS had DPS set - so
> ahci_qc_complete() would have completed it.  It never got the chance
> because the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.
> 
> Marvell's own driver for these chips clears the two registers in the
> opposite order and says so ("clear global before channel"), and
> ahci_xgene handles its broken edge latch the same way.  Since the
> reordering costs at most one spurious interrupt per valid one on
> conforming controllers, do it in a private interrupt handler selected for
> board_ahci_mv instead of changing libahci for everyone.
> 
> With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the
> 88SE6121 without the drive-side 1.5 Gbps jumper that was needed before.
> Time from link up to a successful IDENTIFY:
> 
>   WDC WD5000AADS-00S9B0  port 0    7 ms  (never identified before)
>   WDC WD3202ABYS-01B7A0  port 1   28 ms
>   WDC WD30EFRX-68EUZN0   port 1  200 ms  (3 TB, HPA detection ok)
> 
> Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145,
> which Marvell's driver treats identically.
> 
> Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
> Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>

Thank you for successfully addressing this issue after working on it for
a longer time.  It is very nice to see a successful story at the end.

For me the change looks good.

Acked-by: Pali Rohár <pali@kernel.org>

As this change is fixing the support for more disks, I would suggest to
backport this change also into older kernels, ideally by cc: stable
line (so it would be automatic).

> 
> ---
> Damien,
> 
> as requested, resent with the new title.  The patch itself is byte for byte
> v1 [1]; only the commit message changed.
> 
> v2:
>  - retitle "clear HOST_IRQ_STAT before the ports" -> "work around lost
>    interrupts", per review
>  - rewrap the commit log at 75 columns and reflow the register trace, which
>    had lines up to 79 characters
>  - no functional change
> 
> The answer to your review question is in that thread as well: registering
> ahci_thunderx_irq_handler() unchanged for board_ahci_mv does not work on this
> chip.  It still clears HOST_IRQ_STAT after servicing the ports, and the loop
> cannot make up for that, because once IS has been written while an unserviced
> PxIS bit was standing, this controller never re-asserts it -- the re-read
> returns 0 and the loop exits.
> 
> [1] https://lore.kernel.org/linux-ide/50ebd35a-086f-40fb-887e-576e36e7a2b8@noerenberg.de/
> 
>  drivers/ata/ahci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1618,6 +1618,51 @@
>  }
>  #endif
> 
> +/*
> + * The Marvell 88SE6111/6121/6145 ("Thor") family stops reporting interrupts
> + * for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits: PxIS
> + * keeps its content, HOST_IRQ_STAT reads back as 0, the port is never looked
> + * at again and the command in flight only ends in a timeout.  On a 88SE6121
> + * this makes every SATA-2 or SATA-3 disk fail to IDENTIFY, while SATA-1 disks
> + * happen to win the race often enough to work.
> + *
> + * Clearing the host status before servicing the ports avoids it.  Marvell's
> + * own driver for these chips does the same and says so ("clear global before
> + * channel"), and ahci_xgene handles its broken edge latch the same way.  The
> + * price is at most one spurious interrupt per valid one, which is why this is
> + * not the generic behaviour - see AHCI 1.1 section 10.6.2.
> + *
> + * Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
> + */
> +static irqreturn_t ahci_mv_irq_handler(int irq, void *dev_instance)
> +{
> +       struct ata_host *host = dev_instance;
> +       struct ahci_host_priv *hpriv = host->private_data;
> +       void __iomem *mmio = hpriv->mmio;
> +       unsigned int rc;
> +       u32 irq_stat, irq_masked;
> +
> +       irq_stat = readl(mmio + HOST_IRQ_STAT);
> +       if (!irq_stat)
> +               return IRQ_NONE;
> +
> +       irq_masked = irq_stat & hpriv->port_map;
> +
> +       spin_lock(&host->lock);
> +
> +       /*
> +        * Use the unmasked value to clear the interrupt, as a spurious pending
> +        * event on a dummy port might cause a screaming IRQ.
> +        */
> +       writel(irq_stat, mmio + HOST_IRQ_STAT);
> +
> +       rc = ahci_handle_port_intr(host, irq_masked);
> +
> +       spin_unlock(&host->lock);
> +
> +       return IRQ_RETVAL(rc);
> +}
> +
>  static void ahci_remap_check(struct pci_dev *pdev, int bar,
>                 struct ahci_host_priv *hpriv)
>  {
> @@ -1878,6 +1923,10 @@
>                 return -ENOMEM;
>         hpriv->flags |= (unsigned long)pi.private_data;
> 
> +       /* the Marvell "Thor" family needs HOST_IRQ_STAT cleared first */
> +       if (board_id == board_ahci_mv)
> +               hpriv->irq_handler = ahci_mv_irq_handler;
> +
>         /* MCP65 revision A1 and A2 can't do MSI */
>         if (board_id == board_ahci_mcp65 &&
>             (pdev->revision == 0xa1 || pdev->revision == 0xa2))
