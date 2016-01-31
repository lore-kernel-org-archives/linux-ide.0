From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH v2 1/3] ata: Remove the AHCI_HFLAG_EDGE_IRQ support from
 libahci.
Date: Sun, 31 Jan 2016 06:32:49 -0500
Message-ID: <20160131113249.GW32380@htj.duckdns.org>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
 <1453888197-11368-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:33212 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298AbcAaLcv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jan 2016 06:32:51 -0500
Content-Disposition: inline
In-Reply-To: <1453888197-11368-2-git-send-email-stripathi@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Suman Tripathi <stripathi@apm.com>
Cc: olof@lixom.net, arnd@arndb.de, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mlangsdo@redhat.com, jcm@redhat.com, patches@apm.com, svtripathi@gmail.com

On Wed, Jan 27, 2016 at 03:19:55PM +0530, Suman Tripathi wrote:
> This patch removes the AHCI_HFLAG_EDGE_IRQ support from libahci.
> The upcoming patches will have the flexibility to override
> irq handlers in the LLD's. Controller's implementing a EDGE trigger
> latch can implement their own interrupt handler inside the driver.
> 
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

Shouldn't this patch come after the irq override is in place?

1. introduce irq override.

2. remove AHCI_HFLAG_EDGE_IRQ by moving the edge triggered handler to
   ahci_xgene.

3. Update xgene irq handler to address the erratum.

Thanks.

-- 
tejun
