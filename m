From: Florian Effenberger <florian@effenberger.org>
Subject: Re: libata interface fatal error
Date: Mon, 25 Jun 2007 10:47:13 +0200
Message-ID: <467F8111.3060604@effenberger.org>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org> <4675F84D.3060207@gmail.com> <46766208.1080305@effenberger.org> <467664F6.4060607@gmail.com> <467E5652.3060500@effenberger.org> <467F2D20.1080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from garfield.effenberger.org ([85.214.43.221]:57108 "EHLO
	garfield.effenberger.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbXFYIrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Jun 2007 04:47:20 -0400
In-Reply-To: <467F2D20.1080700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hi Tejun,

> Yeah, things like these are tricky.  SATA is usually the first one to
> suffer from hardware defect including power fluctuation due to input
> power, PSU or on-board voltage regulator problems because the link is
> relatively long and runs at very high speed.  I also heard that SATA
> cables should have been made more resistant to interference but I'm no
> expert in that area.

me neither. I first thought of a driver issue, because the machine just 
ran fine and started to have mysterious effects some weeks later...

> It's interesting to see how it got solved.  Thanks for another data
> point to blame hardware when I don't have a clue.  :-)

Hehe, you're welcome. ;-)

Thanks for all your efforts, I really appreciate them!

Florian

