From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: various fixes related to EH, take #4
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.197]:26033 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751277AbWBJO67 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:58:59 -0500
Received: by wproxy.gmail.com with SMTP id i11so557890wra
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:58 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com


Hello, Jeff.

< %nn denotes patch nn from the last iteration, #nn in this iteration >

This is the fourth take of new reset mechanism.  4 (%01-%04) out of 11
patches made into upstream in the last iteration [1].  The rest are
acked but haven't been applied because standard reset operations need
more changes before being used.

This patchset is composed of 9 patches.

#01-02	: modify std reset operations such that they act almost
	  identically with ->phy_reset register-wise.
#03-09	: These seven patches are %05-%09 with minor changes.

After #01, the only meaningful difference of the new reset mechanism
from ->phy_reset is that SError is cleared after SATA hardreset.  This
difference is removed by #02.  #02 is separated to make the change
optional.  If #02 gets into upstream, I'll have to submit another
patch to resurrect it later for EH.  Jeff, it's your call.

After #01 and #02, the following differences remain.

1. SStatus access for sata_print_link_status() in ata_std_postreset()
   is at different postion register-wise compared to ->phy_reset.

2. ->phy_reset doesn't proceed with softreset if ata_busy_sleep()
   fails after PHY is waken, but new reset mechanism proceeds anyway.
   Note that the original code is not very consistent regarding this.
   Some drivers (e.g. ata_piix), uses ata_bus_reset() instead of
   sata_phy_reset() and thus doesn't perform ata_busy_sleep() before
   SRST in the first place.

If a low level driver uses ata_std_probeinit() but doesn't implement
softreset, it will end up performing extra phy_resume and
ata_busy_sleep before the actual hardreset sequence compared to
->phy_reset.  This is noted int the comment above ata_std_probeinit().

#08 has been modified not to use ata_std_probeinit() because it only
implements hardreset, but #09 implements softreset and adds
ata_std_probeinit() back; thus, the end result is unchanged.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/7804

