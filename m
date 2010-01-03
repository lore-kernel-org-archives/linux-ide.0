From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Sun, 3 Jan 2010 11:40:52 +0000
Message-ID: <20100103114052.58881f14@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20091224215451.GA2476@flint.arm.linux.org.uk>
	<20100103002314.GA16528@flint.arm.linux.org.uk>
	<4B400A10.3000103@gmail.com>
	<20100103100545.GA26225@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33324 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752790Ab0ACLhl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jan 2010 06:37:41 -0500
In-Reply-To: <20100103100545.GA26225@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

> eventually to PIO is guaranteed to fix it.  The SCSI layer can't know
> this, and shouldn't know this.  The MD layer certainly doesn't get to

That depends which bit you mean - at the lower levels SCSI most certainly
knows this kind of stuff as it too must deal with speed shifting and
of course has to handle domain validation.

