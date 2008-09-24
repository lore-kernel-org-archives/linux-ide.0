From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11635] strange message in dmesg for IDE HDD: cannot use LBA48 DMA - PIO mode will be used for accessing sectors > 268435456
Date: Wed, 24 Sep 2008 03:18:07 -0700 (PDT)
Message-ID: <20080924101807.9B313108056@picon.linux-foundation.org>
References: <bug-11635-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34419 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752057AbYIXKS3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Sep 2008 06:18:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8OAI72x000474
	for <linux-ide@vger.kernel.org>; Wed, 24 Sep 2008 03:18:08 -0700
In-Reply-To: <bug-11635-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11635





------- Comment #1 from sshtylyov@ru.mvista.com  2008-09-24 03:18 -------
(In reply to comment #0)
> hdc: cannot use LBA48 DMA - PIO mode will be used for accessing sectors >
> 268435456

The IDE core honestly warns you that the controller doesn't support DMA for
accesses abobe 137 GB. Where's the problem?

> hdc: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63

> hdparm output:
> hdparm -Tt /dev/hdc output:
> /dev/hdc:
>  Timing cached reads:   388 MB in  2.01 seconds = 193.07 MB/sec
>  Timing buffered disk reads:  142 MB in  3.03 seconds =  46.89 MB/sec
> (I want to get something above 500MB/sec)

500 MB/s on disk reads?! That's totally wrong expectaion. What I am seeing
seems quite adequate speed for UltraDMA. And cached reads don't measure disk
transfer speed but rather your CPU bus/memory bandwidth.

> May it help (googled)
> i found that related info:
> https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/119730
> http://osdir.com/ml/ide/2005-03/msg00064.html

The latter reports DMA timeouts -- now that's an error indeed. But the report
is against 2.6.11. :-)

I suggest this to be resolved INVALID.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
