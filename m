From: Bob Stewart <bob@evoria.net>
Subject: Disk corruption somewhere between 2.6.20.3 and 2.6.20.6?
Date: Mon, 30 Apr 2007 15:21:49 -0700 (PDT)
Message-ID: <898154.58386.qm@web903.biz.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web903.biz.mail.mud.yahoo.com ([216.252.100.43]:44658 "HELO
	web903.biz.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1946866AbXD3W2b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Apr 2007 18:28:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After upgrading my kernel to 2.6.20.6 recently, I 
started having random drive errors on both ext3 and xfs
filesystems.  On boot, my two data drives (one ide and one sata)
would come up with fsck errors.  Somehow the root drive was
spared.  One of the first symptoms of the problem was 
"illegal filename" when trying to remove files copied by "cp -axu"
as part of a backup operation.  I fell back to 2.6.20.3, and these 
problems seem to have gone away.  The motherboard is an Asus 
A7NX8 using sata_sil and amd74xx drivers.  Is this
a known problem?  I'm kinda reluctant to try later kernels
on this machine now.

Bob
