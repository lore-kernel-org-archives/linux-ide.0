From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata-sff: fix HSM_ST_ERR handling in
 __ata_sff_port_intr()
Date: Fri, 24 Dec 2010 13:39:12 -0500
Message-ID: <4D14E8D0.8090800@garzik.org>
References: <4CF8FC61.8060606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33917 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab0LXSjQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Dec 2010 13:39:16 -0500
Received: by qyj19 with SMTP id 19so8892125qyj.19
        for <linux-ide@vger.kernel.org>; Fri, 24 Dec 2010 10:39:15 -0800 (PST)
In-Reply-To: <4CF8FC61.8060606@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Antonio Toma <antonio.toma@gmail.com>, stable <stable@kernel.org>

On 12/03/2010 09:19 AM, Tejun Heo wrote:
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
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Antonio Toma<antonio.toma@gmail.com>
> Cc: stable@kernel.org
> ---
>   drivers/ata/libata-sff.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

applied


