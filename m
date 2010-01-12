From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.33-rc3] sata_promise: don't classify overruns as HSM
 errors
Date: Tue, 12 Jan 2010 14:38:31 -0500
Message-ID: <4B4CCFB7.6090108@pobox.com>
References: <19273.998.753256.526176@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:45885 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0ALTie (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Jan 2010 14:38:34 -0500
Received: by yxe17 with SMTP id 17so21719035yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 12 Jan 2010 11:38:33 -0800 (PST)
In-Reply-To: <19273.998.753256.526176@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org, thomas schorpp <thomas.schorpp@googlemail.com>

On 01/09/2010 05:32 PM, Mikael Pettersson wrote:
> When sata_promise encounters an overrun or underrun error it
> translates that to a libata AC_ERR_HSM, causing a hard reset.
> Since over/under-runs were thought to be rare and transient,
> this action seemed reasonable.
>
> Unfortunately it turns out that the controller throws overrun
> errors when e.g. hal polls a CD or DVD writer containing blank
> media, causing long sequences of hard resets and retries before
> EH finally gives up.
>
> This patch updates sata_promise to classify over/under-runs as
> AC_ERR_OTHER instead. This allows libata EH and upper layers to
> retry or fail the operation as they see fit without the disruption
> caused by repeated hard resets.
>
> This fixes a problem using a DVD-RAM drive with sata_promise,
> reported by Thomas Schorpp. I also tested it on a DVD-RW drive.
>
> Signed-off-by: Mikael Pettersson<mikpe@it.uu.se>
> Tested-by: thomas schorpp<thomas.schorpp@googlemail.com>
> ---
>   drivers/ata/sata_promise.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied


