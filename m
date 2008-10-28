From: Tejun Heo <tj@kernel.org>
Subject: Re: Accessing 3.4 TB RAID Drive
Date: Tue, 28 Oct 2008 11:01:39 +0900
Message-ID: <49067283.7040306@kernel.org>
References: <4901CDDB.8000409@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51976 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbYJ1CBp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 22:01:45 -0400
In-Reply-To: <4901CDDB.8000409@mindspring.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: PairOfTwins <PairOfTwins@mindspring.com>
Cc: linux-ide@vger.kernel.org

PairOfTwins wrote:
> Folks (I was referred here by my local Linux group):
> 
> I'm replacing RHEL 3.2 with something newer, and need to access an
> external eSATA RAID array (Venus T5, Sil4726 chipset) about 3.4 TB.
> 
> Using a RIP (Recovery Is Possible) Live CD, I was able to read the GPT
> partition table and attempt to mount the device (though it was flagged
> dirty), on one test system.
> However, after installing Ubuntu Server 8.04 and 8.10 beta on a
> production box, I'm getting lots of errors.  One big difference, though,
> is the RIP test was using PCI eSATA card (Silicon Image Sil3124), and
> the production box has PCI-E eSATA card (Sil3132).
> 
> With Ubuntu Server 8.04 fully updated, kernel 2.6.24-21-server, driver
> sata_sil24, syslog says:
...
> Any hints appreciated, like what software needs updating, or shall I
> replace PCI-E card with PCI ?

That's because sata_sil24 supports PMP and 4726 is a (weird) PMP device.
 If you use PMP reset protocol, it reveals more about itself and when
the device is configured in hardware raid mode, it presents pseudo
devices on PMP links which doesn't behave in accordance with the ATA
spec and doesn't like libata's init sequence.  Just put 4726 into JBOD
mode and sil24 will happily see all the individual disks.

Thanks.

-- 
tejun
