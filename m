From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: Sporadic timeouts accessing shingled drives with 3.19.
Date: Mon, 20 Apr 2015 18:01:38 -0500
Message-ID: <ufa383u4d65.fsf@epithumia.math.uh.edu>
References: <ufabnii4k31.fsf@epithumia.math.uh.edu>
	<CAKdFiL5wOg9Ab4nuJuty0GSNGRMbKu9VgePDSHFe6kPzMfyyqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.math.uh.edu ([129.7.128.33]:40051 "EHLO mx2.math.uh.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbbDTXBk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Apr 2015 19:01:40 -0400
In-Reply-To: <CAKdFiL5wOg9Ab4nuJuty0GSNGRMbKu9VgePDSHFe6kPzMfyyqQ@mail.gmail.com>
	(Adrian Palmer's message of "Mon, 20 Apr 2015 15:36:40 -0600")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Palmer <adrian.palmer@seagate.com>
Cc: linux-ide@vger.kernel.org

>>>>> "AP" == Adrian Palmer <adrian.palmer@seagate.com> writes:

AP> I'm the Seagate engineer leading SMR/ZAC/ZBC support in the kernel.
AP> I would be very interested in learning about your setup and
AP> workload.

There's not much to it, really; I just needed a lot of space.  The
machine hasn't really been doing all that much yet besides RAID
resyncs.

Its function is a security system.  IP cameras connect to a web server,
push a video file which gets saved in RAM.  Once done, that file gets
converted to MP4 by ffmpeg with the output going to disk.  A smaller
thumbnail file (lower resolution and sped up) is also generated and
written to disk.  Then an sqlite file is updated and a log file is
written.  That's... about it.  Total writes are about 250GB/day, which
happens to be less than the amount of RAM in the system.

So the bulk of the writes are streaming, and no temporary files ever hit
the disk.  Of course, the OS is there doing whatever writes it feels it
needs to do.

AP> There are 3 types of SMR drives: Drive Managed (DM), Host Managed
AP> (HM), and Host Aware (HA).  I suspect that you have DM drives.

Definitely.  These are just the plain 8TB "archive" disks that Seagate
offers, purchased from Newegg.  Nothing fancy.  The model info was in
the logs: ST8000AS0002-1NA17Z, AR13.

AP> With DM, there is both nothing done, and nothing to be done in the
AP> kernel.  The mechanics of SMR are implemented in the drive,
AP> completely abstracted from the system.  The use case is not targeted
AP> toward RAID applications -- as of yet, I've seen poor performance
AP> from around the web from those that have attempted it.

Well, performance isn't really the goal here.  I'm not sure that "RAID
applications" has any general meaning; if you mean heavy use file
server stuff, sure, the drives are terrible for that.  But the fact that
the drives are in an array doesn't imply any usage pattern at all.  I
just needed a lot of space and some basic redundancy.

However, regardless of the use case at which the drives are targeted,
they should at least not drop off the bus.  Now, at this point I can't
tell if the fault lies in the drives, but given that I'm cranking along
just fine on 3.18.9 while 3.19.4 is mostly useless I know where I'd look
first.

 - J<
