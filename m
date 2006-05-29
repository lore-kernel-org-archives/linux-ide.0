From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 03/03] add hotplug support, take 4
Date: Mon, 29 May 2006 15:38:55 +0900
Message-ID: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.194]:42609 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751289AbWE2GjG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:06 -0400
Received: by nz-out-0102.google.com with SMTP id s18so477101nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:05 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the fourth take of add-hotplug-support patchset.  Changes from
the last take[L] are.

* ata_eh_scsi_hotplug() renamed to ata_scsi_hotplug() and moved to
  libata-scsi.c

* ata_port_detach() now automatically calls scsi_remove_host()

* debug stuff removed from convert-sil24 patch

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset
  + [2] prep-for-hotplug-support patchset
  + [3] prep-LLDDs-for-hotplug-support patchset

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10891
[L] http://article.gmane.org/gmane.linux.ide/10588
[1] http://article.gmane.org/gmane.linux.ide/10890
[2] http://article.gmane.org/gmane.linux.ide/10892
[3] http://article.gmane.org/gmane.linux.ide/10905


