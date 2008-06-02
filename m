From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 02 Jun 2008 13:45:15 -0400
Message-ID: <484431AB.7010005@garzik.org>
References: <20080508161008.59361de5@appleyard>	<20080527030854.GC7515@mit.edu>	<20080527143202.4bab5bf0@appleyard>	<20080527225926.GE6843@mit.edu>	<20080527163251.04054a74@appleyard>	<20080531080015.GG5405@ucw.cz>	<4842F5A8.9020708@garzik.org>	<20080602080440.25fc663c@core>	<4843A4A7.3020809@garzik.org>	<4843EF88.2040606@rtr.ca>	<48441AA6.8080704@garzik.org> <20080602100019.3d2d2522@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43487 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbYFBRpX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jun 2008 13:45:23 -0400
In-Reply-To: <20080602100019.3d2d2522@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kristen.c.accardi@intel.com
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> Can you tell me what part of this patch is vendor specific?  Maybe
> I am misunderstanding what you are saying.  Here's that patch again
> in case you need to look at it again.


It's specific to AHCI, and does not cover other controllers.

Certainly PORT_CMD_HPCP must be, but the concept itself is not at all 
AHCI-specific.

	Jeff


