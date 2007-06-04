From: Michel Lespinasse <walken@zoy.org>
Subject: Re: SATA hotswap and write caches
Date: Sun, 3 Jun 2007 17:53:41 -0700
Message-ID: <20070604005341.GA3315@zoy.org>
References: <20070603104334.GH18680@zoy.org> <4662CF26.6060902@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 64-142-28-230.dsl.static.sonic.net ([64.142.28.230]:60011 "EHLO
	Angel.zoy.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284AbXFDAxm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 20:53:42 -0400
Content-Disposition: inline
In-Reply-To: <4662CF26.6060902@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sun, Jun 03, 2007 at 10:24:38AM -0400, Jeff Garzik wrote:
> Michel Lespinasse wrote:
> >* Is there anything one needs to know before hot-removing a drive ?
> 
> Make sure all data is flushed to the drive before removing it.

Sure. Is there a way to do that, though, other than using /sbin/halt
which seems to have, errr, undesirable side-effects :)

Ideally it'd be very nice if that was doable through /sys or /proc files.
It'd also be nice if disk standby was user-controllable in this way too.
(or maybe both as one step, i.e. a way to tell the kernel we'd like to
take the disk out in the safest way possible).

-- 
Michel "Walken" Lespinasse
"Bill Gates is a monocle and a Persian cat away from being the villain
in a James Bond movie." -- Dennis Miller
