From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHv2] ahci_platform: Provide for vendor specific init
Date: Thu, 01 Jul 2010 15:30:02 -0400
Message-ID: <4C2CECBA.2080202@pobox.com>
References: <1277457679-14171-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40746 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab0GATaI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 15:30:08 -0400
Received: by gxk23 with SMTP id 23so1270202gxk.19
        for <linux-ide@vger.kernel.org>; Thu, 01 Jul 2010 12:30:07 -0700 (PDT)
In-Reply-To: <1277457679-14171-1-git-send-email-jassisinghbrar@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, Jassi Brar <jassi.brar@samsung.com>

On 06/25/2010 05:21 AM, Jassi Brar wrote:
> From: Jassi Brar<jassi.brar@samsung.com>
>
> Some AHCI implementations may use Vendor Specific HBA[A0h, FFh]
> and/or Port[70h, 7Fh] registers to 'prepare' for initialization.
> For that, the platform needs memory mapped address of AHCI registers.
>
> This patch adds the 'mmio' argument and reorders the call to
> platform init function.
>
> Signed-off-by: Jassi Brar<jassi.brar@samsung.com>
> ---
>   drivers/ata/ahci_platform.c   |   25 +++++++++++++++----------
>   include/linux/ahci_platform.h |    4 +++-
>   2 files changed, 18 insertions(+), 11 deletions(-)

applied


