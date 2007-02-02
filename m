From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 02 Feb 2007 11:57:41 -0500
Message-ID: <45C36D85.4060300@rtr.ca>
References: <20070202151856.GD1625@htj.dyndns.org> <45C359FC.2000601@ru.mvista.com> <45C368F5.4090201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4291 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945981AbXBBQ5n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 11:57:43 -0500
In-Reply-To: <45C368F5.4090201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Tejun Heo <htejun@gmail.com>, ahaas@airmail.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> It's amazing how poorly we have programmed PIIX, for the lifespan of 
> Linux...

Actually, we've only been fiddling timings on PIIX since 1998 or so,
when AH began taking over Linux IDE.  Still, 10 years is an eternity.

Cheers
