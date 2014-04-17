From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/2] ahci: Tweaks to the driver's PCI function
Date: Thu, 17 Apr 2014 09:28:06 -0400
Message-ID: <20140417132806.GA15326@htj.dyndns.org>
References: <cover.1397736364.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:37346 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756333AbaDQN2L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 09:28:11 -0400
Content-Disposition: inline
In-Reply-To: <cover.1397736364.git.agordeev@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Apr 17, 2014 at 02:13:48PM +0200, Alexander Gordeev wrote:
> Changes since v1:
> 	- ahci_is_mrsm() open-coded inside ahci_init_interrupt()
> 	- changelog elaborated
> 
> Cc: linux-ide@vger.kernel.org
> 
> Alexander Gordeev (2):
>   ahci: Ensure "MSI Revert to Single Message" mode is not enforced
>   ahci: Use pci_enable_msi_exact() instead of pci_enable_msi_range()
> 
>  drivers/ata/ahci.c |   19 ++++++++++++++-----
>  drivers/ata/ahci.h |    1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
