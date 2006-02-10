From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: various fixes related to EH, take #4
Date: Fri, 10 Feb 2006 15:10:48 +0900
Message-ID: <11395518482722-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:34798 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751155AbWBJGKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 01:10:52 -0500
Received: by zproxy.gmail.com with SMTP id 13so360258nzn
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 22:10:51 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

This patchset is the fourth take of 'various fixes related to EH'
patchset.  From the previous take[1], %01 and %02 made into the tree
and %03 got nacked and #04 acked but didn't make into the tree due to
dependency to %03.  (% denotes patch numbers in the previous take, #
in this take)

Changes from the last take.

* %03 reimplemented using sht->eh_timed_out() callback as Jeff
  suggested[2].

* assert(ata_qc_from_tag(ap, ap->active_tag)) is added to
  ata_scsi_error() in patch %04.

This patchset contains the following patches.

#01-03	: implement and use ata_scsi_timed_out()
#04	: kill NULL qc handling and add above described assertion

I used ATA_QCFLAG_EH_SCHEDULED instead of ATA_QCFLAG_TIMEOUT because
the same flag will be used later by EH patchset in the same manner.

Simulated the following three cases and all work fine.

* normal time out
* timeout wins, but qc completion kicks in before EH
* timeout loses (ata_scsi_timed_out() returns EH_HANDLED)

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7788
[2] http://article.gmane.org/gmane.linux.ide/7890

