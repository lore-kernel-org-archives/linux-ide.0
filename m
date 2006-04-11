From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 3/9] misc ata_bus_probe() updates
Date: Tue, 11 Apr 2006 22:26:29 +0900
Message-ID: <11447619891579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.224]:8579 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750844AbWDKN0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:26:31 -0400
Received: by wproxy.gmail.com with SMTP id i11so922156wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:26:30 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, again.

This patchset contains three patches updating ata_bus_probe() and
related parts.  These patches don't make any functional changes.  Only
printk messages and code structure are changed.  This is in
preparation for new EH.

This patchset is against.

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499


