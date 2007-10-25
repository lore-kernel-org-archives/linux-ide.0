From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] IDE updates (part 2)
Date: Thu, 25 Oct 2007 02:05:35 -0400
Message-ID: <4720322F.5070508@garzik.org>
References: <200710131825.24768.bzolnier@gmail.com> <20071014001238.GP8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51519 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189AbXJYGFl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:05:41 -0400
In-Reply-To: <20071014001238.GP8181@ftp.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk

Al Viro wrote:
> Proposed addition to icside part, provided that ARM folks ACK it - gets
> icside to build and AFAICS it's correct:
> 
> diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
> index be30923..842fe08 100644
> --- a/drivers/ata/pata_icside.c
> +++ b/drivers/ata/pata_icside.c
> @@ -332,12 +332,13 @@ static void ata_dummy_noret(struct ata_port *port)

applied


