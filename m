From: Ryan Bourgeois <rgb005@latech.edu>
Subject: Samba + SX4 + RAID5 + Ext3 = Aborted Journal
Date: Sun, 22 Aug 2004 21:10:24 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41296E30.7050706@latech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from selene.LaTech.edu ([138.47.18.25]:59593 "EHLO LaTech.edu")
	by vger.kernel.org with ESMTP id S267381AbUHWEQb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2004 00:16:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by LaTech.edu (Postfix) with ESMTP id 918FA309998
	for <linux-ide@vger.kernel.org>; Sun, 22 Aug 2004 23:16:30 -0500 (CDT)
Received: from LaTech.edu ([127.0.0.1])
 by localhost (selene.latech.edu [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 62434-01-79 for <linux-ide@vger.kernel.org>;
 Sun, 22 Aug 2004 23:16:30 -0500 (CDT)
Received: from [192.168.1.134] (ip68-226-239-195.lf.br.cox.net [68.226.239.195])
	by LaTech.edu (Postfix) with ESMTP id CAE48309A10
	for <linux-ide@vger.kernel.org>; Sun, 22 Aug 2004 23:16:29 -0500 (CDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

As the subject states, I'm experiencing aborted journals on my RAID 
array after large writes or a large number of writes.  The strange thing 
is, it only seems to happen when doing these writes from another machine 
via Samba.  It doesn't happen via NFS.  And it only happens on the RAID 
array.  Here's my dmesg:

kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth2: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth1: Setting full-duplex based on MII#1 link partner capability of 45e1.
EXT3-fs error (device md0): ext3_new_block: Allocating block in system 
zone - block = 35454976
Aborting journal on device md0.
ext3_reserve_inode_write: aborting transaction: Journal has aborted in 
__ext3_journal_get_write_access<2>EXT3-fs error (device md0) in 
ext3_reserve_inode_write: Journal has aborted
ext3_getblk: aborting transaction: Journal has aborted in 
__ext3_journal_get_create_access<3>ext3_reserve_inode_write: aborting 
transaction: Journal has aborted in 
__ext3_journal_get_write_access<2>EXT3-fs error (device md0) in 
ext3_reserve_inode_write: Journal has aborted
ext3_abort called.
EXT3-fs abort (device md0): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device md0) in start_transaction: Journal has aborted
EXT3-fs error (device md0) in ext3_mkdir: Journal has aborted
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_frozen_data

I'm running the 2.6.8 kernel on both machines, but it's been happenning 
since I got the array set up, which was 2.6.3 I think, but I dunno...

I'm sure an alternative filesystem would work (I think) but that poses a 
data transfer problem of 120gbs...

-ryan
