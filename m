From: Andreas Leitgeb <avl@logic.at>
Subject: possible bug in ide-disk.c (2.6.17.13 but also older)
Date: Tue, 19 Sep 2006 10:01:40 +0200
Message-ID: <20060919080140.GE23121@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:18612 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751290AbWISIBz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Sep 2006 04:01:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

I noticed the bug only recently, but checking with older Knoppix
boot-cds, it seems to date back to about 2.6.9, where disk-access
was generally slower, and hpa probably not detected at all)

The symptom of the bug is, that an HPA is believed (by the kernel)
to exist, and the capacity is believed to be one sector larger.
When accessing that one last sector, the harddisk (rightly) reports
an error, which causes the kernel to retry a few times (getting
the same error each time) and finally the kernel switches off dma.

The problem is in  idedisk_read_native_max_address()
and equivalently in idedisk_read_native_max_address_ext()
in a line like this (near the end):
  addr++; /* since the return value is (maxlba - 1), we add 1 */

I believe that this is wrong, in so far as it is device-specific.
My belief is, that what might need to be added instead is drive->sect0
or perhaps something completely different.

This belief is based on that the  addr++; works fine with some other
harddisks in my reach (so obviously, adding one isn't always wrong),
and that other people shared my problem as described in a newsgroup,
found at: <http://tinyurl.com/ee7me> which redirects to

<http://groups.google.com/group/linux.debian.user.german/browse_thread/thread/ab8980cb5ea0a9fb/7f475d3ce8f34211?tvc=2&q=linux+hpa+seagate+0x10>

(german-language, but the dmesg-excerpts and patches speak for themselves)
They suggest to comment out the "addr++;" altogether, which I don't think
is good, but at least doesn't hurt, because a too-small value is
ignored anyway lateron in idedisk_check_hpa(), so in worst case
the hpa is disabled only partially (up to one sector).

Please let me know what you think of it.
People on the list: please Cc: avl@logic.at in this thread.
