From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] fix cdrom mt rainier probe
Date: 13 Jul 2004 11:57:09 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1089741428.3806.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:9364 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263769AbUGMR5M
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jul 2004 13:57:12 -0400
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org

Jens A:

--- http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.8-rc1
--- ...
[PATCH] fix cdrom mt rainier probe

Mt rainier probe must be deferred to media load time, since it requires a
valid media (the drive may present a different capability based on what
media is loaded). This fixes that for ide-cd and sr.
...
---

Looks like something broke in deciding disc rewritable or not?

Only for /dev/hdd PATAPI, not for /dev/scd0 USB?

I see again we have rewritable by ioctl does not imply rewritable by dd
and mount.  I'll blog my exploration outside, then report back if I come
to understand more, but specifically so far I've seen:

$ uname -srm
Linux 2.6.7 i686
$ sudo rrd scan
/dev/scd0 is Iomega RRD 74.B rw
/dev/hdd is Iomega RRD 74.B rw
$
$ sudo dd of=/dev/scd0 bs=64K count=1 if=/dev/zero
1+0 records in
1+0 records out
$ sudo dd of=/dev/hdd bs=64K count=1 if=/dev/zero
1+0 records in
1+0 records out
$

$ uname -srm
Linux 2.6.8-rc1 i686
$ sudo rrd scan
/dev/scd0 is Iomega RRD 74.B rw
/dev/hdd is Iomega RRD 74.B rw
$
$ sudo dd of=/dev/scd0 bs=64K count=1 if=/dev/zero
1+0 records in
1+0 records out
$ sudo dd of=/dev/hdd bs=64K count=1 if=/dev/zero
dd: writing `/dev/hdd': Operation not permitted
1+0 records in
0+0 records out
$

Pat LaVarre
http://linux-pel.blog-city.com/read/728344.htm


