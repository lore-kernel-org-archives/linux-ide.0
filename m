From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4, SATA
	300 TX4
Date: Mon, 5 Oct 2009 12:49:00 +0200
Message-ID: <19145.53020.561575.741974@pilspetsen.it.uu.se>
References: <898aa1e70910031512q39e0f582t5540669c19a821f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:56224 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402AbZJEKtq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Oct 2009 06:49:46 -0400
In-Reply-To: <898aa1e70910031512q39e0f582t5540669c19a821f8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Walter Hutchins <hutchwa@gmail.com>
Cc: linux-ide@vger.kernel.org

Walter Hutchins writes:
 > The first 2 ports on the SATA 300 TX4302 board are wired in reverse of
 > the SATA 300 TX4 board.
 > Wrong port order (still) makes it (nearly) impossible to deal with boot
 > problems using two or more drives for users of TX4302 board.
 > 
 > Driver was modified to remap ports on certain boards according to this line:
 >         static const unsigned char sataii_tx4_port_remap[4] = { 3, 1, 0, 2};
 > 
 > That modification makes the situation bad for users of TX4302 board.
 > 
 > The situation could be much improved by adding kernel config parameters
 > allowing users requiring a different remap order some sub options for
 > CONFIG_SATA_PROMISE which would default to the current remap order.

Compile-time config options for special cases aren't going to fly.
No distro is going to enable them, which means that those that need
them have to build their own kernels, by which time they could just
apply some well-known tx4302 patch.

Better would be a module option sata_promise.tx4remap=0/1/2, with
0 meaning no remap, 1 remap for 300tx4 like now, and 2 remap for
the tx4302. This should be easy to implement.

Even better would be an option saying "do $REMAP for PCI device
AA:BB:C", as that would allow a system to have a mix of 300tx4
and tx4302 cards. But it might not be easy to implement.

(A reminder to linux-ide: Promise first did a really bogus change
to the internal-to-external port numbering in their 2nd generation
4-port cards. Then they reused the same chip for the TX4302 and
changed the internal-to-external port numbering again, with no
way for the driver to detect this since the PCI IDs are the same.)
