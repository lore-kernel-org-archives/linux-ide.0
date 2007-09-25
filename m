From: Paul Rolland <rol@as2917.net>
Subject: Re: 2.6.23-rc7 - _random_ IRQ23 : nobody cared
Date: Tue, 25 Sep 2007 09:00:57 +0200
Message-ID: <20070925090057.5778aa2a@tux.DEF.witbe.net>
References: <20070924083336.7a08fd61@tux.DEF.witbe.net>
	<46F7C933.4080003@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:42152 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbXIYHBH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 03:01:07 -0400
In-Reply-To: <46F7C933.4080003@davidnewall.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Newall <david@davidnewall.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, rol@witbe.net

Hi David,

On Mon, 24 Sep 2007 23:56:59 +0930
David Newall <david@davidnewall.com> wrote:

> Paul Rolland "(???????) wrote:
> > Hell, IRQ 23 is shared between libata and my modem !!!
> >   
> 
> Tried using the modem?

When no problem is reported, both the libata part and the modem are OK.
When the problem is reported, at that time, only libata is handling IRQ23
(the modem is a WinModem, and the driver is an out-kernel module), this 
is still kernel boot time, and the disabling of the IRQ makes my machine
unable to complete the boot process (too many disk timeout).

It could be good to be able to delay the disabling of an IRQ something long
enough to allow all the modules to be loaded...

Paul

