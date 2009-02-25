From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise fails to detect all 4 HDD on the TX4 since 2.6.26
Date: Wed, 25 Feb 2009 20:43:49 +0100
Message-ID: <18853.40821.848719.25410@harpo.it.uu.se>
References: <7c8826910902241756j6e2d9c88pc293503e9cbf73ae@mail.gmail.com>
	<49A50F20.9060600@kernel.org>
	<7c8826910902251005v5bd37867v6c7f688224e9af3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:59314 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756912AbZBYUGj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Feb 2009 15:06:39 -0500
In-Reply-To: <7c8826910902251005v5bd37867v6c7f688224e9af3f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Cui <cuicui@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Mike Cui writes:
 > If you want the full kernel boot log I can get it to you in a couple
 > of days. But here is what I remember from the kernel logs. It probes
 > each of the 4 ports, and it always thinks that the first port is "link
 > down". The drives I have plugged into it are samsung HD753LJ

1. Have you tried with different disks on port 0? Preferably also
   with different models or from different manufacturers.
2. Does it matter if all ports are populated? Is there any difference
   if only port 0 is populated as opposed to all 4 being populated?

Full boot logs from the last working kernel and first non-working one would
be useful. And please make them www.kernel.org kernels, not Ubuntu ones.

/Mikael

 > On Wed, Feb 25, 2009 at 1:28 AM, Tejun Heo <tj@kernel.org> wrote:
 > > Mike Cui wrote:
 > >> Hi,
 > >>
 > >> I tried to update to Ubuntu 8.10 from 8.04 last week, and noticed that
 > >> after the update the sata_promise driver can no longer detect all 4
 > >> HDDs that I have plugged into the SATAII300TX4 card. It always reports
 > >> that the link is down on the first port. I also tried booting a gentoo
 > >> kernel with 2.6.26, same problem. However, Ubuntu 8.04 with 2.6.25
 > >> seems fine. Is this a known problem?
 > >
 > > Hmm... Can you please install to another disk and try 2.6.28.7 and
 > > post the kernel boot log if it fails too?
 > >
 > > Thanks.
 > >
 > > --
 > > tejun
 > >
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > 
