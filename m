From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] ahci: Allow setting a default LPM policy for mobile chipsets
Date: Wed,  6 Dec 2017 16:41:07 +0100
Message-ID: <20171206154110.11548-1-hdegoede@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751362AbdLFPlN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 6 Dec 2017 10:41:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,

On many laptops setting a different LPM policy then unknown /
max_performance can lead to power-savings of 1.0 - 1.5 Watts (when idle).

Modern ultrabooks idle around 6W (at 50% screen brightness), 1.0 - 1.5W
is a significant chunk of this.

There are some performance / latency costs to enabling LPM by default,
so it is desirable to make it possible to set a different LPM policy
for mobile / laptop variants of chipsets / "South Bridges" vs their
desktop / server counterparts.

This series adds a new ahci.mobile_lpm_policy kernel cmdline option,
which defaults to a new SATA_MOBILE_LPM_POLICY Kconfig option so that
Linux distributions can choose to set a LPM policy for mobile chipsets
by default.

I realize that this series will not be entirely uncontroversial,
enabling LPM by default is not entirely without risk of regressions.
At least min_power is known to cause issues with some disks, including
some reports of data corruption.

But this series only adds a Kconfig option to allow distributions to
select a different LPM policy for mobile chipsets if they which to do so,
the default value is unchanged from before.

I've done a blog-post a while ago to ask users to test this and
specifically the new med_power_with_dipm option which mirrors the
Intel RST Windows drivers defaults:

https://hansdegoede.livejournal.com/18412.html

Test results from this can be found here:
https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife#How_To_Test

All testing sofar has shown that the med_power_with_dipm option seems to
be safe, even with SSDs which are known to corrupt data with the min_power
setting. Taking this into account, one thing to consider is the following
change to the Kconfig changes in the last patch in the series:

 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for mobile chipsets"
-	range 0 4
+	range 0 3
 	default 0
 	depends on SATA_AHCI
 	help

Thus effectively forbidding choosing min_power as default at the Kconfig
level.

Regards,

Hans
