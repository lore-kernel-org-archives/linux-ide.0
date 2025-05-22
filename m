Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF5EC5;
	Thu, 22 May 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892534; cv=none; b=FerovFpXE+mQb1Z2gyJs6UkR/F343E7d6/xI4NsnIzPiiqcPPnqidVG7hSbD+lvTFelfrzqEQHiuT7wlb6pvTXsVbg/f2c3X2e67AIcjw0QWSy+ELq6QZIxPIEktFzt61DnsQVZKDHvWFd4ATwbuX0OCEBveNiB0xOzyJ9wkT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892534; c=relaxed/simple;
	bh=Gsl0A+mUiZm5EgNLD2YmW7f34cAHku12HXPI8S2xs4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hp3da9wbT9N0pDXRhwDzIyZ3qdwZv4ajo8rcV5AD2ZW4wsHWouI4xfINEPWvTrF1BSYXQrDbrWQEqX1knx0vlSMZBx3VVc6BLGBaIp2Suek9QZoGAz/OP4XXdzm9U18w4a5qo9/1yjJSes2v4DEDWki/XWYMcvfZwAYw+VhfSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz3rHimb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz3rHimb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4F8C4CEE4;
	Thu, 22 May 2025 05:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747892534;
	bh=Gsl0A+mUiZm5EgNLD2YmW7f34cAHku12HXPI8S2xs4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iz3rHimbAIVGVoEDmLbfHdgWz5Me3AEJqljD7wU/1n8gUUfuRCtLvrLAyI3F6+QUA
	 nCol6TdKSGpymSNoobMPrbzbQnXZlxMlfsUqhHYDYwo6aidP3B1K8aIMbG/TiBZKEM
	 GZQ6aA7Z/LwwI2kt6asUBXaHuDAwgU42k6gDTTCg4moQ7oktYExlBZ9R4yfLkpD4Eh
	 VptQzkdeAQSZVM+28YrTvZ3kucv7W4zOhNBI/+ss4ah7a8r9X9djHOvCg50YB32pov
	 25Aykr7O/p8+GybQ61lzUMg8FG6E0p7bxdtK5ceJxmhyeZHxSbV+DBD3pU71oTGjP7
	 hfMFmwAKSDwpw==
Message-ID: <f2db43ab-97d0-4731-9b51-18876f342b42@kernel.org>
Date: Thu, 22 May 2025 07:42:11 +0200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ahci: enhance error handling and resource management
 in ahci_init_one
To: Alexander Roman <monderasdor@gmail.com>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250519221334.1802-1-monderasdor@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250519221334.1802-1-monderasdor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/25 00:13, Alexander Roman wrote:
> Problem:

This is not needed. It is clear that you are describing the problem.

> The current implementation of ahci_init_one has several issues with error handling
> and resource management. It lacks proper error cleanup paths, doesn't initialize
> pointers to NULL, and has inconsistent error handling patterns throughout the code.
> This can lead to resource leaks and make debugging initialization failures difficult.
> 
> Solution:

Same here. It is clear you are describing how you solve the problem.

> This patch enhances the error handling and resource management in ahci_init_one by:
> - Adding comprehensive error checking with descriptive error messages
> - Improving error propagation through return codes
> - Adding proper error cleanup paths for all resource allocations
> - Initializing pointers to NULL to prevent use-after-free bugs
> - Implementing proper cleanup of allocated resources in error paths
> - Adding more descriptive error messages for all failure points
> - Including error codes in log messages for better diagnostics
> - Adding warning messages for potential system issues
> - Improving code structure with proper error handling paths
> - Adding proper error return labels
> - Making code more maintainable with consistent error handling patterns
> 
> Technical Details:

Integrate that in the previous section please.

> - Added proper initialization of pointers (hpriv, host) to NULL
> - Added error cleanup paths with proper resource release
> - Improved error messages to include specific error codes
> - Added proper error handling for all resource allocation failures
> - Added proper cleanup of allocated resources in error paths
> - Improved code organization with clear error handling paths
> - Added proper error return labels for better code flow
> 
> Note: Some error checks and logging have been simplified to reduce churn while
> maintaining robust error handling. The focus is on critical error paths and
> resource management rather than redundant checks. Log levels have been adjusted
> to use dev_warn for non-fatal warnings and dev_dbg for quirk failures.
> 
> Signed-off-by: Alexander Roman <monderasdor@gmail.com>]

Please send patches to the maintainers too.

> ---
>  drivers/ata/ahci.c | 150 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 85 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1611,460 +1611,555 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent) {
>      struct ahci_host_priv *hpriv = NULL;
>      struct ata_host *host = NULL;
>      void __iomem *mmio = NULL;
> +    int n_ports, i, rc = -ENOMEM;
> -    int n_ports, i, rc;
>      u32 tmp, cap, port_map;
>      u32 saved_cap;
>      struct device *dev = &pdev->dev;
> 
>      VPRINTK("ahci_init_one enter\n");

This is old code. What is this patch against ???
This code does not exist since a long time ago. Please rebase.

> 
> +    /* acquire resources with proper error handling */
> -    /* acquire resources */

The original comment was not useful. Making it more detailed still does not make
it useful as it is very clear what this code hunk does. I would be more in favor
of completely dropping this useless comment.

>      rc = pcim_enable_device(pdev);
>      if (rc) {
> +        dev_err(dev, "Failed to enable PCI device: %d\n", rc);
> +        goto err_out;

Wrong indentation.

> -        return rc;
>      }
> 
>      rc = pcim_iomap_regions(pdev, 1 << AHCI_PCI_BAR_STANDARD, DRV_NAME);
>      if (rc) {
> +        dev_err(dev, "Failed to map PCI regions: %d\n", rc);
> +        goto err_out;
> -        return rc;
>      }
>      mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR_STANDARD];
> 
>      rc = pci_alloc_irq_vectors(pdev, 1, AHCI_MAX_PORTS, PCI_IRQ_ALL_TYPES);
>      if (rc < 0) {
> +        dev_err(dev, "Failed to allocate IRQ vectors: %d\n", rc);
> +        goto err_out;
> -        return rc;
>      }
> 
> +    /* allocate and initialize host private data */

Same here: comment not needed. It is clear what the code does. Please only add
comments for describing things that are not obvious.

>      hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
>      if (!hpriv) {
> +        dev_err(dev, "Failed to allocate host private data\n");
> +        goto err_out;
> -        return -ENOMEM;
>      }
> 
>      hpriv->mmio = mmio;
>      hpriv->flags = (unsigned long)ent->driver_data;
>      hpriv->irq = pdev->irq;
> 
> +    /* apply board quirks */
>      if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +        rc = ahci_intel_pcs_quirk(pdev, hpriv);
> +        if (rc) {
> +            dev_dbg(dev, "Intel PCS quirk failed (%d)\n", rc);
> +            goto err_host;
> +        }
> -        ahci_intel_pcs_quirk(pdev, hpriv);
>      }
> 
> +    /* apply port map mask if present */

Comment not needed.

>      ahci_get_port_map_mask(dev, hpriv);
> 
> +    /* save initial config */

Here too.

>      rc = ahci_pci_save_initial_config(pdev, hpriv);
>      if (rc) {
> +        dev_err(dev, "Failed to save initial configuration: %d\n", rc);
> +        goto err_out;
> -        return rc;
>      }
> 
> +    /* prepare host */

Same.

>      cap = hpriv->cap;
>      saved_cap = cap;
>      port_map = hpriv->port_map;
>      n_ports = ahci_calc_n_ports(cap, port_map);
> 
>      host = ata_host_alloc_pinfo(dev, ahci_port_info + ent->driver_data, n_ports);
>      if (!host) {
> +        dev_err(dev, "Failed to allocate ATA host\n");
> +        goto err_out;
> -        return -ENOMEM;
>      }
> 
>      host->private_data = hpriv;
> 
> +    /* configure DMA masks */

Again...

>      rc = ahci_configure_dma_masks(pdev, hpriv);
>      if (rc) {
> +        dev_err(dev, "Failed to configure DMA masks: %d\n", rc);
> +        goto err_host;
> -        return rc;
>      }
> 
> +    /* initialize adapter */

And again... I stop here. You see my point. The function names are clear enough...

>      ahci_pci_init_controller(host);
>      rc = ahci_reset_controller(host);
>      if (rc) {
> +        dev_err(dev, "Failed to reset controller: %d\n", rc);
> +        goto err_host;
> -        return rc;
>      }
> 
> +    /* apply fixups for broken systems */
>      if (ahci_broken_system_poweroff(pdev)) {
> +        dev_warn(dev, "System may need power cycle after shutdown\n");
> -        dev_info(dev, "quirky BIOS, skipping spindown on poweroff\n");
>      }
> 
> +    /* configure LPM policy */
>      for (i = 0; i < n_ports; i++) {
>          ahci_update_initial_lpm_policy(host->ports[i]);
>      }
> 
> +    /* apply platform-specific workarounds */
>      if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +        rc = ahci_intel_pcs_quirk(pdev, hpriv);
> +        if (rc) {
> +            dev_dbg(dev, "Intel PCS quirk failed (%d)\n", rc);
> +            goto err_host;
> +        }
> -        ahci_intel_pcs_quirk(pdev, hpriv);
>      }
> 
> +    /* apply Apple MCP89 workaround */
>      if (is_mcp89_apple(pdev)) {
> +        rc = ahci_mcp89_apple_enable(pdev);
> +        if (rc) {
> +            dev_err(dev, "Failed to enable MCP89 Apple: %d\n", rc);
> +            goto err_host;
> +        }
> -        ahci_mcp89_apple_enable(pdev);
>      }
> 
> +    /* apply Acer SA5-271 workaround */
>      acer_sa5_271_workaround(hpriv, pdev);
> 
> +    /* initialize and enable interrupts */
>      ahci_init_irq(pdev, n_ports, hpriv);
>      ahci_pci_enable_interrupts(host);
> 
> +    /* print information */
>      ahci_pci_print_info(host);
> 
> +    /* register with libata */
>      rc = ata_host_activate(host, hpriv->irq, ahci_interrupt, IRQF_SHARED,
> +                        &ahci_sht);
> -                        &ahci_sht);
>      if (rc) {
> +        dev_err(dev, "Failed to activate ATA host: %d\n", rc);
> +        goto err_host;
> -        return rc;
>      }
> 
>      return 0;
> 
> +err_host:
> +    ata_host_detach(host); // host is NULL-checked internally
> +err_out:
> +    return rc;
> -    return 0;
>  }
> 


-- 
Damien Le Moal
Western Digital Research
