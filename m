From: Christoph Hellwig <hch@lst.de>
Subject: current mainline ide doesn't like qemu/kvm (or vice versa)
Date: Fri, 8 Feb 2008 16:25:08 +0100
Message-ID: <20080208152508.GA16290@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:49375 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbYBHPZP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Feb 2008 10:25:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

When trying to put some stress on qemu by running the xfs testsuite
I get the following:

debian:~/xfs-cmds/xfstests# sh check 
[  438.166822] SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
[  438.185557] SGI XFS Quota Management subsystem
[  438.193150] hdb: task_no_data_intr: status=0x41 { DriveReady Error }
[  438.194018] hdb: task_no_data_intr: error=0x04 { DriveStatusError }
[  438.194195] ide: failed opcode was: 0x9d

and after that the kernel seems to hang.  Qemu is emulating a piix3
device, and using the piix driver.  This is on a pretty old kvm (version
28) because newer ones don't even compile.
