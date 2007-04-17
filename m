From: "John Stoffel" <john@stoffel.org>
Subject: Re: 2.6.21-rc6-mm1 ATA HPT37x regression
Date: Tue, 17 Apr 2007 15:27:05 -0400
Message-ID: <17957.8073.587946.969040@smtp.charter.net>
References: <17956.12963.163961.762444@smtp.charter.net>
	<4624D4C3.9010109@ru.mvista.com>
	<17956.63043.521397.597430@smtp.charter.net>
	<4624FE88.2010908@ru.mvista.com>
	<20070417181340.7de99868@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Mycroft.westnet.com ([216.187.52.7]:47683 "EHLO
	Mycroft.westnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031137AbXDQT1N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Apr 2007 15:27:13 -0400
In-Reply-To: <20070417181340.7de99868@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


>> > Ok, so do I need to do anything special with the next -mm release and
>> > the next version?
>> 
>> Well, let Alan decide that (2Alan: and I said that HPT code is bogus :-).

Alan> Try drivers/ide/pci/hpt366 - if that works grab a dmesg and let
Alan> me know.  It means that Sergei's DPLL sync code seems to work
Alan> better than the vendor code and its time to swap it over.

Ok, I'll give that a whirl under 2.6.21-rc7 tonight.  I'll build them
in modular so I can switch around more easily.  I hope.  :]

Alan> Oh how I love highpoint PATA

It seemed like a good buy at the time when I was researching these
things.  Best bang for the buck I guess.  It's a RocketRaid133 card,
but obviously I got a bum deal somewhere down the line.

Now I've got a Sil3114 SATA controller, which seems to be working just
fine now.  Hopefully it won't have problems like this!

John

