From: Mark Lord <liml@rtr.ca>
Subject: Re: CF to SATA bridge support
Date: Sat, 29 Aug 2009 09:48:34 -0400
Message-ID: <4A9931B2.2020003@rtr.ca>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>	 <4A7CEF3B.9090506@gmail.com>	 <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com> <43479bc90908090923h40305e14mf726d30fbed0733f@mail.gmail.com> <4A80219D.7070708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57490 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZH2Nsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Aug 2009 09:48:33 -0400
In-Reply-To: <4A80219D.7070708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu GELI <mathieu.geli@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
..
> Those errors are on WRITEs, not READs, so no surprise that "hdparm -t" works.
> This could be an IORDY issue, or just due to how the the Marvell chips
> are buggy when doing PIO of more than a single sector.  That was the only
> errata we didn't do a complete workaround for, because it's so ugly.  :)
> 
> I have a CF-to-SATA adapter due to arrive here from DealExtreme.com in the
> next week or so.  Remind me, and I'll try it out on some of the Marvell 
> cards here and see what happens.
..

Okay.  I don't actually have any of the system-on-chip (SoC) Marvell devices
like the one you are using there.  But they say that the SATA core on
the SoC is a Gen-IIe core, same as on the 7042 PCIe chipset.

So, I've plugged my UDMA-capable CF card into the CF-to-SATA adapter
and hotplugged that into a port on the 7042.

It works fine, reading/writing in UDMA mode 5.
Things also appear to be good with a Hitachi microdrive in PIO mode 3.

The CF-to-SATA adaptor I am using is this one:
   http://www.dealextreme.com/details.dx/sku.20317

Nice little device, compact, notebook compatible, and Fast!

Cheers
