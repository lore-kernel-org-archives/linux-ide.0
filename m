From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 14 Jul 2011 09:14:59 +0200
Message-ID: <20110714071459.GB3455@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34876 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1GNHPG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2011 03:15:06 -0400
Received: by eyx24 with SMTP id 24so2379420eyx.19
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2011 00:15:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Wed, Jul 13, 2011 at 04:23:27PM +0000, Derry Bryson wrote:
> [   92.980476] ata1.02: IDENTIFY failed, irq_stat=0x60002 cerr=4

The controller is saying that it failed to transmit command FIS
because PHYRDY state changed, so that is PHY flickering.  Can you
please bump the second debounce timing to 1000 (not only the first one
but always) and see whether the failure pattern changes?

Thanks.

-- 
tejun
