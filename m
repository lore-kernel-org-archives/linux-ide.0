From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 22/64] pata_via: fix address setup timings underlocking
Date: Wed, 20 Jan 2010 23:19:08 -0500
Message-ID: <4B57D5BC.5020107@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171703.14623.85025.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62518 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab0AUETK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:19:10 -0500
In-Reply-To: <20100118171703.14623.85025.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:17 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_via: fix address setup timings underlocking
>
> Correct via_do_set_mode() documentation while at it.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_via.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied


