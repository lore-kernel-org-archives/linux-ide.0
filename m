From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ide-2.4.20-pre4-ac2.patch
Date: Fri, 30 Aug 2002 11:43:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <30345.4663524919$1030697081@news.gmane.org>
References: <Pine.LNX.4.44.0208300141070.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208300141070.8911-100000@serv>
List-Id: linux-ide@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

>> > It's for m68k and ppc Amigas, but I don't think two separate drivers are
>> > needed.
>>
>> So its actually a false divide and dumping them in "legacy" is probably
>> a lot simpler ?
>
>Hmm, somehow I more like "m68k". :)

If it's PPC side is limited to PPC amiga's (APUS), then leave it
in m68k. PPC Amiga's are really m68k machines with a hacked PPC
in the CPU slot ;)

Though such problems may come back if we ever decide to support
the PPC CPU cards for old m68k macs, and if I finally merge the
support for NuBus pmacs, oh well...

Ben.


