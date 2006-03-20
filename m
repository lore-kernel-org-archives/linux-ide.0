From: Mark Lord <liml@rtr.ca>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G -- SATA
Date: Mon, 20 Mar 2006 14:39:02 -0500
Message-ID: <441F04D6.4070404@rtr.ca>
References: <44076762.404@gmx.de> <1141349791.19013.1.camel@sli10-desk.sh.intel.com> <441EF7B8.4040901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <441EF7B8.4040901@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Schierl <schierlm@gmx.de>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Michael Schierl wrote:
..
> Okay, I got video working on vanilla 2.6.16 by using "vbetool post" and
> "vbetool vbestate restore" directly after "echo mem >/sys/power/state".
> 
> I copy all stuff need into tmpfs to ensure that it can restore the video
> without hard disk access.

OOhh.. clever, wish I'd thought of that,
as all of my (now solved) suspend/resume issues
were *all* libata related.

> when accessing hard disks first time after resume, I get (wrote it by
> hand so maybe this is not 100% correct)
> 
> ata1: handling error / timeout
> ata1: port reset  p_ is 400000 is 0 pis 400000 cmd 8007
>                           tf 80 ss 113 se 405000
> ata1: status = 0x50 {DriveReady SeekComplete}
> sda: current: senseKey 0x0 ASC  0x0 ASCQ 0x0
> 
> Sometimes there is "cmd 6" instead of "cmd 8007".
> 
> What to do, what to test?

Randy Dunlop's libata-acpi patch might work for you.
http://www.xenotime.net/linux/SATA/

Cheers

