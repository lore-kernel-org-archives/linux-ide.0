From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] AHCI: Conserve interrupts with
 pci_enable_msi_block_part() interface
Date: Tue, 3 Sep 2013 10:18:24 -0400
Message-ID: <20130903141824.GD10522@htj.dyndns.org>
References: <cover.1378111919.git.agordeev@redhat.com>
 <3bb1b4375655ecfde5017cc70973d078f2434d5d.1378111919.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3bb1b4375655ecfde5017cc70973d078f2434d5d.1378111919.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Sep 02, 2013 at 11:00:28AM +0200, Alexander Gordeev wrote:
> +	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
> +		goto intx;
> +
> +	rc = pci_enable_msi_block_part(pdev, n_ports, AHCI_MAX_PORTS);
> +	if (!rc)
> +		return AHCI_MAX_PORTS;
> +	if (rc < 0)
> +		goto intx;
> +
> +	maxvec = rc;
> +	rc = pci_enable_msi_block_part(pdev, n_ports, maxvec);
> +	if (!rc)
> +		return maxvec;
> +	if (rc < 0)
> +		goto intx;

Why is the above fallback necessary?  The only other number which
makes sense is roundup_pow_of_two(n_ports), right?  What does the
above fallback logic buy us?

Thanks.

-- 
tejun
