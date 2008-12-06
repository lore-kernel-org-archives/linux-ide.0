From: Yan Seiner <yan@seiner.com>
Subject: MCP55 disk activity LEDs don't flash
Date: Sat, 06 Dec 2008 06:08:39 -0800
Message-ID: <493A8767.5030200@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:47180 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbYLFOIk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 09:08:40 -0500
Received: from www.seiner.com ([192.168.128.6] ident=yan)
	by www.seiner.com with esmtp (Exim 4.69)
	(envelope-from <yan@seiner.com>)
	id 1L8xpn-0002GL-He
	for linux-ide@vger.kernel.org; Sat, 06 Dec 2008 06:08:39 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a 6 slot server case with a backplane.  AFAICT the backplane is 
passive and there are SATA cables that lead from the backplane to the mobo.

The problem is that the disk activity LEDs for the slots don't flash at 
all.  The mobo is an ASUS M2N SLI Deluxe, which has the MCP55 controller.

The drive activity LED which plugs into the mobo works just fine; the 
individual LEDs for each of the drives don't flash - they just stay on.  
Is there something I can enable to make them work?  Or is the backplane 
broken?

--Yan
