From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: What to do about the 2TB limit on HDIO_GETGEO ?
Date: Tue, 25 Mar 2008 11:25:52 -0400
Message-ID: <76366b180803250825s10d706b3ja54df079251d554c@mail.gmail.com>
References: <47E875AD.1000901@rtr.ca>
	 <alpine.LFD.1.00.0803242254020.2775@woody.linux-foundation.org>
	 <47E8FF58.8050209@rtr.ca> <47E90CDA.600@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:20937 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbYCYPZz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 11:25:55 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1787466rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 08:25:52 -0700 (PDT)
In-Reply-To: <47E90CDA.600@emc.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Mark Lord <lkml@rtr.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Greg KH l <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>

On Tue, Mar 25, 2008 at 10:31 AM, Ric Wheeler <ric@emc.com> wrote:
>  > Yeah.  Except Dell will undoubtedly have them in desktops
>  > within 2 years, and tons of people (myself included) still use
>  > 32-bit (K)Ubuntu on our systems, simply for the better binary
>  > compatibility that it is perceived to give with things like
>  > browser plugins and stuff.
>
>  I think that there are many embedded applications (lots of them linux based)
>  which have large amounts of storage behind low power, low cost 32 bit CPU's.
>
>  Think of the home/small office NAS boxes that you can get from bestbuy or other
>  big box stores. Those devices today have 4 S-ATA drives (each of which can be
>  1TB in size).

I can attest to this. I hear from a reliable source (manufacturer)
that 2TB 3.5" disks will be out no later than first half of 2009
(possibly even sooner, or at least 1.5TB). I currently use 1TB disks
with a Geode LX based motherboard for SATA RAID and I plan on
upgrading/consolidating to larger sizes once they become available in
the market. 64-bit is not an option for me on this hardware.

-Andrew
