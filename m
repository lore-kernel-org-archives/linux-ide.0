Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FEC2C7
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838772; cv=none; b=uIEE5MexsuyCUsKc+068FOmKihL6meVoMXYSUKmf1AFAD9kUYix6W/iJwBx8NgSLhvKTmQs/iFtFnFxFr/aDQjxI/cfSiPb8unzQARYJaXP7gQc1ieltieuKsU4qGjB2g9euXzyn8wpAET2jsROiZU4iWU0D5HuryZiPD7SpLZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838772; c=relaxed/simple;
	bh=hxytyUCWGvNjdl1otvoD7pJao6deowy+w2y5jT8Qb7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Opz7tuxS5YWpZLFREi1uHpfAhPx239FyABYhlVawIGBQ5Xs1SyBoGR0ieUY+rhbfogcsQnfUPr6jDkuSV7FATmiEQUIE3ClaqytZiQ93S7MEF7KU5NabLztuFtdrf7p3avVQRw6yLu+d1JyDijITAAZnjAWqTVxh3BIJp0xUL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uts0rcne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uts0rcne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204FDC433F1;
	Fri,  2 Feb 2024 01:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706838772;
	bh=hxytyUCWGvNjdl1otvoD7pJao6deowy+w2y5jT8Qb7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uts0rcneZNsZPKtR1crPYwcIi39Fq8+FlL4O4+xln98fwUHfBlxnwHhMmAuuRN7v6
	 92YrFPrPcNmrTMNtggG4tEHxAQ0tRSQQMPq6Ow/LilOVNxhiPzsv6FIXF1HtpR3TaG
	 0+gua9eLigHHFUXbF3Ci8Xw4+VlksjOGHyBAUROOs4H/B90T25iCydLuCsPigTm/Ha
	 0DNaHCvCppDZeJtMfJkrUeKA+bKbu5akE7TErsDV8lK4gmVp31kDFUj26lfT20zavM
	 U6wrfNRSFI9fx94TTm+MX9xi4+QLrsgYqvC0Jdb9nY/b6sc1LvZDGuJRAwbkHPBlYo
	 QTgP0YgKrPdSw==
Message-ID: <5e422443-06f5-4885-9738-84419514a9af@kernel.org>
Date: Fri, 2 Feb 2024 10:52:49 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ata: ahci: move marking of external port earlier
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>, Daniel Drake <drake@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jian-Hong Pan <jhp@endlessos.org>, Dieter Mummenschanz
 <dmummenschanz@web.de>, linux-ide@vger.kernel.org
References: <20240201161507.1147521-1-cassel@kernel.org>
 <20240201161507.1147521-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240201161507.1147521-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 01:14, Niklas Cassel wrote:
> Move the marking of an external port earlier in the call chain.
> This is needed for further cleanups.
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/ata/ahci.c    | 14 ++++++++++++++
>  drivers/ata/libahci.c |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..157ab88bdf75 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1642,6 +1642,17 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>  }
>  
> +static void ahci_mark_external_port(struct ata_port *ap)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 tmp;
> +
> +	tmp = readl(port_mmio + PORT_CMD);
> +	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
> +		ap->pflags |= ATA_PFLAG_EXTERNAL;
> +}
> +
>  static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  					   struct ahci_host_priv *hpriv)
>  {
> @@ -1934,6 +1945,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		if (ap->flags & ATA_FLAG_EM)
>  			ap->em_message_type = hpriv->em_msg_type;
>  
> +		/* mark esata ports */
> +		ahci_mark_external_port(ap);

Nit: the comment is rather useless as the function name is clear. It is also
rather incorrect since this is for both esata as well as hot-plug capable ports
(later in the series). So maybe drop it ?

Otherwise, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> +
>  		ahci_update_initial_lpm_policy(ap, hpriv);
>  
>  		/* disabled/not-implemented port */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1a63200ea437..fca376f03c9e 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1280,10 +1280,8 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  			   int port_no, void __iomem *mmio,
>  			   void __iomem *port_mmio)
>  {
> -	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	const char *emsg = NULL;
>  	int rc;
> -	u32 tmp;
>  
>  	/* make sure port is not active */
>  	rc = ahci_deinit_port(ap, &emsg);
> @@ -1291,11 +1289,6 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  		dev_warn(dev, "%s (%d)\n", emsg, rc);
>  
>  	ahci_port_clear_pending_irq(ap);
> -
> -	/* mark esata ports */
> -	tmp = readl(port_mmio + PORT_CMD);
> -	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
> -		ap->pflags |= ATA_PFLAG_EXTERNAL;
>  }
>  
>  void ahci_init_controller(struct ata_host *host)

-- 
Damien Le Moal
Western Digital Research

