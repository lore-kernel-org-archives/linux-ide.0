From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 00:24:42 +0300
Message-ID: <47507F9A.3080109@msgid.tls.msk.ru>
References: <47506237.3000406@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:20211 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbXK3VYp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 16:24:45 -0500
In-Reply-To: <47506237.3000406@clear.net.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: linux-ide@vger.kernel.org

Richard Scobie wrote:
> If one disregards the rotational speed and access time advantage that
> SAS drives have over SATA, does the SAS interface offer any performance
> advantage?

It's a very good question, to which I wish I have an answer myself ;)
Since I never tried actual SAS controllers with SAS drives, I'll
reply from ol'good SCSI vs SATA perspective.

> For example, assume a SAS drive and a SATA drive can both sustained
> stream 70MB/s. A 16 drive JBOD SAS enclosure with internal SAS expander
> is connected via a 4port SAS RAID controller, configured for RAID 5
> across all 16 drives.
> 
> If tests are then run reading and writing a multi gigabyte file to empty
> arrays made up of 16 SAS drives and 16 SATA drives, would the results be
> identical?

In this scenario, I don't think there will be any difference between
the two.  With SCSI, one is limited by SCSI bus speed, which is 320Mb/sec
(640Mb/sec for two-channels etc).   Hopefully there isn't such a
limit in SATA/SAS world, at least not in theoretical configuration.
In your case, 4port SAS controller is about 1200Mb/sec theoretical
maximum (300Mb/sec per port), which is further limited by system
bus speed (PCIe or PCI-X).

But note that while you're doing an operation in one stream, you'll
most likely be limited by a speed of a SINGLE drive, since at any
given time, you're writing/reading only to/from one drive (I'm
simplifying things here, -- omitting calculating/writing parity
info in raid5, which may be further limited by controller's
XOR operation speed -- let's assume it's a raid0 array for now,
not raid5).

The only case where more than one drive is affected is when you
cross strips - go from one drive to another in a raid layout.
When a controller receives a request which spans strips, it
can split the request into two and issue parallel requests to
two drives. Here, we will see speed 2x larger than of a single
drive...

Where things starts to become different is when there are
MULTIPLE readers and writers, so that an I/O subsystem has
much more chances for parallelism.

And here, it all depends on the controller, and probably on
the driver too, AND on the drives.

Here are several observation I collected in several years of
expirience with various raid controllers and drives.

First of all, I've yet to see a controller that is really able
to handle multiple requests in parallel.  Usually, multiple
I/O threads gets exactly the same summary performance as a
single thread - UNLIKE of linux software raid which clearly
scales exactly to the number of drives (having in mind raid0
again and omitting raid5 complexity).  All raid cards from
Adaptec (at least up to and including their first SATA cards),
from HP (SmartArrays), from LSI shows this behavior - no matter
how many drives you throw at them, no matter how many threads
you start, the result will be the same.  Many external "smart"
disk arrays (not JBOD boxes but with RAID controllers inside,
connected using FC or iSCSI, with built-in stacability and
external redundancy) also show this behavior.

Maybe, just maybe, I've only dealt with their "cheap" products
so far, but I lost any hopes long ago, and decided that HW
raid solutions is something to avoid as much as possible.

Now for the actual difference between SATA and SCSI drives.
And here, again, is something interesting.

They says that modern SATA drives has NCQ, which is "more
advanced" than ol'good TCQ used in SCSI (and SAS) drives.
I've no idea what's "advanced" in it, except of that it
just does not work.  There's almost no difference with
NCQ turned on or off, and in many cases turning NCQ ON
actually REDUCES performance.

It's in a very good contrast with SCSI drives, where -
depending on workload (I'm again talking about multiple
I/O processes - for single I/O there's no difference
in NCQ/TCQ or raid arrays/controllers), you may get 20..
400% increase in speed - of a SINGLE drive.  Even 9Gb
SCSI disks from Seagate - circa 1998 - shows this behavior
(they're alot slower than todays ones, but speed increase
due to TCQ is very well of the same extent).

With linux software RAID configuration and with TCQ-enabled
SCSI drives, there's a very significant difference between
SATA and SCSI.  Linux raid code can do things in parallel,
and individual SCSI drives plays here nicely too, so the
end result is very good.  With SATA, linux raid still plays
its role as with SCSI, but the drives don't scale at all.
And with hardware raid controller, even the raid code doesnt
scale - so end result is like single drive in single-stream
test, which is the worst of all.

I'd LOVE to be proven wrong, but so far the only evidence I
see is the one that proves my observations.

Recently I removed an IBM SeveRaid module from a rackmount
IBM server (had to find how to disable the damn thing and
expose AIC79xx controller - it turned out to be quite
difficult) and replaced the raid with linux software raid
solution - server speed (it's a database server) increased
about two times, so that users noticied it immediately
(hey, our server works unusually fast today!).

Go figure.

> I ask, as I have seen a comment to the effect that SATA drives are less
> efficient interacting at the bus/interface level in this situation, but
> I have had no luck confirming this after extensive searching.

I recall: single-stream tests will not show any measurable differences.
Its the multi-reader-writer tests which will.

/mjt
