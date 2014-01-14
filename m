From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 10:22:11 -0500
Message-ID: <20140114152211.GF12131@htj.dyndns.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114152112.GE12131@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140114152112.GE12131@htj.dyndns.org>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Simon Guinot <simon.guinot@sequanux.org>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 14, 2014 at 10:21:12AM -0500, Tejun Heo wrote:
> Hey, Jason.
> 
> On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> > I see no point to breaking up this series only to have both pieces end
> > up in stable.  Are you ok with taking the whole thing?
> 
> Yeah, sure.  Gregory thought the device id could be better.  Is that
> not the case?

Gees, please disregard.  You explicitly commmented about Gregory's
point.  I'll apply the patches once Simon posts the updated version.

Thanks.

-- 
tejun
