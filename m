From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 19/23] libata-sff: ata_sff_irq_clear() is BMDMA specific
Date: Wed, 19 May 2010 13:40:27 -0400
Message-ID: <4BF4228B.4050605@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-20-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59871 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab0ESRka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 13:40:30 -0400
Received: by mail-gw0-f46.google.com with SMTP id a20so1970705gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 10:40:29 -0700 (PDT)
In-Reply-To: <1273520507-32459-20-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> ata_sff_irq_clear() is BMDMA specific.  Rename it to
> ata_bmdma_irq_clear(), move it to ata_bmdma_port_ops and make
> ->sff_irq_clear() optional.
>
> Note: ata_bmdma_irq_clear() is actually only needed by ata_piix and
>        possibly by sata_sil.  This should be moved to respective low
>        level drivers later.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c |   64 +++++++++++++++++++++++++---------------------
>   drivers/ata/pata_bf54x.c |    2 +-
>   drivers/ata/pata_scc.c   |    2 +-
>   drivers/ata/sata_nv.c    |    2 +-
>   drivers/ata/sata_sil.c   |    4 +-
>   drivers/ata/sata_via.c   |    2 +-
>   include/linux/libata.h   |    2 +-
>   7 files changed, 42 insertions(+), 36 deletions(-)

This failed to apply, stopping here:


Applying: libata-sff: ata_sff_irq_clear() is BMDMA specific
error: patch failed: drivers/ata/libata-sff.c:64
error: drivers/ata/libata-sff.c: patch does not apply
error: patch failed: include/linux/libata.h:1586
error: include/linux/libata.h: patch does not apply
Patch failed at 0003 libata-sff: ata_sff_irq_clear() is BMDMA specific
When you have resolved this problem run "git am -i --resolved".
If you would prefer to skip this patch, instead run "git am -i --skip".
To restore the original branch and stop patching run "git am -i --abort".
[jgarzik@bd libata-dev]$ patch -sp1 < .git/rebase-apply/patch
3 out of 9 hunks FAILED -- saving rejects to file 
drivers/ata/libata-sff.c.rej
1 out of 2 hunks FAILED -- saving rejects to file include/linux/libata.h.rej

