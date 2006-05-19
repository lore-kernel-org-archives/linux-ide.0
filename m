From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 01/03] prep for hotplug support, take 3
Date: Fri, 19 May 2006 06:16:29 -0700 (PDT)
Message-ID: <11480445833568-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:49900 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751331AbWESNQ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 09:16:29 -0400
Received: by nz-out-0102.google.com with SMTP id 8so626374nzo
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 06:16:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the third take of prep-for-hotplug-support patchset.  Changes
from the last take[L] are

* sata_phy_debounce() now takes const array of three ulongs for timing
  parameters.  This makes it easy to define and export different
  predefined timing parameters and to pass timing parameter through
  other functions.  sata_phy_resume() is changed to take timing
  parameters and pass it to sata_phy_debounce() intead of crude
  boolean @quick.

* Three predefined parameters are provided - sata_deb_timing_boot,
  sata_deb_timing_eh and sata_deb_timing_before_fsrst.  These
  predefined parameters are used in the new hotplug framework and
  don't have to be long enough to cover all the cases.  The goal is to
  cover most cases in reasonable amount of time.  If timeout occurs,
  libata will give it more time and then retry.

* prereset() framework has been updated such that prereset() can tell
  EH what reset mechanism to use or to skip reset completely.  This
  way, HRST_TO_RESUME handling is confined into prereset() and device
  detection from prereset() is handled cleanly.

* ata_std_prereset() has been updated to handle different behaviors
  controllers show on hotplug.  Some controllers can wait for the
  first FIS34, some can only after COMRESET, others just can't.  These
  are controlled by two flags - ATA_FLAG_HRST_TO_RESUME and
  ATA_FLAG_CANT_WAIT_FIS34.  Note that those two flags describe PHY
  property.  They will move out to ata_link later.

  If necessary, ata_std_prereset() waits for spinup until hotplug
  event timestamp + spinup wait time (currently 8s).  This mechanism
  will allow later PMP support to avoid excessive amount of waiting.

This patchset is against

  upstream (8d4ee71ff6de5255ebfdf44fb83419d27bd06368)
  + enforce-default-EH-actions patch [1]
  + scsi_implement_eh-patch [2]

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10530
[L] http://article.gmane.org/gmane.linux.ide/10073
[1] http://article.gmane.org/gmane.linux.ide/10317
[2] http://article.gmane.org/gmane.linux.ide/10529

