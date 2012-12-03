From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: set dma_mode to 0xff in reset
Date: Mon, 03 Dec 2012 05:07:37 -0500
Message-ID: <50BC79E9.1030108@pobox.com>
References: <50BBFA94.2070105@intel.com> <50BC1DE6.7080008@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35295 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2LCKHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2012 05:07:40 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1396632qcr.19
        for <linux-ide@vger.kernel.org>; Mon, 03 Dec 2012 02:07:40 -0800 (PST)
In-Reply-To: <50BC1DE6.7080008@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Dutra Julio <dutra.julio@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Szymon Janc <szymon@janc.net.pl>, Bernd Buschinski <b.buschinski@googlemail.com>, linux-ide@vger.kernel.org

On 12/02/2012 10:35 PM, Aaron Lu wrote:
>
> ata_device->dma_mode's initial value is zero, which is not a valid dma
> mode, but ata_dma_enabled will return true for this value. This patch
> sets dma_mode to 0xff in reset function, so that ata_dma_enabled will
> not return true for this case, or it will cause problem for pata_acpi.
>
> The corrsponding bugzilla page is at:
> https://bugzilla.kernel.org/show_bug.cgi?id=49151
>
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Tested-by: Szymon Janc <szymon@janc.net.pl>
> Tested-by: Dutra Julio <dutra.julio@gmail.com>
> Cc: <stable@kernel.org>
> ---
>   drivers/ata/libata-core.c | 1 +
>   drivers/ata/libata-eh.c   | 1 +
>   2 files changed, 2 insertions(+)

applied



