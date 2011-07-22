From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Fri, 22 Jul 2011 11:50:37 +0200
Message-ID: <20110722095037.GJ2622@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
 <20110721090022.GF3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:60910 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab1GVJum (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jul 2011 05:50:42 -0400
Received: by mail-fx0-f52.google.com with SMTP id 18so5032648fxd.11
        for <linux-ide@vger.kernel.org>; Fri, 22 Jul 2011 02:50:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Thu, Jul 21, 2011 at 04:22:07PM +0000, Derry Bryson wrote:
> Here are the specs on the port multiplier board:
> 
> Lycom ST-126RM (http://www.lycom.com.tw/)
> Sil3726 chip revision 17
> EEPROM FW Version: 1.0114
> 
> Also there is another problem:  ports that are not connected at power on
> are ignored until a port that was connected at power on is hotplugged.  So,
> for instance, if I turn the unit on with only a drive on the first port, the
> other four ports will not work and I don't even see kernel messages when
> hotplugging until I hotplug the first port.  I haven't looked into this yet,
> but it would seem the driver must be disabling the ports and they are not
> looked at again until the hard reset is performed.

That's most likely the sil pmp itself.  It has been known to show
erratic behavior if the first port is not occupied during power up.  I
don't know whether later firmware updates fixed that tho.  Can you get
hold of a marvell PMP and see how it behaves?

Thanks.

-- 
tejun
