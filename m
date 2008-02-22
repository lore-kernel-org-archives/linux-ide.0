From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's needed for PMP support?
Date: Fri, 22 Feb 2008 09:57:41 +0000
Message-ID: <20080222095741.481883a5@core>
References: <4730E312.3090900@navy.mil>
	<4737C16E.3070607@gmail.com>
	<4738827D.9060405@pobox.com>
	<4738F935.1000708@gmail.com>
	<47BC798F.6070900@pobox.com>
	<47BE17CA.6060406@rtr.ca>
	<47BE1833.9090501@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38361 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762309AbYBVKHI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 05:07:08 -0500
In-Reply-To: <47BE1833.9090501@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Saeed Bishara <saeed@marvell.com>

> Heck, if .dev_select() took a *device* instead of a *port*
> as it's parameter, then I could probably manage it fine in there.

dev_select gets called during probing before the relevant structures are
neccessarily set up.

