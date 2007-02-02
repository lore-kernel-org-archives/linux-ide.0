From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 02 Feb 2007 21:34:54 +0300
Message-ID: <45C3844E.4070802@ru.mvista.com>
References: <20070202151856.GD1625@htj.dyndns.org> <45C359FC.2000601@ru.mvista.com> <45C368F5.4090201@garzik.org> <45C36D85.4060300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1393 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1946020AbXBBSfL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 13:35:11 -0500
In-Reply-To: <45C36D85.4060300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, ahaas@airmail.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Mark Lord wrote:

>> It's amazing how poorly we have programmed PIIX, for the lifespan of 
>> Linux...

> Actually, we've only been fiddling timings on PIIX since 1998 or so,
> when AH began taking over Linux IDE.  Still, 10 years is an eternity.

   The most funny thing is that despite being called piix.c the driver seems 
to have always been broken for the original PIIX which didn't have separate 
mastre/slave timings. :-)

> Cheers

MBR, Sergei
