From: Ravi Pratap M <ravi@ximian.com>
Subject: libata AHCI support for Intel ICH6RW
Date: Fri, 03 Sep 2004 00:09:56 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094184596.16175.3.camel@unicorn.rpratap.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from itse122.itsnpt.com ([64.209.119.122]:47799 "EHLO
	unicorn.rpratap.homelinux.org") by vger.kernel.org with ESMTP
	id S269013AbUICEMW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Sep 2004 00:12:22 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by unicorn.rpratap.homelinux.org (8.12.11/8.12.11) with ESMTP id i8349uUB016213
	for <linux-ide@vger.kernel.org>; Fri, 3 Sep 2004 00:09:58 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi guys,

My Dell Dimension 8400 machine has the latest Intel ICH6RW controller
and I am running kernel 2.6.8.1. I was under the impression that
libata's ata_piix driver now supports AHCI mode but when I set the BIOS
to that setting, the kernel doesn't see anything.


Has the AHCI driver not fully been integrated into mainline libata ? I
downloaded the latest prepatch kernel but I still don't see any AHCI
driver (I found an ahci.c that you posted to linux-kernel sometime in
April 2004 but that is missing from the main linux kernel source tree
that I have downloaded here).


I would like to help with testing / further development of this driver
but I was unsure of what was going on. 


I made sure that my kernel (Fedora Core 2) had the drivers compiled in
(as modules, IIRC) - is there something I am doing wrong ?


Ravi.


-- 
Ravi Pratap M <ravi at ximian dot com>
Selective perfectionist, incorrigible programmer
http://primates.ximian.com/~ravi


