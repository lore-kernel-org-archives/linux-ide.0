From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: implement and use ata_wait_register()
Date: Fri, 7 Apr 2006 17:02:47 +0900
Message-ID: <11443969673485-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:26323 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932333AbWDGICx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Apr 2006 04:02:53 -0400
Received: by wproxy.gmail.com with SMTP id i11so293165wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Apr 2006 01:02:52 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, Jeff.

This patchset implements ata_wait_register() and uses it in ahci and
sata_sil24.  The function is generalized form of ahci_poll_register()
with the following differences.

* Uses ioread32.
* The first read is done before calculating timeout such that
  unflushed io write doesn't affect timeout.  (no flush required
  before calling this function.)
* Test conditions is negated.  As it waits for something to change,
  negated test is more natural/powerful and allows this function to be
  used for wider purpos.
* Returns the last read value of @reg.

This patchset contains five patches.

#01-02	fix & prep sata_sil24 for following changes
#03-05	implement and use ata_wait_register()

This patchset is against.

     upstream [1]
     + libata reset updates patchset (3 patches) [2]

Thanks.

--
tejun

[1] c2a6585296009379e0f4eff39cdcb108b457ebf2
[2] http://article.gmane.org/gmane.linux.ide/9414


