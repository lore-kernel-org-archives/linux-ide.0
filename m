From: Pat LaVarre <p.lavarre@ieee.org>
Subject: [announce] plscsi in Linux
Date: 21 May 2004 13:46:55 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085168815.3083.43.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:53448 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266017AbUEUTrH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 15:47:07 -0400
List-Id: linux-ide@vger.kernel.org
To: dwm@austin.ibm.com
Cc: linux-ide@vger.kernel.org

> Re: [PATCH] atapi request sense work
> ...
> 'plscsi'.  Where would one find this tool?

http://members.aol.com/plscsi/linux/plscsi.tar.gz

ends the depressingly noisy web trail:

http://www.google.com/search?btnI=lucky&q=plscsi
http://members.aol.com/plscsi/
http://members.aol.com/plscsi/linux/

There you will find,

plscsi (Programming Language, SCSI) is a tool, conceptually trivial,
actually complex, typed by me (Pat LaVarre) with help from many, but not
yet offered among the sg utils of linux-scsi/ Douglas Gilbert.

I wrote plscsi to make { open(); ioctl(); close(); exit(); }
interactive, taking the SCSI CDB in hex from the command line and
streaming the binary data in/ out thru stdout or stdin.  Relevant ioctl
in Linux include CDROM_SEND_PACKET and SG_IO.

Such an interactive tweak turns out to be exactly what you need, for
example, to make linux-2.6.6-bk8 SATAPI read/write.

A tutorial is http://members.aol.com/plscsi/tutorial/

Linux-style source is http://members.aol.com/plscsi/mac/gcsmac.tar.gz

http://plavarre.blog-city.com/read/542134.htm
is me arguing that a C interpreter would do a better job.

Among the folk of linux-ide I trust we have no need of the disclaimer:

Learning to use a tool like PLScsi will probably remind you of the need
to backup often. If you won't enjoy that lesson, then please don't pick
up the tool. Potential side effects include kernel panics, destroyed
discs, destroyed devices, and even imperceptibly subtle forms of data
corruption. Storage devices differ from modems first by being designed
to record your mistakes permanently, and second by defining some
commands or sequences of commands to mean self-destruct.

Pat LaVarre


