From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: ata_piix resume from S3 on T43P failed
Date: Thu, 11 May 2006 16:05:40 +0800
Message-ID: <1147334740.7273.38.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48685 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030182AbWEKIQm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 04:16:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi, Tejun

We just tested your git tree on thinkpad T43P laptop, and found that
after ata_piix resumed from S3, SATA disk can't be read/write anymore.
But according to the test result of kernel 2.6.16-rc6 on T43P, ata_piix
can resume from S3 successfully.

We know that this problem may be not related to your patches, but I
think you know the libata development status very well, maybe you can
give us some clue about what happened to ata_piix between 2.6.16-rc6 and
your git tree.

Thanks,
Forrest
