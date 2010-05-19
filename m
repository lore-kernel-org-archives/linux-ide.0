From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 17/23] libata-sff: prd is BMDMA specific
Date: Wed, 19 May 2010 13:39:53 -0400
Message-ID: <4BF42269.6060609@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-18-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59871 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0ESRkH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 13:40:07 -0400
Received: by gwaa20 with SMTP id a20so1970705gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 10:40:06 -0700 (PDT)
In-Reply-To: <1273520507-32459-18-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> struct ata_prd and ap->prd are BMDMA specific.  Add bmdma_ prefix to
> them and move them inside CONFIG_ATA_SFF.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c   |   27 +++++++++++++++------------
>   drivers/ata/pata_ns87415.c |    2 +-
>   drivers/ata/pata_scc.c     |    4 ++--
>   drivers/ata/sata_nv.c      |    4 ++--
>   drivers/ata/sata_promise.c |   21 +++++++++++----------
>   drivers/ata/sata_sil.c     |    6 +++---
>   drivers/ata/sata_svw.c     |    2 +-
>   include/linux/ata.h        |    2 +-
>   include/linux/libata.h     |    5 ++---
>   9 files changed, 38 insertions(+), 35 deletions(-)

applied 17-18


