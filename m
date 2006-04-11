From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 8/9] prep for hotplug support
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.178]:39330 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750817AbWDKOGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:23 -0400
Received: by pproxy.gmail.com with SMTP id i49so1393204pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:22 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the first take of prep-for-hotplug-support patchset.  As the
name suggests, this patchset prepares libata for hotplug support.
This patchset contains 15 patches.

#01-02	update sata_sil (hotplug related constants, new interrupt handler)
#03-04	misc libata preps
#05-12	prepare ata_bus_probe()
#13-15	hotplug flags, extra fields, hotplug_wq

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset
  + [4] fixes-errata-workaround-and-reset-updates patchset, take 2
  + [5] implement-scsi_eh_schedule patchset
  + [6] fix-scsi_kill_request-busy-count-handling patch
  + [7] new-EH-framework patchset, take 2
  + [8] new-EH-implementation patchset, take 2
  + [9] add-NCQ-support, take 2

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506
[4] http://article.gmane.org/gmane.linux.ide/9516
[5] http://article.gmane.org/gmane.linux.ide/9290
[6] http://article.gmane.org/gmane.linux.ide/9487
[7] http://article.gmane.org/gmane.linux.ide/9524
[8] http://article.gmane.org/gmane.linux.ide/9540
[9] http://article.gmane.org/gmane.linux.ide/9555


