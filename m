From: Pat LaVarre <p.lavarre@ieee.org>
Subject: to /sys from /proc/ide/hd$v/identify
Date: 07 Jun 2004 07:48:42 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086616121.3649.0.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:61098 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264452AbUFGNs4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 09:48:56 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id D8B171AB2
	for <linux-ide@vger.kernel.org>; Mon,  7 Jun 2004 07:48:52 -0600 (MDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> List:       linux-kernel
> Subject:    [RFC][DOC] writing IDE driver guidelines
> From:       Bartlomiej Zolnierkiewicz <B.Z...()elk...>
> Date:       2004-05-15 17:23:50
> 
> Feedback is welcomed.
> ...
> general rules:
> ...
> - use linux-ide@vger.kernel.org mailing list
> ...
> PCI drivers:
> ...
> - /proc/ide/ interfaces are obsolete

Where do I now find the ATA op xEC/A1 "IDENTIFY" data that was
/proc/ide/hd$v/identify ?

$ uname -r
2.6.7-rc2
$
$ sudo cat /proc/ide/hda/identify | wc -w
    256
$ sudo cat /proc/ide/hdc/identify | wc -w
    256
$
$ sudo mount -t sysfs sysfs /sys
$ sudo find /sys -name '*id*' | less
$ find /sys/bus/ide | less
$

Pat LaVarre


