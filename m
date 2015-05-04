From: =?UTF-8?B?R8O8bnRlciBXYWxsZXI=?= <g.wal@web.de>
Subject: Samsung 840 EVO
Date: Mon, 04 May 2015 14:38:55 +0200
Message-ID: <5547685F.7000103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57221 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbbEDMjF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 May 2015 08:39:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Dear Tejun,
the subject Samsung SSD is having performance issues with "old data"
which Samsung now addresses with a new firmware. As often is the case,
Linux users find it a bit more difficult to apply that fix. However, I
also have a Windows system, so it should be no big deal for me.

But there is also a big concern for Linux users which this FW version
seems to introduce. The link below points to a warning (backed by
others, elsewhere on the web) that fstrim in combination with this FW
will wreck your drive.
http://www.overclock.net/t/1507897/samsung-840-evo-read-speed-drops-on-old-written-data-in-the-drive/2640%23post_23827674
(search for fstrim)
I raised this in a discussion thread of the Ubuntu MATE community and
was pointed to the SSD blacklist that is part of the module
libata-core.c which names you as the maintainer. I wonder if you could
take a look at this issue - maybe you want to add the device to the
blacklist thereafter if need be.
If you find the time and find this worthwhile to investigate I would
appreciate a brief notification of the outcome. For now I am holding
back the FW update.

Best regards

Guenter Waller
