From: Andi Kleen <ak@suse.de>
Subject: -git9 breaks SATA on ATI-IXP
Date: Sun, 25 Jun 2006 22:49:43 +0200
Message-ID: <200606252249.43018.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:62635 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932324AbWFYUtt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Jun 2006 16:49:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>


Since I updated a ATI-IXP box with SATA HD from -git6 to -git9
the box doesn't find its root file system anymore.

I got

http://one.firstfloor.org/~andi/sata1.jpg
http://one.firstfloor.org/~andi/sata2.jpg

(no serial console on that box, 2 comes before 1) 

Looks like the new error handling is broken? 

Any workarounds?

-Andi 
