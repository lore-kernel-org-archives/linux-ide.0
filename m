From: Felix Miata <mrmazda@earthlink.net>
Subject: ATA errors corrupt other I/O & set / readonly
Date: Wed, 02 May 2012 04:59:26 -0400
Message-ID: <4FA0F76E.3050509@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fall-lakeland.atl.sa.earthlink.net ([207.69.195.103]:41727 "EHLO
	fall-lakeland.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab2EBJKn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 05:10:43 -0400
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63])
	by fall-lakeland.atl.sa.earthlink.net with esmtp (Exim 4.34)
	id 1SPVa6-00014U-Pi
	for linux-ide@vger.kernel.org; Wed, 02 May 2012 05:10:42 -0400
Received: from user-12hck1e.cable.mindspring.com ([69.22.80.46] helo=[192.168.0.51])
	by pop-satin.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1SPVPE-0004N7-00
	for linux-ide@vger.kernel.org; Wed, 02 May 2012 04:59:28 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Two weeks ago on recommendation of downstream bug owner I filed 
https://bugzilla.kernel.org/show_bug.cgi?id=43128 expecting to see some kind 
of non-delayed reaction from someone either in the bug or here, and am quite 
disappointed that nothing has yet happened. Is the bug's owner sick, on 
holiday, or at a convention?

I originally resisted filing because I believe that actual problem is the 
device's and not kernel or drivers. Yet, that it is possible for any such 
device failure to cause system corruption doesn't seem right either. So, can 
someone please comment on the likelihood that this bug can or will be fixed? 
I would like someone to respond here or in the bug before proceeding to try 
again to convince the manufacturer its product is defective and get a refund 
instead of yet another replacement of a defective product with another 
defective product.

Once I return it for refund I will no longer be able to follow up on the bugs 
I filed, yet I need a working device that doesn't require I figure out a 
correct cmdline workaround for every one of the several systems it ever needs 
to be connected to.

Please, what should I do?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
