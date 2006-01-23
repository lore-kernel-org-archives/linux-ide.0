From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: various fixes related to EH, take #2
Date: Mon, 23 Jan 2006 13:09:36 +0900
Message-ID: <11379893762140-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:65043 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751394AbWAWEJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 23:09:41 -0500
Received: by wproxy.gmail.com with SMTP id 57so810375wri
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 20:09:41 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: htejun@gmail.com

Hello, again.

Changes from the last posting.

* 1-3 are unchanged (my previous comment about missing ata_qc_free was
  false alarm)

* the detailed AC_ERR_* patch is fixed and splitted into two - AHCI
  qc->err_mask fix and detailed AC_ERR_* change.

* added CC to James and linux-scsi for SCSI change

* the not-yet-agreed-upon ignore-normal-qc-completion-during-EH patch
  is dropped.  I'll give it more thoughts and visit it again soon.

* eh-pio-sync patch is splitted into two as suggested and HSM resetting
  is moved into ->eng_timeout.

The following issues remain in this take.

* In detailed AC_ERR_* patch, I haven't added AC_ERR_ATA_BUS on timeout
  cases.  I still think leaving it as it is is better (heh, two
  consecutive is'es).  If you think AC_ERR_ATA_BUS must be set there,
  I'm okay with that too.  I'll do another take.

* patch #9 which fixes race between timeout and completion isn't exactly
  acked yet.

Thanks.

--
tejun

