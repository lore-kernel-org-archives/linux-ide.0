From: Jens Axboe <axboe@suse.de>
Subject: Re: Gigabyte i-Ram cards
Date: Wed, 22 Mar 2006 08:33:56 +0100
Message-ID: <20060322073355.GU4285@suse.de>
References: <441F63E6.2090204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:63755 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751066AbWCVHdz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2006 02:33:55 -0500
Content-Disposition: inline
In-Reply-To: <441F63E6.2090204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Mar 20 2006, Jeff Garzik wrote:
> 
> While responding to email related to Bugzilla# 6163 [1], I took a look 
> at the Gigabyte i-Ram[2]:  PCI card, where PCI only provides power to 
> some DIMMs.  Data xfer to/from DIMMs via SATA cable.  So, at current 
> prices[3] one can get a 1GB Solid State Disk for US$206:  US$153 for the 
> card, and US$53 for 1GB pc2700 ddr.
> 
> I'm impressed.  I ordered one to help debug BZ#6163, but I think these 
> cards will help expose bugs in libata due to their high speed.  With 
> these cards, we can push more data through libata than would normally be 
> possible with a standard disk drive.

But they are still only 1.5Gbps, right? Which is really a shame, since
that makes it only about twice as fast as the good drives out there in
terms of sequential transfer. Seeks are in a different league of course
:-)

Still strange why they did not go for the full 3.0Gbps link speed.

-- 
Jens Axboe

