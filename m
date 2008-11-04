From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata-rb532-cf: read and write data in 4-byte blocks
Date: Tue, 04 Nov 2008 01:01:25 -0500
Message-ID: <490FE535.8080109@garzik.org>
References: <490E1A63.3040507@ru.mvista.com> <1225718954-8307-1-git-send-email-n0-1@freewrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45576 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbYKDGBa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 01:01:30 -0500
In-Reply-To: <1225718954-8307-1-git-send-email-n0-1@freewrt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Phil Sutter wrote:
> * rename the offset definition to avoid abiguity with the standard ATA
>   IO address
> * read and write four bytes at once
> * use writesl() and readsl() which implicitly iterate over the data
> * fix the signature of rb532_pata_data_xfer() to match the function
>   pointer definition and return the number of bytes consumed
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
> ---
>  drivers/ata/pata_rb532_cf.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)

None of this description says _why_ you wish to do this.  Also, maybe I 
missed the response, what about ATAPI?

	Jeff



