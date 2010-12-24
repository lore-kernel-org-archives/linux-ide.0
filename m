From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata-sff: fix HSM_ST_ERR handling in
 __ata_sff_port_intr()
Date: Fri, 24 Dec 2010 16:20:10 +0100
Message-ID: <20101224152010.GD11419@htj.dyndns.org>
References: <4CF8FC61.8060606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41580 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0LXPUP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 10:20:15 -0500
Received: by bwz15 with SMTP id 15so8266602bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 07:20:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF8FC61.8060606@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Antonio Toma <antonio.toma@gmail.com>, stable <stable@kernel.org>

On Fri, Dec 03, 2010 at 03:19:13PM +0100, Tejun Heo wrote:
> While separating out BMDMA irq handler from SFF, commit c3b28894
> (libata-sff: separate out BMDMA irq handler) incorrectly made
> __ata_sff_port_intr() consider an IRQ to be an idle one if the host
> state was transitioned to HSM_ST_ERR by ata_bmdma_port_intr().
> 
> This makes BMDMA drivers ignore IRQs reporting host bus error which
> leads to timeouts instead of triggering EH immediately.  Fix it by
> making __ata_sff_port_intr() consider the IRQ to be an idle one iff
> the state is HSM_ST_IDLE.  This is equivalent to adding HSM_ST_ERR to
> the "break"ing case but less error-prone.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Antonio Toma <antonio.toma@gmail.com>
> Cc: stable@kernel.org

Ping.

-- 
tejun
