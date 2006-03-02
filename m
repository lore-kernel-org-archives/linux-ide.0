From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 1 Mar 2006 20:00:19 -0700
Message-ID: <311601c90603011900q7fe21fbx1020e4ba4062dc24@mail.gmail.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>
	 <4405F471.8000602@rtr.ca>
	 <1141254762.11543.10.camel@rousalka.dyndns.org>
	 <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
	 <440650BC.5090501@pobox.com> <4406512A.9080708@pobox.com>
	 <311601c90603011820u4fc89b04te1be39b9ed2ef35b@mail.gmail.com>
	 <44065C7C.6090509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:36435 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbWCBDAU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Mar 2006 22:00:20 -0500
Received: by zproxy.gmail.com with SMTP id n1so315694nzf
        for <linux-ide@vger.kernel.org>; Wed, 01 Mar 2006 19:00:19 -0800 (PST)
In-Reply-To: <44065C7C.6090509@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Eric D. Mudama wrote:
> > On 3/1/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>This also begs the question... what controller was being used, when the
> >>single Maxtor device listed in the blacklist was added?  Perhaps it was
> >>a problem with the controller, not the device.
> >>
> >>        Jeff
> >
> >
> > As reported here:
> >
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=177951
> >
> > the controller was a 3114, and the bug was "fixed" by blacklisting his
> > Maxtor drive's FUA support.  I'd like Maxtor drives to be
> > un-blacklisted if possible.
>
> If its 3114 I agree un-blacklisting is the way to go... but its not
> clear to me whether the problematic configuration included sata_sil or
> sata_nv.  Since I'm apparently blind :) which part of the bug points
> conclusively to sata_sil?
>
>         Jeff

The "failing dmesg" has the plextor connected to sata_nv, and the two
Maxtor drives connected to sata_sil, if I read it correctly.  They're
ata5/ata6 ports, mapped as sda/sdb.

Nicolas' comment in the thread "Re: LibPATA code issues / 2.6.15.4"
seemed to say it was the same adapter:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114123989405668&w=2

--eric
