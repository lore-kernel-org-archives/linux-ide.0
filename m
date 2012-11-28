From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_highbank: use ATA_BUSY
Date: Wed, 28 Nov 2012 12:42:36 -0500
Message-ID: <50B64D0C.9020203@pobox.com>
References: <201211012059.29109.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48127 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab2K1Rmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:42:40 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so4790621qad.19
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2012 09:42:39 -0800 (PST)
In-Reply-To: <201211012059.29109.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 11/01/2012 01:59 PM, Sergei Shtylyov wrote:
> ahci_highbank_hardreset() uses bare number for the BSY bit of the ATA status
> register, despite it is #define'd in <linux/ata.h>
>
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>
> ---
> The patch is atop of the 'upstream' branch of libata-dev.git...
>
>   drivers/ata/sata_highbank.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied



