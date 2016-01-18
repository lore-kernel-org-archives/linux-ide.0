From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/ide: make ide-scan-pci.c driver explicitly
 non-modular
Date: Mon, 18 Jan 2016 14:13:05 -0500 (EST)
Message-ID: <20160118.141305.2278027302620439950.davem@davemloft.net>
References: <1449697551-16096-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:41988 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558AbcARTNH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2016 14:13:07 -0500
In-Reply-To: <1449697551-16096-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: paul.gortmaker@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 9 Dec 2015 16:45:51 -0500

> The Kconfig for this support is currently:
> 
> config IDEPCI_PCIBUS_ORDER
>         bool "Probe IDE PCI devices in the PCI bus order (DEPRECATED)"
> 
> ...meaning that it currently is not being built as a module by anyone.
> Lets change the initcall to be the equivalent device_initcall, so that
> when reading the driver code, there is no doubt it is builtin-only.
> 
> Unlike other similar changes, we leave the module.h header to be
> included since this code interacts with other drivers and needs to
> know what a struct module is.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
