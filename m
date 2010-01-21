From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 13/64] pata_cs5535: use correct values for PIO1 and PIO2
 data timings
Date: Wed, 20 Jan 2010 23:16:14 -0500
Message-ID: <4B57D50E.9090907@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171538.14623.27441.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:38534 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab0AUEQT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:16:19 -0500
In-Reply-To: <20100118171538.14623.27441.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_cs5535: use correct values for PIO1 and PIO2 data timings
>
> There shouldn't be any problems with it as IDE cs5535 host driver
> has been using those values for years and they match values given
> in the (publicly available) datasheet.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_cs5535.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied 13-14


