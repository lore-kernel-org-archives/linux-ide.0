From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: fix ata_set_max_sectors()
Date: Tue, 25 Sep 2007 22:27:13 -0400
Message-ID: <46F9C381.6080501@garzik.org>
References: <20070921110714.GH10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52202 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbXIZC1O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:27:14 -0400
In-Reply-To: <20070921110714.GH10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> In ata_set_max_sectors(), the highest nibble in LBA28 mode was
> missing.  This made drives sized between 8G and 128G with HPA turned
> on to be resized to under 8G.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This one fixes my dumb mistake.
> 
>  drivers/ata/libata-core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

applied


