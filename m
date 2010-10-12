From: Jeremy Sanders <jeremy@jeremysanders.net>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Tue, 12 Oct 2010 16:30:43 +0100
Message-ID: <i91uv3$ooj$1@dough.gmane.org>
References: <i8vbcg$4hc$1@dough.gmane.org> <i8vq15$biu$1@dough.gmane.org> <4CB4665F.5030207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43453 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932516Ab0JLPa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Oct 2010 11:30:56 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1P5goW-0003DP-Bt
	for linux-ide@vger.kernel.org; Tue, 12 Oct 2010 17:30:52 +0200
Received: from xpc1.ast.cam.ac.uk ([131.111.68.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 12 Oct 2010 17:30:52 +0200
Received: from jeremy by xpc1.ast.cam.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 12 Oct 2010 17:30:52 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo wrote:

> Have you tried a different drive?

I tried several of the same type (ST3500641AS) but they all failed in the 
same way. I've just tried a Hitachi 1TB which makes linux hang during 
booting at "Probing EDD".

I've also tried flashing the bios on the card with the latest "base" bios 
from  the SI website.  In that case it hangs at Probing EDD with both types 
of drive. The standard PC bios can see the drives. If I remove any drives 
plugged in, booting works okay.

I suppose it could be a broken card or an incompatibility with the 
motherboard.

Thanks

Jeremy


