From: Don Mullis <dwm@meer.net>
Subject: Re: Hitachi disk: spurious completions during NCQ
Date: Sun, 14 Oct 2007 23:07:51 -0700
Message-ID: <87zlyksyfc.fsf@meer.net>
References: <9cP6K-6rV-29@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760279AbXJOGIY@vger.kernel.org>
In-Reply-To: <9cP6K-6rV-29@gated-at.bofh.it> (Luca Tettamanti's message of "Wed\, 10 Oct 2007 21\:10\:22 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


> ata3.00: spurious completions during NCQ issue=0x0 SAct=0x407fd FIS=005040a1:00020000
> ata3.00: cmd 61/08:00:c7:5a:82/00:00:1b:00:00/40 tag 0 cdb 0x0 data 4096 out
>          res 50/00:10:07:5b:82/00:00:1b:00:00/40 Emask 0x2 (HSM violation)


This has been seen with several Hitachi drives.  There's speculation
that it's due to a bug in the drive firmware:

http://groups.google.it/group/linux.kernel/browse_thread/thread/a4bd3c19565a2009/389817602f0cd551?hl=it&lnk=st&q=hitachi+hsm+violation&rnum=3#389817602f0cd551
https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470


A workaround:

Index: /etc/rc.local
===================================================================
--- .orig/etc/rc.local  2007-10-13 14:57:10.000000000 -0700
+++ /etc/rc.local       2007-10-13 14:59:21.000000000 -0700
@@ -11,4 +11,7 @@
 #
 # By default this script does nothing.

+# See https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.22/+bug/137470/
+echo 1 > /sys/block/sda/device/queue_depth
+
 exit 0
