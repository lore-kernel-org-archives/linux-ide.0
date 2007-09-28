From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 11:36:13 -0400
Message-ID: <46FD1F6D.5060805@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org> <46FD0D9E.7040808@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45393 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800AbXI1PgR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 11:36:17 -0400
In-Reply-To: <46FD0D9E.7040808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
>> As such, polling is simply an outmoded concept.  It does not make 
>> sense on new hardware, and forcing design decisions down that path 
>> only lead to a cascade of similar design decisions -- pmp_read polling 
>> being just one example of such a result.
> 
> A related tangent here, but I wonder if someday we might consider
> something like NAPI for libata.  Our I/O rates can far exceed those of the
> network stack, and there polling (NAPI) has helped quite a bit.

I certainly think about these issues each time I write a new storage 
driver, given that most new hardware has interrupt mitigation/coalescing 
capability built into it -- in AHCI's case, at my urging.

Storage is a different profile, with quite a bit few interrupts.

Storage interrupt rates are way, way below that of networking.  Ethernet 
is basically forced to deal with an interrupt event every 1K.  By 
design, storage gathers up as much I/O as possible, such that each 
interrupt could be completing 128K, 512K, 1MB or more.

Finally, for storage I/O workloads with lots of smaller I/Os, those 
workloads are often seek-heavy, where any interrupt overhead is few and 
far between, while you're waiting on your slow disk to seek.  You 
/don't/ want to be polling for long milliseconds, waiting for a seek. 
That's a good way to increase your CPU usage, rather than decrease it.

So, there just hasn't been a real need so far.  If interrupt overhead 
becomes an issue, my first step would be to start programming the 
interrupt coalescing hardware that comes in modern SATA controllers.

PCI MSI, found on all new controllers, tends to mitigate interrupt 
overhead even further.


> But our data behaviour is mostly synchronous, whereas network stuff is more
> asynchronous.   But still, with multiple drives all using NCQ on a port,
> a polled interface option might give higher throughput and lower CPU 
> loading.

There are definitely options worth exploring.  And with full ports all 
doing NCQ, you certainly have a lot of events to deal with.

	Jeff


