From: Jeremy Sanders <jeremy@jeremysanders.net>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Wed, 13 Oct 2010 10:14:37 +0100
Message-ID: <i93t9u$c60$1@dough.gmane.org>
References: <i8vbcg$4hc$1@dough.gmane.org> <i8vq15$biu$1@dough.gmane.org> <4CB4665F.5030207@kernel.org> <i91uv3$ooj$1@dough.gmane.org> <4CB481E0.4040705@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36085 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357Ab0JMJOu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Oct 2010 05:14:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1P5xQ7-0002AQ-OC
	for linux-ide@vger.kernel.org; Wed, 13 Oct 2010 11:14:47 +0200
Received: from xpc1.ast.cam.ac.uk ([131.111.68.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 13 Oct 2010 11:14:47 +0200
Received: from jeremy by xpc1.ast.cam.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 13 Oct 2010 11:14:47 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tim Small wrote:

> Bad PCI express to PCI-X bridge chip maybe, or maybe the Linux bug lies
> there?  I have seen cards with 2 3132s on instead (and a PCI express
> bridge), perhaps it'd be worth trying one of those?

It looks like the problem was an incompatibility with the Intel motherboard.

It seems to work fine in an old foxconn Athlon 64 motherboard (in the PCIex 
graphics slot when using a PCI card for video).

Jeremy



