From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: Re: NCQ general question
Date: Sun, 5 Mar 2006 09:19:18 +0200
Message-ID: <5d96567b0603042319v7b08184cq918fe4ac32da61e3@mail.gmail.com>
References: <5d96567b0602282304o558fb564jd72784bafdd289f5@mail.gmail.com>
	 <440561CB.30201@yahoo.de> <4405A656.1030602@rtr.ca>
	 <20060301135547.GV4816@suse.de>
	 <C6838977-5411-400F-9548-2F22598DC2AE@egenera.com>
	 <4408C0D9.4010202@garzik.org>
	 <98B59AFC-2781-4A8A-82E4-C923B4A48F9E@egenera.com>
	 <4409E623.5070707@garzik.org>
	 <C7155197-3E90-4EDF-9D1A-5A5210248938@egenera.com>
	 <311601c90603041556oce5a50ev8379ea39fa7b65cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:24276 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752122AbWCEHTS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Mar 2006 02:19:18 -0500
Received: by wproxy.gmail.com with SMTP id i27so935630wra
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:19:18 -0800 (PST)
In-Reply-To: <311601c90603041556oce5a50ev8379ea39fa7b65cc@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Steve Byan <smb@egenera.com>, Jeff Garzik <jeff@garzik.org>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>, Gentoopower <gentoopower@yahoo.de>, Linux RAID Mailing List <linux-raid@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Is NCQ supported when setting the controller to JBOD instead of using HW raid?

On 3/5/06, Eric D. Mudama <edmudama@gmail.com> wrote:
> On 3/4/06, Steve Byan <smb@egenera.com> wrote:
> > On Mar 4, 2006, at 2:10 PM, Jeff Garzik wrote:
> > > Measurements on NCQ in the field show a distinct performance
> > > improvement...  30% has been measured on Linux.  Nothing to sneeze at.
> >
> > Wow! 30% is amazing. I'd be interested in knowing how the costs break
> > down; are these measurements published anywhere?
>
> Full-stroke random reads with small operations (4k or less) typically
> show 75-85% performance improvement, from the ability of a 7200rpm
> drive to carve 4ms out of their response time, as well as a huge chunk
> of seek distance.
>
> Random writes, since as you said they're already reordered with cache
> enabled, don't typically show any sort of increase in desktop
> applications.
>
> NCQ FUA writes or NCQ writes with cache disabled should show the same
> ballpark performance improvement as random reads in saturated
> workloads.  Again however, this is for the full-stroke random case.
> Local area workloads need to be analyzed more thoroughly, and may
> differ in performance gain by manufacturer.
>
> --eric
>


--
Raz
