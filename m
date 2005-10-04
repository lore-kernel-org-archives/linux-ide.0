From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 0/2] libata: support SATA devices on SAS HBAs
Date: Tue, 04 Oct 2005 05:56:48 -0400
Message-ID: <434251E0.9060000@pobox.com>
References: <4341A91A.3020000@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63653 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751201AbVJDJ4x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 05:56:53 -0400
In-Reply-To: <4341A91A.3020000@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: brking@us.ibm.com
Cc: linux-ide@vger.kernel.org

Brian King wrote:
> The following patches enhance libata to allow SAS device drivers
> to utilize libata to talk to SATA devices. It introduces some
> new APIs which allow libata to be used without allocating a
> virtual scsi host. This is just a snapshot of what I've
> come up with at this point and I figured I would post it to
> see if I was heading in a reasonable direction or not, so
> don't expect the code below to do anything useful at this point
> as it is untested.

hmmmm, neat.  My gut feeling feeling says a slightly better direction 
might be warranted, but I'll have to think a bit to put that feeling 
towords.

* One thought is the desire to allocate a single ata_host_set for the 
HBA, rather than avoiding ata_host_set.
* Another thought is the locking scheme -- Christoph once poked me about 
libata's use of scsi_assign_lock(), which I rather like but he didn't :) 
  So by the transitive(?) property, if libata's locking is useful, then 
your solution is probably OK.  And vice versa.
* I also wonder if there isn't any severe leakage or oops somewhere, 
because you don't really use ata_host_set, just ata_port.

But note again, these are 6am thoughts, not in-depth analysis.

	Jeff


