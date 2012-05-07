From: Daniel Pocock <daniel@pocock.com.au>
Subject: very slow write to AHCI device
Date: Mon, 07 May 2012 18:16:35 +0200
Message-ID: <4FA7F563.4040708@pocock.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.trendhosting.net ([195.8.117.5]:58652 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756724Ab2EGQXH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2012 12:23:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail1.trendhosting.net (Postfix) with ESMTP id B874415870
	for <linux-ide@vger.kernel.org>; Mon,  7 May 2012 17:16:50 +0100 (BST)
Received: from mail1.trendhosting.net ([127.0.0.1])
	by localhost (thp003.trendhosting.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m2iUET-iFaki for <linux-ide@vger.kernel.org>;
	Mon,  7 May 2012 17:16:36 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org



Hi,

I'm testing a problem with the following combination:
- SB700/SB800 type controller in AHCI mode (in a HP Microserver N36L)
- Seagate Barracuda 1TB 7k2 drive with NCQ

I've got a fresh 256MB partition, formatted ext4, mounted
barrier=1,data=ordered, write-cache enabled (hdparm -W 1 /dev/sdb) and
shared over NFS.

When the NFS client writes,
- unpacking a source tarball, many small files, iostat reports speeds
under 500kBytes/sec
- dd conv=fsync, iostat reports about 50MB/sec

If I set up a USB disk on the same box, with a partition formatted
exactly the same way, the iostat reports the write speed (unpacking the
same tarball) is over 5MBytes/sec - not so fast, but 10 times faster
than the AHCI device.

Is there anything I can do to troubleshoot this issue?

Or should I just stop using this onboard SATA and go to something like
an Adaptec 1405?

Regards,

Daniel


