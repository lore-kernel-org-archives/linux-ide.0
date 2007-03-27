From: Bob Stewart <bob@evoria.net>
Subject: Re: sata_inic162x driver for 2.6.19 timeouts etc
Date: Mon, 26 Mar 2007 22:19:23 -0700 (PDT)
Message-ID: <20070327051923.79514.qmail@web804.biz.mail.mud.yahoo.com>
References: <4608A42D.6080403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web804.biz.mail.mud.yahoo.com ([209.191.90.77]:48440 "HELO
	web804.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933983AbXC0FTY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Mar 2007 01:19:24 -0400
In-Reply-To: <4608A42D.6080403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: Bob Stewart <bob@evoria.net>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

--- Jeff Garzik <jeff@garzik.org> wrote:

> Alan, Mark, surely some ancient controller simply can't do LBA48 at all, 
> even in PIO mode?

Jeff,
Thanks for reminding me.  I need to retest Tejun's driver limited to PIO mode.
If I remember correctly, when I first started testing it and it failed down to
PIO4, it worked just fine on an LBA28 partition.

Bob
