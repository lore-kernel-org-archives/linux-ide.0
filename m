From: Andy Warner <andyw@pobox.com>
Subject: Re: libata problems with 66Mhz Promise SATA150 TX4
Date: Tue, 14 Sep 2004 19:18:51 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040914191851.A7263@florence.linkmargin.com>
References: <m34qm13m8h.fsf@zathras.nivin.org> <41473287.7050101@epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:54986 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265287AbUIOAUo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Sep 2004 20:20:44 -0400
Content-Disposition: inline
In-Reply-To: <41473287.7050101@epita.fr>; from bevand_m@epita.fr on Tue, Sep 14, 2004 at 08:03:51PM +0200
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <bevand_m@epita.fr>
Cc: linux-ide@vger.kernel.org

Marc Bevand wrote:
> [...]
> An easy way to reproduce the problem is to run 4 instances of 'dd' reading
> from 4 disks at the same time. It is much harder to reproduce when reading
> from 3 disks, and quasi-impossible to reproduce when reading from 2 disks.

I've tried, but cannot reproduce it here.

System is:
 - Dual Xeon Dell Poweredge 2600
 - Promise TX4 in 100MHz PCI-X slot.
 - 4 x Seagate ST3160023AS
 - 2.6.9-rc1

I've tried both dd and sg_utils, can't make it fail - no way, no how.

> [...]
> It seems the Promise chip has some problems under high-load conditions:
> the throughput I obtain when reading from 4 disks is 100 MB/s (at 33MHz)
> and 215 MB/s (at 66MHz)...

I'm observing a lower throughput than that, though ~60MB/s; so I'm
going to check to see if there is something else throttling
performance, below the point of failure.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
