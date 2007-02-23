From: Jim Paris <jim@jtan.com>
Subject: Re: Disk stuck in error recovery loop with AHCI
Date: Fri, 23 Feb 2007 02:28:26 -0500
Message-ID: <20070223072826.GA2763@jim.sh>
References: <20070221052022.GA15964@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:53014 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbXBWH2a (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Feb 2007 02:28:30 -0500
Received: from neurosis.jim.sh (localhost [127.0.0.1])
	by neurosis.jim.sh (8.13.8/8.13.8/Debian-2) with ESMTP id l1N7SRm3002935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 02:28:27 -0500
Received: (from jim@localhost)
	by neurosis.jim.sh (8.13.8/8.13.8/Submit) id l1N7SQgD002934
	for linux-ide@vger.kernel.org; Fri, 23 Feb 2007 02:28:26 -0500
Content-Disposition: inline
In-Reply-To: <20070221052022.GA15964@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wrote:
> I've been trying to track down data corruption I'm seeing on my
> server.

Turns out it was a bad disk.  Not a media error, but maybe bad RAM or
logic on the drive.

> I saw an error with AHCI that I hadn't seen before with the other
> controllers.
...
> Because the error at [11588.19xx] was repeated 30 times, I suspected
> NCQ.  I set the queue_depth on all 6 disks down to 1, and haven't seen
> the same problem since

It's not related to NCQ.  I still saw the problem with it disabled,
and it finally went away when I enabled spread-spectrum clocking in
BIOS, even once I turned NCQ back on.  So this report is bogus.

Still, it seems that some improvements could be made to the EH when
this sort of thing happens.  For example, after "speed down requested
but no transfer mode left" a few times in a row, maybe it would make
sense to just fail the disk and give up.  That would have allowed
higher layers like MD to recover.

-jim
