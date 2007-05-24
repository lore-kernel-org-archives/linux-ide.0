From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Thu, 24 May 2007 16:08:34 +0200
Message-ID: <46559C62.2040509@effenberger.org>
References: <4655923E.5000409@effenberger.org> <46559713.9070201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:50424 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbXEXOIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 May 2007 10:08:37 -0400
In-Reply-To: <46559713.9070201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

thanks for the fast reply!

> Looks like a genuine transmission/interface error to me.  How often does
> this occur?  Please try to connect the drive to another port using and
> possibly different power lane.  Also, testing with another drive is a
> good way to track down where the problem is.

it occurs as soon as the drive is being used heavily (load of about 2,x 
on the machine when running our test scripts). About 15 times in 2 or 3 
hours. Will try to change port, power supply and drive.

> Yeah, libata EH is working properly so there shouldn't be any problem
> other than the error messages and a bit slower transfer speed.

So, even if the errors are still there, there is nothing real to worry 
about for me?

There are now new errors with hard errors, is this still ok?

===
ata4.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata4.00: cmd 60/80:00:00:09:97/00:00:0a:00:00/40 tag 0 cdb 0x0 data 65536 in
          res 40/00:04:00:67:14/00:00:1c:00:00/40 Emask 0x4 (timeout)
ata4: soft resetting port
ata4: softreset failed (1st FIS failed)
ata4: softreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: port is slow to respond, please be patient (Status 0x80)
ata4: port failed to respond (30 secs, Status 0x80)
ata4: COMRESET failed (device not ready)
ata4: hardreset failed, retrying in 5 secs
ata4: hard resetting port
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: configured for UDMA/133
ata4: EH complete
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
===

Florian
