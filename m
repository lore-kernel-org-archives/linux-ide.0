From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci_platform: Provide for vendor specific init
Date: Fri, 25 Jun 2010 03:26:58 -0400
Message-ID: <4C245A42.1070203@pobox.com>
References: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50571 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0FYH1D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 03:27:03 -0400
Received: by gxk28 with SMTP id 28so1174073gxk.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 00:27:01 -0700 (PDT)
In-Reply-To: <1277441858-26993-1-git-send-email-jassisinghbrar@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, Jassi Brar <jassi.brar@samsung.com>

On 06/25/2010 12:57 AM, Jassi Brar wrote:
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
>   drivers/ata/ahci_platform.c   |   23 +++++++++++++----------
>   include/linux/ahci_platform.h |    2 +-
>   2 files changed, 14 insertions(+), 11 deletions(-)

It is also possible that platforms may need the init to prep the MMIO 
area for use?  Anton, does this patch work for you, or introduce such a 
problem?

Thanks,

	Jeff





