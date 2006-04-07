From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_sil24: fixes, errata workaround and reset updates, take 2
Date: Fri, 7 Apr 2006 17:16:53 +0900
Message-ID: <114439781363-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:30944 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932369AbWDGIQ5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:16:57 -0400
Received: by xproxy.gmail.com with SMTP id t10so260172wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:16:57 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com, htejun@gmail.com

Hello, Jeff and Carlos.

This is the second take of sata_sil24-fixes-errata-workaround-and-
reset-updates patchset.  Changes from the last take[1] are...

* sil24_poll_register() is replaced by ata_wait_register()
* comment update as suggested by Jeff
* better constants
* byteorder fix and 64bit patches are pushed backward, as they're
  untested.
* hardreset routine updated to unconditionally wait 100ms after reset
* new patch #11 removes hardresetting in sil24_init_one() as it's
  already done during host reset and even if the port is in a funky
  state, we have hardreset to back us up.

This patchset contains 13 patches.

#01	prep
#02-06	fixes, updates, errata workaround
#07-09	update softreset
#10-11	update hardreset
#12-13	untested fixes

This patchset is against

  upstream[2]
  + libata-reset-updates patchset (3 patches) [3]
  + implement-and-use-ata_wait_register patchset [4]

After these updates, sil24 is ready for new EN and NCQ.  In my repo,
sil24 is working fine with both new EH and NCQ.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9406
[2] c2a6585296009379e0f4eff39cdcb108b457ebf2
[3] http://article.gmane.org/gmane.linux.ide/9414
[4] http://article.gmane.org/gmane.linux.ide/9450


