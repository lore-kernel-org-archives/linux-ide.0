From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: Fri, 28 Mar 2008 10:00:52 -0700
Message-ID: <20080328100052.70c8c55c@appleyard>
References: <20080325221646.567639335@intel.com>
	<20080325152813.0b34761f@appleyard>
	<87fxubl2dv.fsf@basil.nowhere.org>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38332 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbYC1RGo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 13:06:44 -0400
In-Reply-To: <87fxubl2dv.fsf@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, arjan@linux.intel.com

On 28 Mar 2008 08:43:40 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> Kristen Carlson Accardi <kristen.c.accardi@intel.com> writes:
> 
> > If a port doesn't support hot plug, there's no reason to keep the phy powered
> > on unoccupied ports.  
> 
> Would it be possible to add some writable sysfs attribute for this too?
> 
> A lot of ports support hot plug, but the users knows they will never actually
> hot plug anything there. Exposing it to sysfs would make sense so 
> someone could make a conscious decision to save these watts by sacrifying
> hotplug-support.
> 
> -Andi
> 

I had thought about extending the sysfs interface for link power 
management to include a new value: off.  Right now we have
min_power, medium_power, and max_performance - we could add
a value for just "off" which means the port is inactive -
but then we'd have to change all the sysfs stuff to check
and see if the user is turning the port back on after it's
been off and then re-init everything, so it might be a large
effort, so if we did that I'd say it should be a separate
effort from this patch series.
