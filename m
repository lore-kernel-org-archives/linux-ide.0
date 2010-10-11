From: Jeremy Sanders <jeremy@jeremysanders.net>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Mon, 11 Oct 2010 20:54:13 +0100
Message-ID: <i8vq15$biu$1@dough.gmane.org>
References: <i8vbcg$4hc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47749 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315Ab0JKTyY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Oct 2010 15:54:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1P5ORz-0004Ml-5a
	for linux-ide@vger.kernel.org; Mon, 11 Oct 2010 21:54:23 +0200
Received: from xpc1.ast.cam.ac.uk ([131.111.68.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2010 21:54:23 +0200
Received: from jeremy by xpc1.ast.cam.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 11 Oct 2010 21:54:23 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeremy Sanders wrote:

> Hi - I'm having problems getting a Sil 3124 card with a PCI-Express 1x
> interface to work, see https://bugzilla.redhat.com/show_bug.cgi?id=641878
> Here is the card:
>  http://www.era-adapter.com/pciexpress-1x-to-4-ports-sata-ii-adapter-
p-60.html

I've now tried building the latest git module which doesn't work. I've tired 
commenting out the pcie_set_readrq(pdev, 4096) line - no luck. I've tried 
enabling MSI interrupts - it gets an MSI interrupt but fails in the same 
way. I've also tried disabling hard and soft resets - though it fails later 
in the initialization.

Jeremy




