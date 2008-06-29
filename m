From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: ide_release_lock: bug
Date: Mon, 30 Jun 2008 01:16:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806300104300.9976@zirkon.biophys.uni-duesseldorf.de>
References: <20080623160539.GA8565@marenka.net>
 <alpine.DEB.1.00.0806240219260.30759@zirkon.biophys.uni-duesseldorf.de>
 <alpine.DEB.1.00.0806271036050.14458@zirkon.biophys.uni-duesseldorf.de>
 <Pine.LNX.4.64.0806291201530.29339@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.rz.uni-duesseldorf.de ([134.99.128.30]:52276 "EHLO
	mail.rz.uni-duesseldorf.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbYF3CAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 22:00:07 -0400
In-reply-to: <Pine.LNX.4.64.0806291201530.29339@anakin>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>, Stephen R Marenka <stephen@marenka.net>, linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

> [ Background for linux-ide: ide_release_lock() spits out lots of
>
>    ide_release_lock: bug
>
>  warnings on Atari Falcon ]
>
> On Fri, 27 Jun 2008, Michael Schmitz wrote:
>> The following patch does, indeed, fix the ide_release_lock imbalance. No more
>> warnings.
[ ... ]
>>> We release the lock just before hwgroup->busy is cleared, so it should be
>>> logical to get hold of the lock just after hwgroup->busy was set, no?
>
> If hwgroup->busy serves a similar purpose to falconide_intr_lock, what about
> moving the setting/clearing of hwgroup->busy into ide_{get,release}_lock()
> (and possibly renaming ide_{get,release}_lock() to e.g.
> ide_hwgroup_{set,clear}_busy())?
>
> What about the other places where hwgroup->busy is set/cleared?

Uh - that's where it gets a bit sticky again. hwgroup->busy is set 
and cleared quite a lot 'preemptively' all over ide-io.c, f.e. in timeout 
handling. I'm not sure whether this would just reintroduce the bug 
message.

The lock must be held as long as there are any interrupts to be expected 
from IDE. If the hwgroup->busy semantics reflects just that, it's worth a 
try.

 	Michael

