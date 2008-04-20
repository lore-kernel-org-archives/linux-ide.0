From: walt <w41ter@gmail.com>
Subject: Re: Commit 305d2a1ab137d1... breaks sata_nv, and PMP woes
Date: Sun, 20 Apr 2008 08:41:40 -0700
Message-ID: <fufo6t$mpo$1@ger.gmane.org>
References: <480AC715.2060303@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:44758 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbYDTPll (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Apr 2008 11:41:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jnbfb-0006hq-Nl
	for linux-ide@vger.kernel.org; Sun, 20 Apr 2008 15:41:35 +0000
Received: from adsl-69-234-176-108.dsl.irvnca.pacbell.net ([69.234.176.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 20 Apr 2008 15:41:35 +0000
Received: from w41ter by adsl-69-234-176-108.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 20 Apr 2008 15:41:35 +0000
In-Reply-To: <480AC715.2060303@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Petr Vandrovec wrote:
> Hello Tejun,
> since commit 305d2a (unify mechanism to request follow-up SRST) no
> devices behind my sata_nv are recognized anymore. Driver reports
> correctly link speed 1.5GBps (for CDROM) and 3GBps (for harddisk), but
> devices themselves are not found, and so boot fails. Reverting this
> commit fixes problem...

Based on Marc Dionne's post from yesterday I reverted just the ata_do_reset()
part of Tejun's commit and my nforce-mcp61 machine boots again.

