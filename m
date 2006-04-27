From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: AHCI suspend/resume patch can't work on Napa SDV
Date: Thu, 27 Apr 2006 17:13:42 +0800
Message-ID: <1146129222.5197.25.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48291 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965004AbWD0JYW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 05:24:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hare@suse.com
Cc: linux-ide@vger.kernel.org

Hi, Hannes

I applied your patch for AHCI suspend/resume to 2.6.16 and
had a test on our Napa SDV.

The test result is that this patch can't work on Napa SDV. In
particular, when the system tried to resume from S3 state,
the error message in dmesg is:

ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/100

Could you give me some hint why the timeout happened? How to
resolve this?

I tried "restart port" and "hardreset" in resume function,
but dev 0 still can't be waken up to life.

Thanks,
Forrest
