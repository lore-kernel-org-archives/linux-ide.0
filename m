From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH REGENERATED] ahci: reimplement port_map handling
Date: Thu, 20 Sep 2007 17:25:01 -0400
Message-ID: <46F2E52D.4030103@garzik.org>
References: <20070720085934.GD22374@htj.dyndns.org> <46A0A5C4.1050808@garzik.org> <46A0A85D.6000300@gmail.com> <20070903034457.GE16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34152 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbXITVZC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 17:25:02 -0400
In-Reply-To: <20070903034457.GE16890@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Reimplement port_map handling such that
> 
> 1. Non-zero PORTS_IMPL value is always examined and used if consistent
>    with cap.n_ports.
> 
> 2. When PI and cat.n_ports are inconsistent, honor cap.n_ports and
>    force port_map to be ((1 << cap.n_ports) - 1).
> 
> 3. There were two separate places dealing with port_map.  Unify them
>    to one.
> 
> As all newer ahci chips seem to get PI correct and older ones usually
> have zero PI.  Controllers with holes in PI are very unlikely to screw
> up PI, so #2 makes more sense than following inconsistent PI.
> 
> Without this change, not setting ATA_FLAG_HONOR_PI when it's needed
> results in weird detection failure.  This changed logic should be able
> to handle all known cases correctly automatically.
> 
> Verified on ICH6 (reports 0 PI), ICH8 (with holes in port_map), ICH9,
> JMB360 and JMB363.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Regenerated on top of the current #upstream.

applied... let's see what explodes :)


