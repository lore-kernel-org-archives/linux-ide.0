From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add missing call to ->cable_detect() in new EH
 path
Date: Sat, 28 Apr 2007 14:46:36 -0400
Message-ID: <4633968C.7040504@garzik.org>
References: <20070422170553.GL10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53378 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161399AbXD1Sqi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 14:46:38 -0400
In-Reply-To: <20070422170553.GL10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ->cable_detect() used to be called on by the old ata_bus_probe() path.
> Add invocation to ata_eh_revalidate_and_attach() right after IDENTIFYs
> are done.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-eh.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

applied


