From: Hasse Hagen Johansen <hhj@musikcheck.dk>
Subject: Problem detecting disks on the PATA part of PDC20378
Date: Tue, 07 Sep 2004 20:39:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <413E0064.7040105@musikcheck.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e81-19-243-105s.easyspeedy.com ([81.19.243.105]:31717 "EHLO
	hagen-johansen.dk") by vger.kernel.org with ESMTP id S268392AbUIGSjQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Sep 2004 14:39:16 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi

I would like to use dmraid to set up my existing Promise fake raid, but 
it seems that kernel 2.6.8.1 doesn't detect the individual discs on the 
PDC20378 controller, som I am again out of luck trying to upgrade to the 
2.6.x kernels.

Is there any plans or fixes to detect PATA discs on this controller, 
i've seen that people say that the SATA part works fine, but I am pretty 
stuck right now (I should never have used that fakeraid). I am writing 
here as I didn't get any info from the severel distribtution lists, and 
one LUG lists I am on.

Acutally I will just hear if there is any hope in using this controller 
at all

Best Regards
Hasse
