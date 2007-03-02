From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: clear drvdata in ata_host_release(), take#2
Date: Thu, 01 Mar 2007 20:16:46 -0500
Message-ID: <45E77AFE.1020605@garzik.org>
References: <20070224074823.GA20322@htj.dyndns.org> <45E0EB9F.3050001@garzik.org> <20070227133321.GH20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46233 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161159AbXCBBQu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:16:50 -0500
In-Reply-To: <20070227133321.GH20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Komuro <komurojun-mbn@nifty.com>

Tejun Heo wrote:
> Clearing drvdata in ->remove_one causes NULL pointer deference.  Clear
> drvdata only in ata_host_release() after all resources are freed.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> pata_pcmcia is fixed by Alan's patch.  This fixes other drivers and
> make libata always clear drvdata after detach.

applied


