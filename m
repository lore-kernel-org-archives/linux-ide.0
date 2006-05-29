From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 01/03] prep for hotplug support, take 4
Date: Mon, 29 May 2006 15:25:57 +0900
Message-ID: <11488839571850-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:19384 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751239AbWE2G0E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:26:04 -0400
Received: by wr-out-0506.google.com with SMTP id i7so817676wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:26:03 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the fourth take of prep-for-hotplug-support patchset.  Changes
from the last take[L] are.

* ATA_FLAG_CANT_WAIT_FIS34 renamed to ATA_FLAG_SKIP_D2H_BSY

* make-ops->tf_read()-optional patch killed

* implement-ata_noop_check_status() patch killed

* better comments for ATA_DEVICE_CLEAR_OFFSET

* ata_hotplug_wq renamed to ata_scsi_wq

* wrap calls to sata_*() from ata_*() under 'if (ap->cbl == SATA)'
  condition

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10891
[L] http://article.gmane.org/gmane.linux.ide/10546
[1] http://article.gmane.org/gmane.linux.ide/10890


