From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: 2.6.21-rc6-mm1 ATA HPT37x regression
Date: Tue, 17 Apr 2007 23:37:21 +0400
Message-ID: <462521F1.2000806@ru.mvista.com>
References: <17956.12963.163961.762444@smtp.charter.net>	<4624D4C3.9010109@ru.mvista.com>	<17956.63043.521397.597430@smtp.charter.net>	<4624FE88.2010908@ru.mvista.com>	<20070417181340.7de99868@the-village.bc.nu> <17957.8073.587946.969040@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:58756 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1031140AbXDQTgY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 15:36:24 -0400
In-Reply-To: <17957.8073.587946.969040@smtp.charter.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: John Stoffel <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

John Stoffel wrote:

>>>>Ok, so do I need to do anything special with the next -mm release and
>>>>the next version?

>>>Well, let Alan decide that (2Alan: and I said that HPT code is bogus :-).

> Alan> Try drivers/ide/pci/hpt366 - if that works grab a dmesg and let
> Alan> me know.  It means that Sergei's DPLL sync code seems to work
> Alan> better than the vendor code and its time to swap it over.

> Ok, I'll give that a whirl under 2.6.21-rc7 tonight.  I'll build them
> in modular so I can switch around more easily.  I hope.  :]

   You can't switch from the old IDE driver -- they're *not* unloadable. :-/

> Alan> Oh how I love highpoint PATA

   More like PITA. :-D

> It seemed like a good buy at the time when I was researching these
> things.  Best bang for the buck I guess.  It's a RocketRaid133 card,

   As for bang, it's true. You can't imagine how many days/nights I spent bangin' with the driver. :-D

> but obviously I got a bum deal somewhere down the line.

   HPT chips are surely not a good example of how to do things, more like an example how *not* to do. :-)

> John

MBR, Sergei
