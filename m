From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [announce] plscsi in Linux
Date: 21 May 2004 14:01:17 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085169677.3083.79.camel@patibmrh9>
References: <1085168815.3083.43.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:23456 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265947AbUEUUB0
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 16:01:26 -0400
In-Reply-To: <1085168815.3083.43.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: dwm@austin.ibm.com
Cc: linux-ide@vger.kernel.org

> > 'plscsi'.  Where would one find this tool?
> 
> http://members.aol.com/plscsi/linux/plscsi.tar.gz

A noisy list of known bugs in plscsi is:

Subject: plscsi issues
http://plavarre.blog-city.com/read/579210.htm

Without the noise, that signal for Linux today includes:

1) FIXME: Parse the device name to default to O_NONBLOCK for /dev/scd$v
/dev/hd$v despite defaulting to O_RDWR | O_NONBLOCK for /dev/sg$n.

2) FIXME: Search more than just /dev/sg* to build the `plscsi -w` list
of connected devices.

3) FIXME: Add ioctl CDROM_SEND_PACKET to coexist with ioctl SG_IO,
mostly for the sake of ide-cd DVD/CD in Linux 2.4.

4) FIXME: Port back to Linux the master source last released as
http://members.aol.com/plscsi/mac/gcsmac.tar.gz

5) FIXME: Rename the .cpp to .c by removing the inline declarations from
all the source except the Windows port.

Pat LaVarre

P.S. All the noise I've collected on SCSI pass through might be
reachable thru:

Subject: SCSI pass thru
http://plavarre.blog-city.com/read/614076.htm


