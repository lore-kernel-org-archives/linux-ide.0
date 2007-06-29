From: Alan Cox <alan@redhat.com>
Subject: Re: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 06:06:23 -0400
Message-ID: <20070629100623.GA25064@devserv.devel.redhat.com>
References: <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbXF2KG1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 06:06:27 -0400
Content-Disposition: inline
In-Reply-To: <46845BEE.90801@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Andrew Hall <andrew.a.hall@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

On Thu, Jun 28, 2007 at 09:10:06PM -0400, Mark Lord wrote:
> Here's a slightly modified hack, which should leave your SATA
> drive working as well as the CF card.
> 
> Tejun / Alan : do we really want to continue attempting mdma2
> on a modern chipset such as ICH8 ???

Thats a good question is it only has a SATA interface, however while our
PIO locks IRQs off and sucks the answer is probably yes, because we still
see MWDMA2 CD drives on boxes like this and they work.

Alan

