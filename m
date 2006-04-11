From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 5/9] new EH framework, take 2
Date: Tue, 11 Apr 2006 22:42:53 +0900
Message-ID: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:13463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750882AbWDKNmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:42:55 -0400
Received: by wproxy.gmail.com with SMTP id i11so925405wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:42:55 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of new-EH-framework patchset.  Changes from
the last take[L] are...

* adjusted to removal of @verbose from reset methods

* ata_exec_internal() synchronizes properly while freeing qc

* ata_exec_internal() whine and force ATA_ERR_OTHER if the internal qc
  has failed but neither the interrupt handler nor ->post_internal_cmd
  sets error code.

* SError and IRQ are cleared in ata_std_postreset() to clear error
  conditions and IRQs which can be raised during reset.

* ata_do_reset() now automatically freezes the port before proceeding
  with reset.  So, reset operations are guaranteed to be performed on
  frozen ports.

* ata_port_freeze() and thus ->freeze() method can be called multiple
  times without being thawed inbetween.  ->freeze() must not assume
  that the port is in thawed state.

* ata_scsi_error() retries ->error_handler() if the port is frozen on
  completion.  This is to handle cases where errors occur after
  ->error_handler() revived the port but before EH finishes.  This is
  done in such a way that EH doesn't miss freezing error condition
  under any condition.  Repeat is limited to 5 times.

* EH is inactive until the SCSI host is activated (SHOST_RUNNING).
  This prevents EH from running simultaneously with initial probing.

* various cosmetic changes (comments, new lines, messages...)

This patchset is against...

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset
  + [4] sata_sil24-fixes-errata-workaround-and-reset-updates patchset, take 3
  + [5] implement-scsi_eh_schedule patchset
  + [6] fix-scsi_kill_request-busy-count-handling patch

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/9311
[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506
[4] http://article.gmane.org/gmane.linux.ide/9516
[5] http://article.gmane.org/gmane.linux.ide/9290
[6] http://article.gmane.org/gmane.linux.ide/9487


