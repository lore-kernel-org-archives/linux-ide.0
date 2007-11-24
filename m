From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sil680: kill bogus reset code (take 2)
Date: Fri, 23 Nov 2007 19:24:22 -0500
Message-ID: <47476F36.4030201@garzik.org>
References: <200711161950.04670.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36775 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbXKXAYZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:24:25 -0500
In-Reply-To: <200711161950.04670.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Sergei Shtylyov wrote:
> Since writing to two reserved bits ain't much of a housekeeping, I think it's
> time we get rid of the custom error handler in this driver. ;-)
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Oops, somehow I've managed to send a stale patch, without a version change...
> This code has been discussed 4 months ago, and is still in the same state. :-|
> The patch is against the Linus' tree...
> 
>  drivers/ata/pata_sil680.c |   32 ++------------------------------
>  1 files changed, 2 insertions(+), 30 deletions(-)

applied


