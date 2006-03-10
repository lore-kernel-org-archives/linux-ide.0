From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC 0/5] libata-dev: integrate polling pio with irq-pio
Date: Fri, 10 Mar 2006 18:38:00 +0900
Message-ID: <20060310093800.GE20207@htj.dyndns.org>
References: <440FEA4B.10500@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:4705 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752194AbWCJJ4E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 04:56:04 -0500
Received: by zproxy.gmail.com with SMTP id 13so711392nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 01:56:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440FEA4B.10500@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, Mar 09, 2006 at 04:41:47PM +0800, Albert Lee wrote:
> This patch set integrates polling pio with irq-pio.
> 
> Changes:
> 1/5: Move out the HSM code from ata_host_intr() to the new ata_hsm_move() function.
> 2/5: Minor fix for ata_hsm_move() to work with ata_host_intr()
> 3/5: Let ata_hsm_move() work with both irq-pio and polling pio
> 4/5: Convert ata_pio_task() to use the new ata_hsm_move()
> 5/5: Cleanup unused enums/functions.
> 
> Patch against irq-pio branch (c2956a3b0d1c17b38da369811a6ce93eb7a01a04). 
> Minimally tested ok on x86. 
> 

Nice changes.  I hope this makes #irq-pio one step closer to
#upstream.  Thanks for the good work.  :-)

-- 
tejun
