From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_highbank: make ahci_highbank_pm_ops static
Date: Wed, 03 Apr 2013 19:56:05 -0400
Message-ID: <515CC195.8070700@pobox.com>
References: <006801ce243f$1960ffd0$4c22ff70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:53528 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762128Ab3DCX4H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Apr 2013 19:56:07 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so1154639qaj.20
        for <linux-ide@vger.kernel.org>; Wed, 03 Apr 2013 16:56:07 -0700 (PDT)
In-Reply-To: <006801ce243f$1960ffd0$4c22ff70$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On 03/18/2013 09:14 PM, Jingoo Han wrote:
> Make ahci_highbank_pm_ops static because ahci_highbank_pm_ops is
> not exported.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/ata/sata_highbank.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

applied



