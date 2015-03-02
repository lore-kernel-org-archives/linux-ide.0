From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata-fsl: Apply link speed limits
Date: Mon, 2 Mar 2015 12:09:22 -0500
Message-ID: <20150302170922.GK17694@htj.duckdns.org>
References: <20150219200547.GA25730@darwin.bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34980 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbbCBRJZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2015 12:09:25 -0500
Received: by qcyl6 with SMTP id l6so25769497qcy.2
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2015 09:09:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150219200547.GA25730@darwin.bork.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Hicks <mort@bork.org>
Cc: Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org

On Thu, Feb 19, 2015 at 03:05:47PM -0500, Martin Hicks wrote:
> 
> 
> The driver was ignoring limits requested by libata.force.  The output
> would look like:
> 
> fsl-sata ffe18000.sata: Sata FSL Platform/CSB Driver init
> ata1: FORCE: PHY spd limit set to 1.5Gbps
> ata1: SATA max UDMA/133 irq 74
> ata1: Signature Update detected @ 0 msecs
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 310)
> 
> Signed-off-by: Martin Hicks <mort@bork.org>

Applied to libata/for-4.0-fixes.

Thanks.

-- 
tejun
