From: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Date: Tue, 9 Jul 2002 22:07:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020709200711.GA13401@win.tue.nl>
References: <20020709102249.GA20870@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20020709102249.GA20870@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tue, Jul 09, 2002 at 12:22:49PM +0200, Jens Axboe wrote:

> I've forward ported the 2.4 IDE core to 2.5.25.

Very good!

There are two kinds of objections.
The minor one is political - you can imagine.
The major one is technical. You did not port the 2.4 good PIO
behaviour to 2.5. Bartlomiej already warned about this, so I
need only confirm:

This afternoon I booted 2.5.25 with your patches and two more,
one to prevent an oops when shutting down, the other to fix
ethernet cards detection. Started torturing two disks on
HPT366. After 3 minutes

	hde: status error: status=0x50 { DriveReady SeekComplete }
	hde: no DRQ after issuing WRITE

and seven minutes later

	hde: task_out_intr: status=0x51 { DriveReady SeekComplete Error }
	hde: task_out_intr: error=0x04 { DriveStatusError }

Soon lots of processes were hanging in D. Reboot. e2fsck.

Then booted vanilla 2.4.17. Tortured disks in the same way.
After several hours all is still perfect. I'll leave this
for a night, but so far I have never seen these errors on 2.4
and very often in recent 2.5.

Andries

