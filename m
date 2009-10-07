From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] pata_atp867x: fix it to not claim MWDMA support
Date: Tue, 06 Oct 2009 21:03:49 -0400
Message-ID: <4ACBE8F5.40401@garzik.org>
References: <200910070026.57226.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [207.36.208.214] ([207.36.208.214]:38312 "EHLO mail.dvmed.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933159AbZJGBE2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 21:04:28 -0400
In-Reply-To: <200910070026.57226.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "Jung-Ik Lee (John)" <jilee@google.com>, linux-ide@vger.kernel.org

On 10/06/2009 06:26 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] pata_atp867x: fix it to not claim MWDMA support
>
> MWDMA modes are not supported by this driver currently.
>
> Acked-by: Jung-Ik (John) Lee<jilee@google.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/pata_atp867x.c |   10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)

applied 1-4


