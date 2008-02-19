From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Maxtor 7V300F0 on sil3114 VS Maxtor Atlas 15K2 on adaptec29160 strangeness
Date: Tue, 19 Feb 2008 13:37:20 +0100
Message-ID: <bb145bd20802190437g5da22abcyb72ad63b5a939b1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:25517 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYBSMhV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 07:37:21 -0500
Received: by py-out-1112.google.com with SMTP id u52so2587174pyb.10
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 04:37:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

SUMMARY: iff the Atlas 15K II (on adaptec29160) is also connected to
the system, the MaXLine Plus III (on sil3114) doesn't work properly or
maybe even at all.

HARDWARE:
Tyan Thunder K8W (S2885)
2x Opteron 254
2x2x 512MB (=2GB) Crucial DDR333 ECC RAM
Seasonic modular 700W PSU
onboard sil3114 w/ Maxtor MaXLine Plus III 300GB SATA2 (7V300F0)
Adaptec 29160 w/ Maxtor Atlas 15K II 74GB 68pin LVD SCSI and Plextor PX-40TS
(originally 2 WD RE2 500 GB SATA2 and a WD Raptor 74 were also
connected to the sil3114, but I've removed them for testing)

All components have been working nicely with Linux before, just not in
this particular combination.

PROBLEM:
First manifestation was dban-1.07 failing to wipe the Maxline. The
wipe speed would start at ~
60-70000KB/s, then drop off to half within a few seconds and to four
digits in under 90 seconds. After crawling on for a few more minutes
dban would fail, with the logged dmesg being full of parity errors.
Apparently that dban version uses 2.4.33.

I thought maybe a newer kernel would help and tried
dban-beta.2007042900_i386, which is the newest version and uses
2.6.20.7. That version fails immediately after starting the wipe - I
couldn't see why, in the log, but it's embedded in
not-too-readable-in-a-text-editor XML now, so maybe I missed it.

So maybe it's the hardware, right?
- ran the manufacturer's diagnostic on the Maxline using the box it
had worked in before. No errors, normal speed.
- put it back in the problem box and exchanged all SATA cables for new
ones. Doesn't work.
- removed the other SATA drives. Doesn't help
- tried it on the three other SATA connectors in turn. No change
- disconnected the Atlas 15K2. Suddenly the Maxline works.
- suspecting a resource conflict I rotated the Adaptec through all PCI
slots. No change. Works only as long as the Atlas isn't connected.
- changing the PCI scan order in the BIOS "works" but I'm afraid
that'll just mask the problem.

All other disks are fine in any config, it's just the Maxline that
acts up and only when the SCSI disk is also connected. I've not gotten
an actual linux (Debian) install to fail on the box yet, even with
both disks connected, but dban is usually a good hardware test for the
disk subsystem, so I'm worried. This box is sopposed to become a
nearline backups repository and data integrity (within a hobby budget
:( ) is top priority.

Is there any incompatibility known between the Maxtor 7V300F0 and the
sil3114 and if yes, why does it take a SCSI disk to trigger it?

Suggestions welcome. I could:
- sell the MaxLine and hope that it was the culprit
- disable the onboard sil3114 and buy a PCI card. Only the Promise
SATA300 TX4 is available though and that doesn't seem too hot, either.
- or both


If you'd like any logs etc just say so. (I'm away from the box for the
next ~60 hours, though.)

Regards,

Chris
