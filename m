From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/3] git-libata: fix CONFIG_PCI=n build
Date: Sat, 29 Mar 2008 10:04:19 +0900
Message-ID: <47ED9593.3040100@gmail.com>
References: <200803282133.m2SLXj7h011457@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:27122 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbYC2BEZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 21:04:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so275518rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2008 18:04:25 -0700 (PDT)
In-Reply-To: <200803282133.m2SLXj7h011457@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> sh allmodconfig:
> 
> drivers/ata/libata-core.c:127: error: `ata_pci_default_filter' undeclared here (not in a function)
> drivers/ata/libata-core.c:127: error: initializer element is not constant
> drivers/ata/libata-core.c:127: error: (near initialization for `ata_bmdma_port_ops.mode_filter')
> 
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

There's a pending patch to pull ata_pci_default_filter() out of 
CONFIG_PCI as there's nothing PCI specific about it but this is a 
correct fix.  Jeff, if you're gonna merge the modularize-SFF patchset, 
this one isn't necessary.  If not, please go ahead and merge this.

Thanks.

-- 
tejun
