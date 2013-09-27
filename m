From: Wakko Warner <wakko@animx.eu.org>
Subject: ASM1061 freeze with DVDRW (3.11.1 amd64)
Date: Fri, 27 Sep 2013 19:13:46 -0400
Message-ID: <20130927231346.GA5662@animx.eu.org>
Reply-To: Wakko Warner <wakko@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tn-76-7-162-101.sta.embarqhsd.net ([76.7.162.101]:45818 "EHLO
	animx.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab3I0Xck (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Sep 2013 19:32:40 -0400
Received: from wakko by animx.eu.org with local
	(Exim 4.69 #3 (Debian Bug?  What bug /\oo/\))
	id 1VPhEI-0001Yz-Ql
	for linux-ide@vger.kernel.org; Fri, 27 Sep 2013 19:13:46 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I am not on this list, please keep me in CC.

I have a SuperMicro X10SAE with a 2 port ASM1061 controller.  When a DVDRW
is plugged into the port and is accessed (ie udev rules), there will be some
errors, an ata reset then the system hangs.  Keyboard is non-responsive
(lock key lights won't change).  SYSRQ doesn't work.

I tried both ports with the same result with 2 DVDRW drives (both same
model).

I was able to use a hard disk attached to either port w/o problems.

Kernel is vanilla 3.11.1 running on x86_64.

-- 
 Microsoft has beaten Volkswagen's world record.  Volkswagen only created 22
 million bugs.
