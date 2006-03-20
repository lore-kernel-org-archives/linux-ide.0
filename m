From: Michael Schierl <schierlm@gmx.de>
Subject: Re: Resume problems on Fujitsu-Siemens AMILO M7440G -- SATA
Date: Mon, 20 Mar 2006 19:43:04 +0100
Message-ID: <441EF7B8.4040901@gmx.de>
References: <44076762.404@gmx.de> <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1141349791.19013.1.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[added linux-ide to CC]

Shaohua Li schrieb:

> If the video is dark, please try the boot options listed in
> documentation/power/video.txt.

Okay, I got video working on vanilla 2.6.16 by using "vbetool post" and
"vbetool vbestate restore" directly after "echo mem >/sys/power/state".

I copy all stuff need into tmpfs to ensure that it can restore the video
without hard disk access.

when accessing hard disks first time after resume, I get (wrote it by
hand so maybe this is not 100% correct)

ata1: handling error / timeout
ata1: port reset  p_ is 400000 is 0 pis 400000 cmd 8007
                          tf 80 ss 113 se 405000
ata1: status = 0x50 {DriveReady SeekComplete}
sda: current: senseKey 0x0 ASC  0x0 ASCQ 0x0

Sometimes there is "cmd 6" instead of "cmd 8007".

What to do, what to test?

I don't have any way of getting information out of my machine after
resume except on display (hard disks do not work after resume, the
notebook does not have a serial port and network does not work after
resume either) and by flashing keyboard LEDs, so transcribing huge dmesg
output would be a pain...

Please CC me since I am not on the list(s). Thank you.

Michael
