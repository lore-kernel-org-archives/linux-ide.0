From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 10:52:08 -0500
Message-ID: <20140114155208.GG12131@htj.dyndns.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140114154834.GD32507@kw.sim.vm.gnt>
Sender: stable-owner@vger.kernel.org
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 14, 2014 at 04:48:34PM +0100, Simon Guinot wrote:
> As stable kernel older than 3.10 are no longer maintained, I think
> we don't need to point out a specific commit as a -stable target.
> Simply Cc'ing -stable without any extra informations should be good
> enough.

Well, somebody eventually has to figure it out.  If you know it's
applicable to 3.6+ just do

 Cc: stable@vger.kernel.org # v3.6+

Thanks.

-- 
tejun
