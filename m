From: linux@horizon.com
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: 26 Oct 2005 15:18:00 -0400
Message-ID: <20051026191800.28120.qmail@science.horizon.com>
References: <434F9F92.7060805@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:15916 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S964868AbVJZTSO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Oct 2005 15:18:14 -0400
In-Reply-To: <434F9F92.7060805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux@horizon.com, linux-ide@vger.kernel.org

It finaly puked!  Unfortulately, it did NOT survive and while it's less of
a hard lock-up, the root file system is unhappy and I can't log in and copy
the log files, so this is copied by hand.

(Which is a bit odd, because I have the root file system on a RAID-10
such that no controller is critical.  I.e. the mirror pairs are sdb/sdc,
sdd/sde, and sdf/sda.  If the drive just returned -EIO, then the md
layer could drop the drive and use the other mirror.)

I have an entire scrollback buffer full of a mixture of ata3 and ata4
error messages.

The two errors are almost identical except for the "Info fld" value,
whose value is a consistent function of the controller number.

ata3: command timeout
ata3: status=0x50 { DriveReady SeekComplete }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0x78af38
sata_sil24 ata3: resetting controller

ata4: command timeout
ata4: status=0x50 { DriveReady SeekComplete }
sdd: Current: sense key: No Sense
    Additional sense: No additional sense information
Info fld=0xeb9712
sata_sil24 ata4: resetting controller


If it matters, the order of the errors I can see in the
scrollback buffer (but there are clearly more off the top) is
343434343444444433343434344444443.

I will hold the machine in the current state for a couple of hours
in case there's any more debug information that can be retrieved
from the console.

Anyway, thanks a lot for any clues.  I'd really like to push this
machine into production, but it's a bit difficult right now.

Interestingly, the machine was not running any stress tests at the time
of the problem, but pcbackup may have been doing its thing, and it was
recently power-cycled (taken down as non-essential for Monday's hurricane).
