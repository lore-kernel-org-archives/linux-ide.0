From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH] AHCI: Clear GHC.IS to prevent unexpectly asserting INTx
Date: Wed, 20 Jul 2016 11:11:27 -0400
Message-ID: <20160720151127.GA4574@htj.duckdns.org>
References: <HK2PR03MB1732DDEDFCE52EB9A76DA1B0FC080@HK2PR03MB1732.apcprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33764 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbcGTPMD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jul 2016 11:12:03 -0400
Content-Disposition: inline
In-Reply-To: <HK2PR03MB1732DDEDFCE52EB9A76DA1B0FC080@HK2PR03MB1732.apcprd03.prod.outlook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pang Raymond <Raymond_rule@hotmail.com>
Cc: ide linux <linux-ide@vger.kernel.org>, kernel linux <linux-kernel@vger.kernel.org>

On Wed, Jul 20, 2016 at 12:13:46PM +0000, Pang Raymond wrote:
> 
> Due to PCI subsystem behaviour, unloading AHCI driver will disable 
> MSI and enable INTx. When HBA supports MSIx or Multiple MSI, Driver's
> irq handler doesn't clear GHC.IS register. It works well when reading or
> writing data and GHC.IS is always non-zero. But when unloading driver
> (or any other operation which causes disable MSIx and enable INTx), PCI
>  subsystem uses config write(Rx04.bit10) to enable INTx. Because
> GHC.IS is non-zero, HBA will falsely assume some port needs interrupt 
> service. Then it asserts INTx. To make things worse, when AHCI controller
> shares the same interrupt pin with other PCI device, that PCI device's ISR
> will be called and nobody de-asserts previous INTx.
> This patch clears GHC.IS in ahci_port_stop() even when using MSIx or 
> MMSI to prevent this case. It ensures GHC.IS is zero before PCI subsystem 
> enables INTx.
> 
> Signed-off-by: Raymond Pang <raymond_rule@hotmail.com>

Applied to libata/for-4.8 with minor updates to the comment.

Thanks.

-- 
tejun
