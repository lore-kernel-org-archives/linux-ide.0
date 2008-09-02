From: Jeff Garzik <jeff@garzik.org>
Subject: Re: NCQ usage/support in linux
Date: Tue, 02 Sep 2008 07:20:58 -0400
Message-ID: <48BD219A.2040401@garzik.org>
References: <WorldClient-F200809021029.AA29540056@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53362 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbYIBLVD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Sep 2008 07:21:03 -0400
In-Reply-To: <WorldClient-F200809021029.AA29540056@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: linux-ide@vger.kernel.org

xerces8 wrote:
> Hello!
> 
> I have a few questions about SATA NCQ.
> 
> Background story:
> Many users noticed that concurrent (by two programs) read access to a disk
> under Windows goes very slow with modern systems, using SATA AHCI mode.
> 
> References:
>  - "Slower concurrent disk access with NCQ ?"
> <http://forums.hexus.net/hexus-hardware/138640-slower-concurrent-disk-access-ncq.html>
>  - "Slower with NCQ ?, Concurent access" <http://forums.storagereview.net/index.php?showtopic=26864>
>  - "NCQ: Best Upgrade For a Power User!" <http://forums.storagereview.net/index.php?showtopic=26965>
> 
> (for short summary you can read the 3rd page of the last forum topic linked above)
> 
> Here is the gist of the issue:
> --quote from a forum post--
> 320GB WD Caviar:
> 
> Windows:
> 63 MB/s: 1 instance
> 28 MB/s: 2 instances (both at 0% position)
> 9 MB/s: 2 instances (0% position and 90% position)
> 15 MB/s: 10 instances (10% gap between each)
> 
> Linux:
> 63 MB/s: 1 instance
> 63 MB/s: 2 instances (both at 0% position)
> 45 MB/s: 2 instances (0% position and 90% position)
> 48 MB/s: 10 instances (10% gap between each)
> 
> Linux, stock install of Fedora 9 x64 (2.4.25 kernel).
> 
> Linux commands issued:
> dd if=/dev/sdb of=/dev/null bs=256K skip=200K (skip was incremented by 200K each instance which
> corresponds to about 50GB forward in this 320GB drive)
> 
> all dd invocations started at the same time (batch).
> 
> throughput measured with:
> iostat -m 1 /dev/sdb (m shows in megabytes, 1 is the update interval of graph every second)
> 
> Windows commands:
> dd if=\\.\PHYSICALDRIVE1 of=NUL bs=256K skip=200K (as above)
> --end quote--
> 
> My question is: How does linux deal with NCQ ?
> Is it used by default ?

We turn on NCQ if its available on both disk and controller.  In 
general, we program your hardware to go as fast as possible while still 
reliably accessing data.

	Jeff



