From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Fri, 11 May 2007 13:49:07 +0200
Message-ID: <46445833.7050707@gmail.com>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:52602 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877AbXEKLtU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 07:49:20 -0400
Received: by py-out-1112.google.com with SMTP id a29so762208pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 04:49:19 -0700 (PDT)
In-Reply-To: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org, pchen@nvidia.com
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

akpm@linux-foundation.org wrote:
> From: "Peer Chen" <pchen@nvidia.com>
> 
> Because nvidia SATA controllers onward base on AHCI, so wildcard in sata_nv
> driver is unnecessary.  Also the wildcard sometimes cause sata_nv driver to
> be loaded for AHCI controllers,which is not as expected.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Peer Chen, are you sure we don't miss any existing devices by doing
this?  Also, what would future nvidia chips look like?  AHCI only or
dual mode similar ICHs?  If compatible mode is going to be supported &&
there is no switch we can mangle from PCI quirks to put it into AHCI
mode, we might wanna keep PCI_CLASS_STORAGE_IDE assuming compatible mode
interface remains similar.

Thanks.

-- 
tejun
