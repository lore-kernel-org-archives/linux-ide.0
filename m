From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET #upstream-fixes] libata: improve flaky link handling
Date: Thu, 29 Jan 2009 20:31:28 +0900
Message-ID: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34094 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbZA2Lb6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:31:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org


Hello,

This patchset is kicked off by kernel bz#9913 which reports hot
plugging and general detection problems with WD My Book drives.  WD
was kind enough to provide me with these drives and I played quite a
bit with a few controllers and weird cabling configurations including
long cables and several genders.

It was surprisingly easy to trigger link layer problems.  eSATA ports
often go through extra cable and gender.  eSATA cables tend to be
longer than internal ones and as the cables are much stiffer touching
or moving the cable can easily cause enough wiggle at the connectors
to cause temporary transmission problems and being outside, it's much
more likely to be moved.

So, with abundant link quality problems, the following problems have
been identified.

a. Our link speed down logic on device probing failure is broken.  It
   somehow got masked off by a condition test which is there to
   prevent spurious warning messages.  This prevented repeated
   IDENTIFY failures from triggering link speed down.

b. When the condition is right (or wrong), devices succeed at
   negotiating 3.0Gbps but fails to actually establish link over it.
   This leads to frustrating repetition of hotplug events followed by
   failed reset attempts.  libata EH needs to remember failed probe
   trials and speed the link down to work around this problem.

c. Certain WD My Book's react badly to certain transmission errors.
   After a link error, it often completely shuts down the eSATA port
   and power down.  The only way to wake it up is to remove and
   re-apply power.  With the right cabling, this almost renders the
   device unusable as it completely shuts down when the host tries to
   transfer data.

This patchset contains patches to address the above three problems.

 0001-libata-fix-EH-device-failure-handling.patch
 0002-libata-move-ata_dev_disable-to-libata-eh.c.patch
 0003-libata-check-onlineness-before-using-SPD-in-sata_do.patch
 0004-libata-clear-dev-ering-in-smarter-way.patch
 0005-libata-add-spd_limit-to-sata_down_spd_limit.patch
 0006-libata-improve-probe-failure-handling.patch
 0007-libata-add-no-penalty-retry-request-for-EH-device-h.patch
 0008-libata-implement-HORKAGE_1_5_GBPS-and-apply-it-to-W.patch

0001 fixes #a.  0002-0006 implement workaround for #b and 0007-0008
for #c.  This patchset is on top of the current upstream-fixes[1].

Thanks.

 drivers/ata/libata-core.c |   93 +++++++++++++++++++++++++++++++++++-----------
 drivers/ata/libata-eh.c   |   87 +++++++++++++++++++++++++++++++++++++++----
 drivers/ata/libata-pmp.c  |    2 
 drivers/ata/libata.h      |    4 -
 include/linux/libata.h    |   19 +++++----
 5 files changed, 164 insertions(+), 41 deletions(-)

--
tejun

[1] 4a99d95fa836e254d17910e52663ba2be7b880e7
