From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Date: Tue, 21 Mar 2006 07:48:03 -0500
Message-ID: <20060321124802.GA12228@ti64.telemetry-investments.com>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <441B5AD5.5020809@garzik.org> <20060318080618.GA19929@ti64.telemetry-investments.com> <441BCB3C.6060202@garzik.org> <20060319232317.GA25578@ti64.telemetry-investments.com> <441F56AD.8020001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:40587 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751609AbWCUMsE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 07:48:04 -0500
Content-Disposition: inline
In-Reply-To: <441F56AD.8020001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Mar 20, 2006 at 08:28:13PM -0500, Jeff Garzik wrote:
> Thanks a lot for testing.
> 
> I've stored the sata_nv updates I sent you in the 'nv-adma' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
 
OK, I'll pull from there for further testing.
 
> Dumb question, to be certain that I understood your first paragraph: 
> you do indeed see at least -some- success talking to devices on port 1, 
> 2, 3... ?  i.e. not just port 0 works?
 
I can start up the RAID1's on ports 2 and 3, activate the VG on top
of /dev/md5, mount the filesystems, and use them.  I was able to
cp -a the mounted root filesystem from /dev/md2 to a subdir on /dev/sda1.

It was only when I started up a few copies of "tar cf /dev/zero ... &"
that the timeouts began.

> Weird.  Well, now that we appear to have narrowed the non-ADMA case down 
> to inb(), I'm going to punt this one as not-my-problem ;-)
 
Roger.  I'll stare at it a bit longer, but I probably need to order three
SATA adapters.  Any recommendations?  These Tyan 2895 machines all have
2-4 74GB WD Raptors in them.  I don't really need expensive 3ware or
Areca cards for these workstations, just reasonable latencies.

Thanks.

	-Bill
