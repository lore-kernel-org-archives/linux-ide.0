From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: add proper cable detection methods
Date: Mon, 23 Nov 2009 22:42:23 +0300
Message-ID: <4B0AE59F.7040202@ru.mvista.com>
References: <200911191910.44609.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:6728 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755098AbZKWTlc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 14:41:32 -0500
In-Reply-To: <200911191910.44609.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_hpt37x.c |   86 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 56 insertions(+), 30 deletions(-)

> Index: b/drivers/ata/pata_hpt37x.c
> ===================================================================
> --- a/drivers/ata/pata_hpt37x.c
> +++ b/drivers/ata/pata_hpt37x.c
> @@ -303,6 +303,59 @@ static unsigned long hpt370a_filter(stru

    As this driver still carries a version info, don't we need to update it?

MBR, Sergei
