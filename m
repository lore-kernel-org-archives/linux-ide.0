From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: compile out msi/msix infrastructure
Date: Sat, 05 Dec 2015 23:22:49 +0100
Message-ID: <1540836.svMP4lTcYC@wuerfel>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:65153 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbLEWX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Dec 2015 17:23:29 -0500
In-Reply-To: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>, tj@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-ide@vger.kernel.org

On Friday 04 December 2015 11:58:30 Dan Williams wrote:
> +#ifdef CONFIG_PCI_MSI
> +static inline int ahci_irq_vector(struct ahci_host_priv *hpriv, int port)
> +{
> +       if (hpriv->flags & AHCI_HFLAG_MULTI_MSIX)
> +               return hpriv->msix[i].vector;
> +       else
> +               return hpriv->irq + i;
> +}
> 

My randconfig tests now noticed that 'i' is undeclared here. I suppose it
should be 'port' instead of 'i'?

	Arnd
