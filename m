From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ahci: compile out msi/msix infrastructure
Date: Fri, 04 Dec 2015 22:46:19 +0100
Message-ID: <2378126.FJZNlQmf9U@wuerfel>
References: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51378 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbLDVq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2015 16:46:59 -0500
In-Reply-To: <20151204195830.2300.48789.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>, tj@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-ide@vger.kernel.org

On Friday 04 December 2015 11:58:30 Dan Williams wrote:
> Quoting Arnd:
>     The AHCI driver is used for some on-chip devices that do not use PCI
>     for probing, and it can be built even when CONFIG_PCI is disabled, but
>     that now results in a build failure:
> 
>     ata/libahci.c: In function 'ahci_host_activate_multi_irqs':
>     ata/libahci.c:2475:4: error: invalid use of undefined type 'struct msix_entry'
>     ata/libahci.c:2475:21: error: dereferencing pointer to incomplete type 'struct msix_entry'
> 
> Add ifdef CONFIG_PCI_MSI infrastructure to compile out the mutli-msi and
> multi-msix code.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Fixes: d684a90d38e2 ("ahci: per-port msix support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks a lot, looks good. I've verified that this fixes the build on the
configuration that failed earlier.

Tested-by: Arnd Bergmann <arnd@arndb.de>
