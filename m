From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream REGENERATED] libata: move EH repeat
 reporting into ata_eh_report()
Date: Fri, 31 Aug 2007 05:35:53 -0400
Message-ID: <46D7E0F9.7080107@garzik.org>
References: <20070731074203.GA13674@htj.dyndns.org> <20070731075100.GB13674@htj.dyndns.org> <46C2BEDA.5070105@garzik.org> <20070818042849.GE8590@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45135 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932149AbXHaJfy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 05:35:54 -0400
In-Reply-To: <20070818042849.GE8590@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, mikpe@it.uu.se

Tejun Heo wrote:
> EH is sometimes repeated without any error or action.  For example,
> this happens when probing IDENTIFY fails because of a phantom device.
> In these cases, all the repeated EH does is making sure there is no
> unhandled error or pending action and return.  This repeation is
> necessary to avoid losing any event which occurred while EH was in
> progress.
> 
> Unfortunately, this dry run causes annonying "EH pending after
> completion" message.  This patch moves the repeat reporting into
> ata_eh_report() such that it's more compact and skipped on dry runs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mikael Pettersson <mikep@it.uu.se>
> ---
> Regenerated against #upstream (41b135c7) +
> implement-and-use-ata_port_desc patch.
> 
>  drivers/ata/libata-eh.c |   30 ++++++++++++++++++------------
>  include/linux/libata.h  |    5 +++--
>  2 files changed, 21 insertions(+), 14 deletions(-)

applied


