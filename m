From: Li Shaohua <shaohua.li@intel.com>
Subject: IDE suspend/resume issue
Date: Thu, 28 Apr 2005 13:52:35 +0800
Message-ID: <1114667555.22492.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:61122 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262145AbVD1FzO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 01:55:14 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3S5tEBn009935
	for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 05:55:14 GMT
Received: from orsmsxvs040.jf.intel.com (orsmsxvs040.jf.intel.com [192.168.65.206])
	by orsfmr101.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j3S5tD15025481
	for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2005 05:55:14 GMT
Received: from [172.16.219.62] ([172.16.219.62])
 by orsmsxvs040.jf.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005042722551200381
 for <linux-ide@vger.kernel.org>; Wed, 27 Apr 2005 22:55:12 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

IDE gurus,
We have observed many IDE failure cases after suspend-to-ram. The
failure is either resume IDE hang or IDE reports error after resume. In
my box, every time I hear the IDE motor's sound, the box resume is ok.
Otherwise, it hangs. From ACPI spec, the IDE driver should call many
ACPI methods like _GTM, _STM and execute task file gotten from _GTF
method. So we quite suspect the IDE suspend/resume has problem. I knows
little about IDE, so here are some questions for your guys.
1.how could I get the ATA driver ID block returned by Identify Drive
command (command code is 0xech)? is taskfile_lib_get_identify designed
for this (give it a struct hd_driveid parameter)?

2. The ACPI _GTF method return a series commands. The definition is:
command 1: Reg values for (1F1, 1F2, 1F3, 1F4, 1F5, 1F6, 1F7)
command 2: Reg values for (1F1, 1F2, 1F3, 1F4, 1F5, 1F6, 1F7)
.....
So how to call the command in generic_ide_resume? before or after
ide_do_drive_cmd (the last line of the routine)?

Thanks in advance! Please cc me, since I don't subscribe the mail list.

Thanks,
Shaohua

