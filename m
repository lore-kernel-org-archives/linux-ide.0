From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 25 Jun 2007 11:49:04 +0900
Message-ID: <467F2D20.1080700@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com> <46766208.1080305@effenberger.org> <467664F6.4060607@gmail.com> <467E5652.3060500@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:35062 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbXFYCtJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jun 2007 22:49:09 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1644360wah
        for <linux-ide@vger.kernel.org>; Sun, 24 Jun 2007 19:49:09 -0700 (PDT)
In-Reply-To: <467E5652.3060500@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
> sorry, it seems it was all a false alert and our mainboard was
> defective. At the end, it turned on only sometimes. To test it, we
> wanted to install Windows, which didn't work as well.
> 
> Now the dealer changed the motherboard, and we are just fine with 3.0
> Gbps and Kernel 2.6.21.5.
> 
> Sorry for the big confusion and for your great help! I didn't know the
> board was defective in the first place, there have been no indications
> like that...

Yeah, things like these are tricky.  SATA is usually the first one to
suffer from hardware defect including power fluctuation due to input
power, PSU or on-board voltage regulator problems because the link is
relatively long and runs at very high speed.  I also heard that SATA
cables should have been made more resistant to interference but I'm no
expert in that area.

It's interesting to see how it got solved.  Thanks for another data
point to blame hardware when I don't have a clue.  :-)

-- 
tejun
