From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] libata: [PATCHSET] libata: new reset mechanism, take#3
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.201]:42947 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423401AbWBBJUG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:06 -0500
Received: by wproxy.gmail.com with SMTP id i27so431364wra
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:05 -0800 (PST)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: htejun@gmail.com

Hello, all.

This is the third take of new reset mechanism.  5 of 12 patches made
into upstream in the last iteration [1].  Patches from #06 are dropped
due to incorrect probe_reset implementation.

This patchset is against...

  upstream (e4e7b89280d1d666e2c09e5ad36cf071796c4c7e)
  + [PATCHSET] libata: various fixes related to EH, take #3 [2]
  + [PATCH] ahci: separate out ahci_fill_cmd_slot() [3]

Changes from the last itertion are...

* #01 fixes SATA detection bug in ata_std_probe_reset()

* #02-#04 implements probeinit component operation to properly wake
  sata phy before softreset

* #05-#11 are #06-#12 from the last iteration adapted to above changes

Jeff, after patches upto #04 are applied, the following differences
remain between the new reset mechanism and the original one.

1. For softreset

In the original code, ata_busy_sleep() is done after waking up the PHY
whether SATA_RESET is used or not.  For SRST case, it looks like the
following.

	Original			New
-----------------------------------------------------------------
a1. Wake up PHY using SControl	b1. Wake up PHY using SControl

a2. ata_busy_sleep(),
    if sata_dev_present()

a3. dev_select(ap, 0)		b2. dev_select(ap, 0)

a4. do softreset		b3. do softreset

a5. ata_busy_sleep() for	b4. ata_busy_sleep() for
    present devices in		    present devices in
    ata_bus_post_reset()	    ata_bus_post_reset()


I thought the ata_busy_sleep() in #a2 was for SATA_RESET case and left
it out.  Do you think it's necessary for SRST too?


2. For hardreset

Unlike in the original code, the new reset mechanism first wake up the
PHY before invoking sata_std_hardreset() even when
sata_std_hardreset() is the only reset method.  And dev_select(ap, 0)
is not performed for hardreset.

So, the diffrence looks like the following.

	Original			New
-----------------------------------------------------------------
				b1. Wake up PHY using SControl

a1. Reset PHY using SControl	b2. Reset PHY using SControl

a2. Wake up PHY using SControl	b3. Wakeup PHY using SControl

a3. ata_busy_sleep(),		b4. ata_busy_sleep(),
    if sata_dev_present()	    if sata_dev_present()

a4. dev_select(ap, 0)


#b1 is there as probeinit operation and as most controllers implement
softreset, there will be softreset operations between #b1 and #b2 in
most cases.  The dev_select(ap, 0) in #a4 is actually for SRST and
EDD.  For SATA_RESET, double dev_select()'s are soon done later in
ata_bus_reset() with only ata_irq_on() inbetween.


3. During postreset

The original code does ata_irq_on() if ctl_addr is non-NULL, double
select and ctl setup.  The new code does double select and
ata_irq_on() if ctl_addr is non-NULL.

	Original			New
-----------------------------------------------------------------
a1. ata_irq_on() if ctl_addr

a2. double select		b1. double select

a3. ctl setup
				b2. ata_irq_on() if ctl_addr


ata_irq_on() actually implies ctl setup.  Also, in the original code,
'if ctl_addr' test in #a1 is bogus because in #a3, ctl_addr is used
unchecked.  New code just does ata_irq_on() at the end.


IMHO, the remaining differences seem harmless and mainly due to the
fact that new code splits soft and hard resets explicitly whereas the
original code shared a lot of code path.  If any of above changes
seems suspicious, please let me know.

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=113809002924734&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=113880953326268&w=2
[3] http://marc.theaimsgroup.com/?l=linux-ide&m=113881369505598&w=2


