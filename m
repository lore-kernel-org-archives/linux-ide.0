From: "Matt D. Robinson" <matt@aparity.com>
Subject: Re: SY-KT880 DRAGON 2 (VT8237 and ALi 5281 SATA Chipset Conflict?)
Date: Mon, 20 Sep 2004 16:46:11 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0409201641480.3778-100000@nakedeye.aparity.com>
References: <Pine.LNX.4.44.0409201545500.3505-100000@nakedeye.aparity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl027-178-235.sfo1.dsl.speakeasy.net ([216.27.178.235]:50438
	"EHLO nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id S267435AbUIUBVC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Sep 2004 21:21:02 -0400
In-Reply-To: <Pine.LNX.4.44.0409201545500.3505-100000@nakedeye.aparity.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Please ignore this post.  It looks like ALi 5281 SATA support doesn't
exist yet.

--Matt

On Mon, 20 Sep 2004, Matt D. Robinson wrote:
|>Hi, all.  The new Soyo SY-KT880 DRAGON 2 uses two separate SATA
|>RAID chipsets on the motherboard, the VIA8237 and ALi 5281.
|>I'm still testing this, but it looks like only one function is
|>loaded at any given time.  Is there a conflict between utilizing
|>both devices simultaneously?  I'm trying to use them in non-RAID
|>(just SATA) mode so there isn't anything special going on here.
|>sata_via.ko doesn't find the ALi 5281 devices (SATA3/4), and the
|>VIA8237 (SATA1/2) are recognized just fine.
|>
|>Just looking for a pointer before I go spending a couple of days
|>digging into this.  It's a test system at this point so I can trash
|>it as needed.
|>
|>I've tried all Fedora Core 2 kernels as a starting point (base
|>2.6.5 and latest sata_via in 2.6.8-1).  I can load up top of tree
|>kernels if needed for testing.
|>
|>Thanks for any thoughts you have,
|>
|>--Matt
|>

-- 

