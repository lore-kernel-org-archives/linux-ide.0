From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 4/9] sata_sil24 fixes, errata workaround and reset updates, take 3
Date: Tue, 11 Apr 2006 22:32:18 +0900
Message-ID: <11447623382439-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.232]:6794 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbWDKNcU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:32:20 -0400
Received: by wproxy.gmail.com with SMTP id i11so923318wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:32:20 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the third take of sata_sil24-fixes-errata-workaround-and-
reset-updates patchset.  Changes from the last take[L] are...

* In patch #6 (errata fix), WoC configuration is moved below clearing
  port reset as required by the spec.

* reset updates are adjusted to removal of @verbose

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/9457
[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506


