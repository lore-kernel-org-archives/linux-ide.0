From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Wed, 16 Apr 2008 20:46:33 +0100
Message-ID: <200804162046.33245.tvrtko@ursulin.net>
References: <200804092118.35501.tvrtko@ursulin.net> <4805E59E.1020607@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-3.mail.uk.tiscali.com ([212.74.114.23]:35328
	"EHLO mk-outboundfilter-3.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750847AbYDPTpq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 15:45:46 -0400
In-Reply-To: <4805E59E.1020607@aitel.hist.no>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 16 April 2008 12:40:14 Helge Hafting wrote:
> Tvrtko A. Ursulin wrote:
> > 9 Power_On_Hours       0x0032 100 100 000 Old_age Always  - 66
> > 193 Load_Cycle_Count 0x0032 197 197 000 Old_age  Always  - 10233
> >
> > At this rate the disk would reach it's design limit for load/unload
> > cycles in around 80 days. Not good - so I implemented a lame workaround
> > of keeping disk busy every couple of seconds - hopefully that won't kill
> > it sooner that unloads would..
>
> Yuck, how stupid!
> But the solution is simple. Make sure to get a warranty of much more
> than 80 days. Use RAID-1 (or backup often).
> Just let those disks destroy themselves (they _are_ faulty) and
> get new ones all the time.  As long as they make them this stupid, you
> won't have to buy new disks again. Free warranty replacements forever.

:) I am not so enthusiastic about fiddling with my NAS box every couple of 
months.

> To be a bit more constructive, tell them about this strategy. Perhaps
> they get
> busy fixing the firmware?

I have suggested exactly what you say - unfortunately the conversation has 
gone cold since. Maybe they are busy already. :)

Tvrtko
