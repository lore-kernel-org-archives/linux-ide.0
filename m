From: Tim Small <tim@seoss.co.uk>
Subject: WD Scorpio high SMART Load_Cycle_Count in default state and wdidle3.exe
 reverse engineering?
Date: Fri, 23 Oct 2009 11:00:29 +0100
Message-ID: <4AE17EBD.7050400@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:46402 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbZJWJ63 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 05:58:29 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay1.allsecurenet.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <tim@seoss.co.uk>)
	id 1N1Gun-0001wF-0L
	for linux-ide@vger.kernel.org; Fri, 23 Oct 2009 09:58:33 +0000
Received: from [91.208.163.30] (ermintrude [91.208.163.30])
	by zebedee.buttersideup.com (Postfix) with ESMTP id 099819B809
	for <linux-ide@vger.kernel.org>; Fri, 23 Oct 2009 10:58:31 +0100 (BST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Another one for the wiki (have already added it) - Western Digital 
Scorpio WD400UE-22HCT0 approx 100 unloads per hour under Linux 2.6 in 
the default shipped state.

wdidle3.exe workaround fixes.

Incidentally, if anyone fancies a go at reverse-engineering the binary, 
I can make available a FreeDOS HD image with the Watcom 
debugger/disassembler and the necessary DOS extender support setup.  
Unfortunately, I don't think I have the necessary low-level IDE nous to 
establish what it's doing to alter the timers in question....

Ta,

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.  
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

