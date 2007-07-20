From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: reimplement port_map handling
Date: Fri, 20 Jul 2007 18:10:51 +0900
Message-ID: <46A07C1B.2000702@gmail.com>
References: <20070720085934.GD22374@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:10920 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950AbXGTJK5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 05:10:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so928008wah
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 02:10:56 -0700 (PDT)
In-Reply-To: <20070720085934.GD22374@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
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
> Jeff, SIS chips seem to require HONOR_PI flag for -stable.  I'll
> submit the patch as soon as it's verified.  For -upstream, I think
> this is much better fix.

Oh, forgot to mention.  Not sure whether mv6145 hack is broken by this
or not.  Please verify.

Thanks.

-- 
tejun
