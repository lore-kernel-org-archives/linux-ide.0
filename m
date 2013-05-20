From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Mon, 20 May 2013 16:30:12 +0900
Message-ID: <20130520073012.GA24222@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305191531.23110.plr.vincent@gmail.com>
 <20130519233818.GA4482@mtj.dyndns.org>
 <201305200820.05239.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:51401 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab3ETHaR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 03:30:17 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so3696794dak.7
        for <linux-ide@vger.kernel.org>; Mon, 20 May 2013 00:30:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305200820.05239.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hello,

On Mon, May 20, 2013 at 08:20:04AM +0200, Vincent Pelletier wrote:
> > So, nope, I really don't want this.
> 
> Err, the body of this patch didn't change from my original submission, only 
> the commit message has changed.

Heh, that's my jet-lagged brain thinking it was something else. :)
Sorry about that.

> > > +atapi_dmadir
> > > +
> > > +	Bitmask enabling dmadir for corresponding device if ATAPI.
> > > +	1:	Enable dmadir for port's device 0
> > > +	2:	Enable dmadir for port's device 1
> > > +	(etc)
> > > +	See also libata's atapi_dmadir module parameter.
> > 
> > Shouldn't this be a device property?
> 
> Unplugging the drive would, in my understanding, loose the setting if stored 
> at the device level. Is there another way to trigger a new initialisation 
> attempt after changing the setting ?
> Should I add a "rescan" device attribute ?

But isn't that what we want?  We don't really know to which side the
bridge is attached but given SATA supports hotplug while PATA doesn't,
it's natural to assume the bridge to be part of the device rather than
bus and reset the state on device hotplug, no?

Thanks.

-- 
tejun
