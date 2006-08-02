From: Brad Campbell <brad@wasp.net.au>
Subject: Alan's PATA stuff and libata warmplug
Date: Wed, 02 Aug 2006 08:15:32 +0400
Message-ID: <44D026E4.1030904@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:41120 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751129AbWHBEPg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Aug 2006 00:15:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

G'day all,

Just wondering at the long term feasibility of adding warmplug to the PATA portions of libata that 
are currently sitting in -mm.

My vaio here has the ability to power down the optical drive. The hard disk and optical drive are on 
the same ATA bus, master/slave.
When the optical drive goes into error recovery mode, like if it has a scratch on the CD, or I power 
the drive down, any access to the hard disk locks up until either the error is timed out or the 
state recovers. So when I power down my optical disk the machine dies as it seems to lock access to 
the hard disk also.

I was wondering if the ability to effectively bring down that particular aspect of the interface 
might prevent this from occurring so I can use the machine with the optical drive powered off and 
then bring the interface back up if I re-apply power to the drive.

I've been trying to recover some badly scratched audio cd's lately, and of course that makes the 
machine unusable as the hard disk just becomes inaccessible while the kernel times out the access to 
the CD drive. I don't recall this happening with the original ide drivers.


Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
