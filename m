From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/5] sata, highbank: fix ordering of SGPIO signals
Date: Fri, 2 Aug 2013 15:29:28 -0400
Message-ID: <20130802192928.GA29736@mtj.dyndns.org>
References: <1374851518-4802-1-git-send-email-mark.langsdorf@calxeda.com>
 <20130729165530.GG22605@mtj.dyndns.org>
 <51FBCF05.9090509@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51FBCF05.9090509@calxeda.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Aug 02, 2013 at 10:23:49AM -0500, Mark Langsdorf wrote:
> I didn't think I needed more of an explanation than "this is completely
> wrong per the spec" but I'll revise and resubmit.

Of course you always need to explain the implications as the result of
"being completely wrong per the spec" can range from no actual effect
at all to massive data corruption.  In general, it's a good idea for a
patch descrpition to describe why the change is an improvement and how
it changes the behavior.  The former provides the rationale for
inclusion and the latter helps various people including the subsystem,
-stable and distro kernel maintainers to assess the risk involved in
taking the change.

Thanks.

-- 
tejun
