From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv3 2/5] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
Date: Fri, 2 May 2014 11:22:37 -0400
Message-ID: <20140502152237.GE10204@htj.dyndns.org>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49959 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbaEBPWl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2014 11:22:41 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so142227qcy.3
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2014 08:22:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397574006-5868-3-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Apr 15, 2014 at 05:00:03PM +0200, Thomas Petazzoni wrote:
> The Marvell Armada 380 SoC includes two AHCI compatible
> interfaces. However, like all DMA-capable Marvell interface, they
> require special handling to configure MBus windows. Therefore, this
> commit adds a new ahci_mvebu driver, which relies on the
> libahci_platform.c code recently introduced.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

How should this be routed?  Can I pick up just this one and apply it
to libata/for-3.16?

Thanks.

-- 
tejun
