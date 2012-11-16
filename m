From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_svw: check DMA start bit before reset
Date: Thu, 15 Nov 2012 23:55:09 -0500
Message-ID: <50A5C72D.4020206@pobox.com>
References: <1351551622-1193-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52288 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2KPEzN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 23:55:13 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so2498441vbb.19
        for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 20:55:12 -0800 (PST)
In-Reply-To: <1351551622-1193-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, caiqian@redhat.com

On 10/29/2012 07:00 PM, David Milburn wrote:
> If kdump is triggered with pending IO, controller may not respond causing
> kdump to fail.
>
> http://marc.info/?l=linux-ide&m=133032255424658&w=2
>
> During error recovery ata_do_dev_read_id never completes due hang
> in mmio_insw.
>
> ata_do_dev_read_id
>   ata_sff_data_xfer
>    ioread16_rep
>     mmio_insw
>
> if DMA start bit is cleared before reset, PIO command is successful
> and kdump succeeds.
>
> Signed-off-by: David Milburn <dmilburn@redhat.com>
> ---
>   drivers/ata/sata_svw.c |   35 +++++++++++++++++++++++++++++++++++
>   1 files changed, 35 insertions(+), 0 deletions(-)

applied



