From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: HPA support
Date: Fri, 13 Apr 2007 12:24:34 -0400
Message-ID: <461FAEC2.6000705@pobox.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <20070413153343.GA26304@athena.road.mcmartin.ca> <20070413154432.GC26304@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37295 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077AbXDMQYj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 12:24:39 -0400
In-Reply-To: <20070413154432.GC26304@athena.road.mcmartin.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@canonical.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Kyle McMartin wrote:
> Oddly, the command at least executes and doesn't MCE (but it's not at all
> happy either) if I use ATA_PROT_PIO. I wonder if ATA_PROT_NODATA is buggered
> on this sata_nv chip (Asus A8N-E).
> 
> Weird...


Try turning off ADMA using the module parameter, and see if 
ATA_PROT_NODATA magically works.

ADMA is an advanced command execution mode, and it may not be 
appropriate for certain non-data commands.

	Jeff


