From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Compact Flash performance...
Date: Thu, 31 May 2007 18:37:20 -0400
Message-ID: <465F4E20.5080503@garzik.org>
References: <6278d2220705301510y2d81f69eu38fb778d32de05e1@mail.gmail.com>	 <465E3FF0.9010709@rtr.ca>	 <6278d2220705310222rde9ad28ndfd8feced84a3c6f@mail.gmail.com>	 <465EBE20.6090803@rtr.ca>	 <6278d2220705311025q6ee030e2kd44b7302a50ac902@mail.gmail.com>	 <465F360D.6020603@rtr.ca> <6278d2220705311439x40f7b1c1l7cef54acd2e8fcea@mail.gmail.com> <465F4D4E.6050305@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47668 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbXEaWhZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 May 2007 18:37:25 -0400
In-Reply-To: <465F4D4E.6050305@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Daniel J Blueman <daniel.blueman@gmail.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Mark Lord wrote:
> Some cards may perform better when their "memory" interface is used
> instead of the "I/O" interface, or vice-versa.  I'm not sure which
> of the two methods was selected by libata (probably the "memory" 
> interface).

I am very CF-ignorant.  How does libata select a memory or I/O interface 
on a CF device?

	Jeff


