From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: SATL support for hdparm?
Date: Sat, 14 Feb 2009 23:21:14 +0100
Message-ID: <20090214222114.GI17914@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xi.wantstofly.org ([80.101.37.227]:52810 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbZBNWVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 17:21:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: dgilbert@interlog.com, mlord@pobox.com

[ please CC, not on the list ]

Hi,

I have a bunch of SATA disks hanging off a SAS expander on which I
would like to disable APM (using hdparm -B).  This doesn't work as-is,
and from reading:

	http://smartmontools.sourceforge.net/smartmontools_scsi.html

it appears that I'd need to hack hdparm to use the ATA PASS THROUGH
SCSI command to make it talk to SATA disks behind a SAS expander, as
was already done for smartctl.  Did anyone implement something like
this for hdparm yet by any chance?


thanks,
Lennert
