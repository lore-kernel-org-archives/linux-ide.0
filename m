From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RESEND PATCH] ata: Intel IDE-R support
Date: Tue, 28 Sep 2010 14:52:43 -0400
Message-ID: <4CA2397B.6070407@garzik.org>
References: <20100928121928.323.79399.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43503 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757047Ab0I1Sws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Sep 2010 14:52:48 -0400
Received: by qwh6 with SMTP id 6so4250163qwh.19
        for <linux-ide@vger.kernel.org>; Tue, 28 Sep 2010 11:52:47 -0700 (PDT)
In-Reply-To: <20100928121928.323.79399.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 09/28/2010 08:19 AM, Alan Cox wrote:
> Intel IDE-R devices are part of the Intel AMT management setup. They don't
> have any special configuration registers or settings so the ata_generic
> driver will support them fully.
>
> Rather than add a huge table of IDs for each chipset and keep sending in
> new ones this patch autodetects them.
>
> [Added some further comments]
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> Acked-by: Tejun Heo<tj@kernel.org>
> ---
>
>   drivers/ata/ata_generic.c |   54 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 53 insertions(+), 1 deletions(-)

thanks, was waiting for it :)


