From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 7/9] add NCQ support, take 2
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.235]:52388 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750976AbWDKNxk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:40 -0400
Received: by wproxy.gmail.com with SMTP id i11so927606wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:39 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, again.

This is the second take of add-NCQ-support patchset.  Changes from the
last take[L] are...

* ahci autopsy result is used to determine use_log_10h

* sata_sil24 NCQ support added

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset
  + [4] fixes-errata-workaround-and-reset-updates patchset, take 2
  + [5] implement-scsi_eh_schedule patchset
  + [6] fix scsi_kill_request() busy count handling patch
  + [7] new-EH-framework patchset, take 2
  + [8] new-EH-implementation patchset, take 2

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/9355
[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506
[4] http://article.gmane.org/gmane.linux.ide/9516
[5] http://article.gmane.org/gmane.linux.ide/9290
[6] http://article.gmane.org/gmane.linux.ide/9487
[7] http://article.gmane.org/gmane.linux.ide/9524
[8] http://article.gmane.org/gmane.linux.ide/9540


