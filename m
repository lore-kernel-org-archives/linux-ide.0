From: Shaohua Li <shaohua.li@intel.com>
Subject: NCQ is slower in some cases?
Date: Thu, 23 Jul 2009 11:44:03 +0800
Message-ID: <1248320643.9035.19.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HzsO6LhVxuJWZcPdnIgr"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16663 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbZGWDoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jul 2009 23:44:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, tj@kernel.org, "Zhang, Yanmin" <yanmin.zhang@intel.com>


--=-HzsO6LhVxuJWZcPdnIgr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
I did some tests about NCQ. It appears enabling NCQ sometimes will make
disk slower than disabling it (well it does improve performance in
random io case). Test using fio with attached script.
With queue_depth 1 (so NCQ is disabled), the disk speed is about 27m/s.
with queue_depth 2 - 31, the speed is about 24m/s.

blktrace shows the Q2C time with NCQ enabled increases about 10%.
Specifically the D2C time increases and time of other stages hasn't
obvious changes.

I added a 'udelay()' at the end of ahci_qc_issue(), as my test does
'submit a request, wait it and then submit another', so if the udelay
time is shorter than the disk io time, the udelay should not be harmful.
My test shows when the udelay time is smaller than 90us, the delay
hasn't any impact to the ncq enabled case. On the other hand, the udelay
time should be shorter than 30us otherwise the ncq disabled case has
obvious performance downgrade. This test seems suggesting diskio is
slower in ncq enabled. Is the single diskio slow in ncq case expected?

Thanks,
Shaohua

--=-HzsO6LhVxuJWZcPdnIgr
Content-Disposition: attachment; filename="test.fio"
Content-Type: text/plain; name="test.fio"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[global]
ioengine=libaio
direct=1
size=256m
directory=/tmp/a
ioscheduler=cfq
invalidate=1

[a]
rw=read
iodepth=1
cpus_allowed=0

--=-HzsO6LhVxuJWZcPdnIgr--

