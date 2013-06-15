From: scar <scar-47zfDnpWZoPQT0dZR+AlfA@public.gmane.org>
Subject: troubleshoot disk problems / libata error messages
Date: Fri, 14 Jun 2013 21:17:36 -0700
Message-ID: <kpgpst$fh8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-ide-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

hello, not sure if this is best place to seek help but i couldn't seem
to find any more appropriate mailing lists...

i've been having HDD issues lately, and the issues have persisted across
two different disks and two different SATA ports on the motherboard

system is running Ubuntu 10.04 Linux 2.6.32-47-generic #109-Ubuntu SMP
Tue May 7 02:02:22 UTC 2013

at first, i was getting messages related to a Western Digital 300 GB
drive that houses /boot and root file systems.  unfortunately i lost my
dmesg from that time but i remember receiving a lot of "SError: {
HostInt <one other SError too> }"  errors.  also things like "hard
resetting link", "softreset failed (device not ready)", "applying SB600
PMP SRST workaround and retrying", "SATA link up 3.0 Gbps (SStatus 123
SControl 300)" were prominent in dmesg.  i noticed the SATA link would
be dropped to 1.5 Gbps too.  eventually the system became unusable and
unbootable, as well as filesystem corrupted.  fsck fixed it and system
was up and running again.

smartctl for the drive showed good health (i believe)[1] so i moved the
drive to another port on the motherboard (currently ata3.00 to libata).
 so far libata has not produced any errors related to the drive but i
just heard a knocking sound and this logged in dmesg[2].  ata4 has
another disk drive, another port, and also different error messages.
smtartctl for this drive also shows good health[3].

so since i have been having issues with two disks and two ports i am
thinking it is something further up the cable?  like power or SATA cable
issue, power supply issue, or motherboard issue... what say you? thanks


1. http://pastebin.com/wfZ5q5TL
2. http://pastebin.com/wrtTHWYB
3. http://pastebin.com/2TGjGhQd

--
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
