From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Mon, 18 Jun 2007 12:13:17 +0900
Message-ID: <4675F84D.3060207@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <4673BA28.2020106@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:54224 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbXFRDNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jun 2007 23:13:23 -0400
Received: by py-out-1112.google.com with SMTP id a29so2841775pyi
        for <linux-ide@vger.kernel.org>; Sun, 17 Jun 2007 20:13:22 -0700 (PDT)
In-Reply-To: <4673BA28.2020106@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Hello,

Florian Effenberger wrote:
> we tested out two 600W Fortron PSUs, also tried a BIOS update. Didn't
> work out.

I see.

> We also tried the jumper on the disks labelled SSP (Spread Spectrum
> Clocking), didn't work out out as well.
> 
> What seemed to help at least a little bit is to use the 12V connector on
> the board, that is normally dedicated for graphic cards.

Hmmmmm....

> The best test to reproduce the problem, according to a colleague also
> working on the machine, is a cat /dev/zero > zero.bin
> 
> Do you still think it is a PSU or hardware problem? Do you need more
> details/logs?

The controller being ich8, I'm pretty sure it isn't a driver problem.
Do the errors occur on all four drives?  Also, if things work after
speed is downgraded to 1.5Gbps, it doesn't really matter.  There's no
noticeable performance difference for single disk anyway.

-- 
tejun
