From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 02 Jun 2008 12:07:02 -0400
Message-ID: <48441AA6.8080704@garzik.org>
References: <20080508161008.59361de5@appleyard>	<20080527030854.GC7515@mit.edu>	<20080527143202.4bab5bf0@appleyard>	<20080527225926.GE6843@mit.edu>	<20080527163251.04054a74@appleyard>	<20080531080015.GG5405@ucw.cz>	<4842F5A8.9020708@garzik.org> <20080602080440.25fc663c@core> <4843A4A7.3020809@garzik.org> <4843EF88.2040606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43889 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYFBQHP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jun 2008 12:07:15 -0400
In-Reply-To: <4843EF88.2040606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:
> For the power-off of unused ports, the current patch still sounds
> extremely vendor-specific (Intel).
> 
> Does it actually work (demonstrate, please) on any other hardware ?

Ding...  correct.  We need something per-port that's not Intel specific.

	Jeff



