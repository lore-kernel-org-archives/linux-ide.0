From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ICH Intel PATA short cable override...
Date: Fri, 07 Sep 2007 19:19:10 -0400
Message-ID: <46E1DC6E.9060001@pobox.com>
References: <6278d2220709040537n4c96ffcagd9c25c94ddd29ca1@mail.gmail.com> <20070906014209.142382c8@the-village.bc.nu> <46DF63F8.8070805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41949 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbXIGXTQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Sep 2007 19:19:16 -0400
In-Reply-To: <46DF63F8.8070805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel J Blueman <daniel.blueman@gmail.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote:
> Ditto for selecting transfer modes.


Waiting on one thing AFAICS:

	ability to drain/idle all ports +
	issue a command on one port +
	resume normal parallel port operation

SET FEATURES - XFER MODE is special in that it requires all sorts of 
additional controller handling and careful cross-port synchronization.

	Jeff


