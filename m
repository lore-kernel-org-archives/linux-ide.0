From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 05/64] pata_atiixp: remove superfluous wrapper function
Date: Wed, 20 Jan 2010 23:07:00 -0500
Message-ID: <4B57D2E4.30203@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171427.14623.34958.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58696 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0AUEHH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:07:07 -0500
In-Reply-To: <20100118171427.14623.34958.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:14 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_atiixp: remove superfluous wrapper function
>
> Fix documentation for ->set_[pio,dma]mode methods while at it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_atiixp.c |   29 +++++++----------------------
>   1 file changed, 7 insertions(+), 22 deletions(-)

applied


