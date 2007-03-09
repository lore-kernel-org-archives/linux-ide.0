From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix ata_host_release() free order
Date: Fri, 09 Mar 2007 07:51:15 -0500
Message-ID: <45F15843.7010001@garzik.org>
References: <20070309103612.GC32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55701 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767229AbXCIMvQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:51:16 -0500
In-Reply-To: <20070309103612.GC32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> host->ops->host_stop() might access ports.  Free ports after
> host_stop.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This one fixes oops on pdc_adma unloading and needs to go to
> libata-dev#upstream-fixes.
> 
>  drivers/ata/libata-core.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)

applied to #upstream-fixes


