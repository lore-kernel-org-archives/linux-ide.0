From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: prep for new EH, take 2
Date: Sun, 2 Apr 2006 18:51:52 +0900
Message-ID: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:11846 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932305AbWDBJwB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:01 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447006nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:51:57 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff, Alan and Albert.

This is the second take of prep-for-new-EH patchset.  Last take[1]
contained 14 patches and, except for %04, all patches got ACKed.
Changes from the last take are...

* %04 is splitted into two patches #04 clean-up-constants and #05
  rename-ATA_FLAG_PORT_DISABLED.  And definition of ATA_DFLAG_CFG_MASK
  is moved into #06 where it's used.

* #15 make-routines-extern patch does not make ata_set_sata_spd()
   extern anymore.  As SATA SPD configuration is moved into hardreset
   EH doesn't need to access the function directly.

This patchset is against
  #upstream [2]
  + improve-ata_bus_probe-failure-handling patchset, take 2 [3]

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9203
[2] 852ee16a914fb3ada2f81e222677c04defc2f15f
[3] http://article.gmane.org/gmane.linux.ide/9252


