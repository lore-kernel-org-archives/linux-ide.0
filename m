From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Subject: What eSATA hardware?
Date: Thu, 1 Dec 2005 16:36:44 -0700
Message-ID: <7f55de720512011536n681af61el796c3da5a90143db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:43971 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932549AbVLAXgq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 18:36:46 -0500
Received: by xproxy.gmail.com with SMTP id i30so388899wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Dec 2005 15:36:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi folks, I hope this is not too off-topic...  I'm building a disk
server, and I want to use eSATA, and I need hardware advice...

I'm considering the Sonnet Tempo-X eSATA 8
<http://www.sonnettech.com/product/tempo-x_esata8.html>, and the
Addonics ADSA3GX4R-E
<http://addonics.com/products/host_controller/adsa3gx4r-e.asp>.  I
think both of these are supported in 2.6, is one prefered over the
other?  Are there any others I should consider?  I prefer the Sonnet,
just because it's got 8 ports so that saves me a PCI-X slot.

I'm also looking for a good eSATA enclosure.  I'd prefer an 8x
enclosure with redundant power supplies, but I've been unable to find
one.  Anyone know of one?

My second choice would be to use a bunch of 2x enclosures.  The
thinking is, if I lose one power supply, my RAID-6 array stays up.

I'm thinking cooler drives live longer, so I want the enclosure I buy
to have at least one fan on each disk, plus a big exhaust fan, plus
the power supply fan.

Any suggestions and advice would be greatly appreciated...


--
Sebastian Kuzminsky
