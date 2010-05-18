From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 16/23] libata-sff: ata_sff_[dumb_]qc_prep are BMDMA specific
Date: Mon, 17 May 2010 23:05:53 -0400
Message-ID: <4BF20411.60402@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-17-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63048 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab0ERDF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:05:56 -0400
Received: by gwaa20 with SMTP id a20so902997gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:05:55 -0700 (PDT)
In-Reply-To: <1273520507-32459-17-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> Both qc_prep functions deal only with BMDMA PRD setup and PIO only SFF
> drivers don't need them.  Rename to ata_bmdma_[dumb_]qc_prep() and
> relocate.
>
> All usages are renamed except for pdc_adma and sata_qstor.  Those two
> drivers are not BMDMA drivers and don't need to call BMDMA qc_prep
> functions.  Calls to ata_sff_qc_prep() in the two drivers are removed.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c  |  290 +++++++++++++++++++++++----------------------
>   drivers/ata/pata_atiixp.c |    2 +-
>   drivers/ata/pata_cs5520.c |    2 +-
>   drivers/ata/pata_cs5530.c |    2 +-
>   drivers/ata/pata_sc1200.c |    2 +-
>   drivers/ata/pdc_adma.c    |    4 +-
>   drivers/ata/sata_nv.c     |    4 +-
>   drivers/ata/sata_qstor.c  |    4 +-
>   include/linux/libata.h    |    4 +-
>   9 files changed, 156 insertions(+), 158 deletions(-)

ack


