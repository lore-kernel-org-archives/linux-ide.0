From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 01:17:34 -0700
Message-ID: <courier.468B579E.00002ECF@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <courier.468B17B1.00001A78@blargh.com>
            <468B19BA.6030202@gmail.com>
            <200707040908.21512.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:45420 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754980AbXGDIRf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 04:17:35 -0400
In-Reply-To: <200707040908.21512.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Andi Kleen writes:

> If it has >2GB or so it might be worth trying booting it with mem=2G

Nope, only 1GB of RAM.

> Most likely it is some sort of hardware bug that we might
> not be able to do much about. Have you tried contacting SIL or VIA? 

No, I haven't.  Like I mentioned above, the OpenBSD drivers seemed to work, 
or at least did with similar tests.  I would need to run the more extensive 
checks to be positive, but those take a lot of time, obviously.  And 
downtime for the box, a lot of which isn't really manageable, at the moment. 

> e.g. if you have some other system with a different chipset it might
> be useful to test the SIL controllers in those.

The previous motherboard was an AMD 760 chipset, and it had the same 
problem. 

> I would perhaps also try a newer kernel.

I can certainly try that - I admit 2.6.20.3 is a little old now.  This will 
probably take me a couple days - tomorrow is the 4th of July and a holiday 
for me.
