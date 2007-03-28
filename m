From: Rodney Padgett <rodney.padgett@nuth.nhs.uk>
Subject: Re: SATA Problem: port is slow to respond
Date: Wed, 28 Mar 2007 10:15:04 +0000 (UTC)
Message-ID: <loom.20070328T121013-913@post.gmane.org>
References: <200702161050.51523.sigmund.lkml@synflood.homelinux.org> <45E4436B.9090102@gmail.com> <45E4A217.7090909@synflood.homelinux.org> <45E51B0A.5040605@gmail.com> <45E68B24.5030006@synflood.homelinux.org> <45E69196.4070409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43430 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934266AbXC1LZG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Mar 2007 07:25:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HWWH0-0006I2-Vu
	for linux-ide@vger.kernel.org; Wed, 28 Mar 2007 13:25:03 +0200
Received: from 194.176.105.37 ([194.176.105.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 13:25:02 +0200
Received: from rodney.padgett by 194.176.105.37 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 13:25:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:

> 
> Sigmund Scheinbar wrote:
> > Tejun Heo wrote:
> >> Please apply the attached patch over 2.6.20.1 and report how it works.
> > 
> > I'm afraid that something went wrong while patching:
> 
> Sorry, it was generated against the wrong tree.  Regenerated patch attached.
> 
> > BTW.: I'm just curious, what's the "purpose" of this patch, it looks to
> > me like it is just going to ignore the problem? Or do you think that the
> > hardware is faulty?
> 
> ATAPI devices use error conditions regularly to report all sorts of
> things including media not present.  In some variants of ahci's, this
> sets seemingly unrelated error bits - JMBs set interface error and
> sb600s seem to set internal error.  These errors when interpreted
> literally require device reset to recover from thus ATAPI devices never
> get through device ready check.  So, the patch makes ahci driver
> suppress those spurious errors.
> 
I had the same problem with kernel 2.6.20.3 (from kernel.org) on the same
machine (HP dc5750). I applied your patch, and the cd drive now works! dmesg
shows no errors logged, and I can access the drive without any problem.

Thanks,

Rod.

