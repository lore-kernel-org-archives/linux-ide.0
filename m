From: Mac Lin <mkl0301@gmail.com>
Subject: Question regarding =?utf-8?b?UE9SVF9JUlFfQkFEX1BNUA==?= (Re: AHCI support Port Multiplier problem.)
Date: Tue, 15 Feb 2011 07:48:18 +0000 (UTC)
Message-ID: <loom.20110215T051458-468@post.gmane.org>
References: <20110107212537.GH7355@mtj.dyndns.org> <55871.3142.qm@web74203.mail.tp2.yahoo.com> <20110111143726.GE30607@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49371 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab1BOHsd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Feb 2011 02:48:33 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1PpFe9-0000N0-KY
	for linux-ide@vger.kernel.org; Tue, 15 Feb 2011 08:48:30 +0100
Received: from 211-21-178-166.HINET-IP.hinet.net ([211.21.178.166])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 08:48:29 +0100
Received: from mkl0301 by 211-21-178-166.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2011 08:48:29 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <tj <at> kernel.org> writes:

[snip]

> Please take a look at ahci_sb600_softreset() in ahci.c.  The
> controller had the same problem.  Preferably, please fix your
> controller but as there are more than one controller with this
> problem, we probably should implement it as a quirk in libahci.c.

I refer to the ahci_sb600_softreset and ahci_sb600_check_ready to make my patch,
but I found that the following code changes in ahci_sb600_check_ready:

        /*                                                    
         * There is no need to check TFDATA if BAD PMP is found due to HW bug, 
                                             
         * which can save timeout delay.
         */                                                   
        if (irq_status & PORT_IRQ_BAD_PMP)
                return -EIO;

On my system (CNS3xxx) it result in:

ata2: softreset failed (device not ready)
ata2: applying PMP SRST workaround and retrying
ata2: softreset failed (device not ready)
ata2: reset failed (errno=-5), retrying in 9 secs
ata2: softreset failed (device not ready)
ata2: applying PMP SRST workaround and retrying
ata2: softreset failed (device not ready)
ata2: reset failed (errno=-5), retrying in 9 secs
ata2: softreset failed (device not ready)
ata2: applying PMP SRST workaround and retrying
ata2: softreset failed (device not ready)
ata2: reset failed (errno=-5), retrying in 34 secs
ata2: limiting SATA link speed to 1.5 Gbps
ata2: softreset failed (device not ready)
ata2: applying PMP SRST workaround and retrying
ata2: softreset failed (device not ready)
ata2: reset failed, giving up

It seems that the PORT_IRQ_BAD_PMP is not getting cleared, or, asserted every
time when it "received a FIS from a device that did not have a command
outstanding", which is the D2H FIS of softreset.

The sb600, which I assume the code work correctly, seems doesn't have this
problem. So I am wondering that whether is this the right behavior on cns3xxx,
or  and just another issue of the chip?

Best Regards,
Mac Lin



