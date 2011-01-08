From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_hpt37x: actually limit HPT370 to UltraDMA/66
Date: Fri, 07 Jan 2011 22:34:53 -0500
Message-ID: <4D27DB5D.8090401@pobox.com>
References: <201101052159.49796.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53892 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab1AHDe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 22:34:58 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so7391603vws.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 19:34:57 -0800 (PST)
In-Reply-To: <201101052159.49796.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On 01/05/2011 01:59 PM, Sergei Shtylyov wrote:
> The driver clearly tries to limit HPT370[A] to UltraDMA/66 if the PCI clock is
> less than 50 MHz but due to cut&paste type mistake this code has no effect...
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree plus 2 patches that I posted
> before:
>
> http://marc.info/?l=linux-ide&m=129330632207779
> http://marc.info/?l=linux-ide&m=129356704826019
>
>   drivers/ata/pata_hpt37x.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

applied


