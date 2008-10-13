From: Tejun Heo <tj@kernel.org>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 08:25:22 +0900
Message-ID: <48F3D8E2.8000006@kernel.org>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32996 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbYJMX1d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 19:27:33 -0400
In-Reply-To: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Pierre Ossman wrote:
> I'm playing around with performance tuning my disk access, but there is
> something limiting my bandwidth to the disks. I was hoping you could
> help me determine what.
> 
> My setup is a sil3132 controller, connected to a PMP with five disks
> behind it. I'm using iostat to measure disk traffic and I'm using reads
> via dd for testing.
> 
> When I'm accessing a single disk, the bandwidth is 70 - 80 MiB/s. When
> I access a second disk, the bandwidth is about 50 MiB/s/disk, and all
> five results in 25 MiB/s/disk. In other words, something is limiting
> things to about 100 MiB/s. Now the question is what that limiting
> factor is.
> 
> The PCIe bus can sustain 250 MiB/s, so even with overhead that should
> be plenty. The SATA links are in theory 300 MiB/s, so that can't be it
> either. The remaining factors are the controller and the multiplier
> chip, and/or the way we access them.
> 
> Tejun, what kind of throughput have you seen when you have been testing
> the sil3132 and multipliers?

That's the limit of sil3124/3132.  Dunno why but you can't go over that.
 There's 3132-2 chip on the market.  Maybe it's worth a try?

-- 
tejun
