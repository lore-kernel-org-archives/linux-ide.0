From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: current mainline ide doesn't like qemu/kvm (or vice versa)
Date: Fri, 8 Feb 2008 15:53:50 +0000
Message-ID: <20080208155350.733d2399@core>
References: <20080208152508.GA16290@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35795 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752730AbYBHQAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 11:00:12 -0500
In-Reply-To: <20080208152508.GA16290@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 8 Feb 2008 16:25:08 +0100
Christoph Hellwig <hch@lst.de> wrote:

> When trying to put some stress on qemu by running the xfs testsuite
> I get the following:
> 
> debian:~/xfs-cmds/xfstests# sh check 
> [  438.166822] SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
> [  438.185557] SGI XFS Quota Management subsystem
> [  438.193150] hdb: task_no_data_intr: status=0x41 { DriveReady Error }
> [  438.194018] hdb: task_no_data_intr: error=0x04 { DriveStatusError }
> [  438.194195] ide: failed opcode was: 0x9d

Drive aborted the command. Thats all correct.
> 
> and after that the kernel seems to hang.  Qemu is emulating a piix3
> device, and using the piix driver.  This is on a pretty old kvm (version
> 28) because newer ones don't even compile.

Old Qemu is not really a credible IDE emulation. The chances are that as
with all the libata bugs I close for qemu the problem is qemu. Please
file a bug with the qemu people.
