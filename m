From: Paul Ionescu <paul@acorp.ro>
Subject: sysfs method for registering/unregistering ide devices ?
Date: Sat, 13 Mar 2004 16:43:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1079189037.6624.11.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dnt.ro ([194.102.255.8]:62896 "EHLO mail.b.astral.ro")
	by vger.kernel.org with ESMTP id S263107AbUCMOvi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Mar 2004 09:51:38 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, lkml@vger.kernel.org

Hello,

Is there any possibility to unregister/scan ide devices with sysfs ?
I've searched lkml and linux-ide list archives and I didn't found any
answers.
Is there any sysfs file like /sys/..../registered, where you could echo
0 or 1 if you want to register or unregister a specific interface ?

Till now, I used hdparm -U/-R option for this task.
While this is still available in kernel 2.6, the implementation of
 HDIO_UNREGISTER_HWIF and  HDIO_SCAN_HWIF seems more like a hack than a
sane implementation.
Reasons:
Unregister and then register the same device, and you will have
different files for it int procfs and sysfs.
For unregistering or registering a device, you need at least a valid
block device. So I cannot unregister all my drives, and register them
again (or at least not at the same time).



