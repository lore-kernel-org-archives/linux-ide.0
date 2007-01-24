From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [git patches] libata fixes
Date: Wed, 24 Jan 2007 15:54:33 -0600
Message-ID: <45B7D599.6040003@linux.vnet.ibm.com>
References: <20070124071920.GA32055@havoc.gtf.org>
Reply-To: brking@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34861 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932734AbXAXVz6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 16:55:58 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0OLtuJX015490
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 16:55:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0OLsZrV043360
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 16:54:35 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0OLsY3b025814
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2007 16:54:35 -0500
In-Reply-To: <20070124071920.GA32055@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> All fixes for ugly bugs and/or regressions.
> 
> Brian King (2):
>       libata: Fixup n_elem initialization
>       libata: Initialize qc->pad_len

Thanks for pulling this in. There is one patch outstanding preventing
ipr SATA from working:

http://marc.theaimsgroup.com/?l=linux-ide&m=116905877706906&w=2

Tejun proposed an alternate patch:

http://article.gmane.org/gmane.linux.ide/14792

Which you merged into #upstream for 2.6.21. Any chance one of these
patches could make its way in 2.6.20 so ipr SATA support works?

Thanks,

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
