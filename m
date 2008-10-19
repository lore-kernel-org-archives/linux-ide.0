From: Mark Lord <liml@rtr.ca>
Subject: A USB enclosure that supports SCSI-ATA-Passthru (cheap!)
Date: Sun, 19 Oct 2008 12:31:08 -0400
Message-ID: <48FB60CC.5000008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57139 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbYJSQai (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2008 12:30:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>

I believe this is of possible interest to others here:

Most newer USB enclosures now support SCSI STOP/START commands.

But.. the Western Digital 2.5" mobile USB2 enclosures (SATA inside)
appear to also support the SCSI-ATA-Command-Passthru protocol.
These are the first ones I have seen here that do this.

So, things like "hdparm -I /dev/sdb" work without fuss on an
external USB drive when used with these enclosures.
As does setting automatic spin-down with "hdparm -S".

And as an added bonus, they're rather cheaply priced with drive included.

On the downside, smartctl does not work with the one I have here,
complaining thusly:

> $ smartctl -a  -T permissive -T permissive /dev/sdb
> smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> Device: WD       823AS  External  Version: 1.04
> scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
> >> Terminate command early due to bad response to IEC mode page
> 
> Error Counter logging not supported
> scsiModePageOffset: response length too short, resp_len=4 offset=4 bd_len=0
> Device does not support Self Test logging


Regardless, these devices are commonly available at Costco and other
discount retailers.  Mine came with a 250GB drive inside, and has
model number WS2500XMS-00 on the outside.  I hope to pick up another
with a 320GB drive soon-ish, and see if it also has passthru.

Model:  WD-250XMS-00 (with 250GB drive inside, removeable).
USB info:  1058:0702 Western Digital Technologies, Inc.
Bridge chip by InitIO:  INIC-1606L

Cheers
