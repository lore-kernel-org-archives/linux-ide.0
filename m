From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patch] libata build fix
Date: Fri, 19 Oct 2007 22:57:16 -0400
Message-ID: <47196E8C.5040003@garzik.org>
References: <20071015221329.GA8778@havoc.gtf.org> <200710170123.43244.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58414 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754410AbXJTC5W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Oct 2007 22:57:22 -0400
In-Reply-To: <200710170123.43244.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 16 October 2007, Jeff Garzik wrote:
> 
>> Jeff Garzik (1):
>>       [libata] pata_cs5536: new API build fix
> 
> We probably need also this one for pata_cs5536:
> 
> [PATCH] pata_cs5536: MWDMA fix
> 
> * Fix out-of-bound array access for MWDMA modes.
> 
> * Bump driver version.
> 
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_cs5536.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

applied


