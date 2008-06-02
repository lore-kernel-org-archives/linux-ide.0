From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 2 Jun 2008 08:04:40 +0100
Message-ID: <20080602080440.25fc663c@core>
References: <20080508161008.59361de5@appleyard>
	<20080527030854.GC7515@mit.edu>
	<20080527143202.4bab5bf0@appleyard>
	<20080527225926.GE6843@mit.edu>
	<20080527163251.04054a74@appleyard>
	<20080531080015.GG5405@ucw.cz>
	<4842F5A8.9020708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42656 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750936AbYFBHUC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 03:20:02 -0400
In-Reply-To: <4842F5A8.9020708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@ucw.cz>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> If you are talking about SATA -- incorrect.
> 
> The patch deals with policy, and the user MUST have the ability to 
> control this stuff.  Otherwise you create a situation where the user 
> might be denied hotplug use in valid cases, or similar negative situations.

The policy isn't however complicated. Tejun added the stuff for forcing
cable type and mode on setup and has therefore written all the per device
setup code we might need. Alternatively a single

	foo=1/0

option has been fine for acpi and will do fine for this. Total additional
cost - 1 line.

Alan
