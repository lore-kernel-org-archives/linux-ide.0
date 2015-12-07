From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ahci: compile out msi/msix infrastructure
Date: Mon, 7 Dec 2015 09:50:43 -0500
Message-ID: <20151207145043.GB9175@mtj.duckdns.org>
References: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33706 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbbLGOup (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2015 09:50:45 -0500
Received: by ykdv3 with SMTP id v3so196529006ykd.0
        for <linux-ide@vger.kernel.org>; Mon, 07 Dec 2015 06:50:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151206001323.35162.30974.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org

On Sat, Dec 05, 2015 at 04:18:44PM -0800, Dan Williams wrote:
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
> Tested--by: Arnd Bergmann <arnd@arndb.de>
> [arnd: fix up pci enabled case]
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Fixes: d684a90d38e2 ("ahci: per-port msix support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Applied to libata/for-4.5 w/ the typo fixed.

Thanks.

-- 
tejun
