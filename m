From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: SATA link power management issues
Date: Tue, 21 Apr 2015 22:29:38 +0200
Message-ID: <9107428.nVaRUddl4K@xps13>
References: <3352987.ugV1Ipy7Z5@xps13> <2356903.cA2H5W8V2D@xps13> <20150421153121.GD9455@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150421153121.GD9455@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stripathi@apm.com
List-Id: linux-ide@vger.kernel.org

On Tuesday 21 April 2015 11:31:21 Tejun Heo wrote:
> On Mon, Apr 20, 2015 at 10:02:12PM +0200, Gabriele Mazzotta wrote:
> > On Sunday 22 February 2015 21:53:35 Gabriele Mazzotta wrote:
> > > It seems that the following patch prevents errors when the policy is
> > > changed. Could anybody explain why?
> 
> The device is generating a spurious PHY event after LPM state change
> and the patch is ignoring the event once after state change.  It's a
> bit too specific.  Maybe we should do this timeout-based - e.g. ignore
> phy events for 1s after LPM state change.  Gabriele, would be
> interested in making such changes?

Thanks for the explanation and yes, I am interested.

Doing some quick tests I found that in some cases it takes 5 or 6
seconds for the first interrupt to arrive, so I'd have to use a quite
long interval to completely prevent errors.

I am wondering if it would be better using my original solution
(i.e. ignore first event), but make it device specific given that it
might make no sense on other systems and seems to be more reliable than
the time-based one.

Gabriele
