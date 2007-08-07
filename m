From: MikeW <mw_phil@yahoo.co.uk>
Subject: libata-core.c: =?utf-8?b?YXRhX2ZpbGxfc2coKQ==?= ... sanity check on arithmentic ?
Date: Tue, 7 Aug 2007 15:35:38 +0000 (UTC)
Message-ID: <loom.20070807T172323-813@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:50039 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756626AbXHGPpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 11:45:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IIRF0-0002hs-77
	for linux-ide@vger.kernel.org; Tue, 07 Aug 2007 17:45:02 +0200
Received: from 57.66.65.38 ([57.66.65.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 17:45:02 +0200
Received: from mw_phil by 57.66.65.38 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Aug 2007 17:45:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Could someone more knowledgeable than me please reassure me ...

Referring to code in linux-2.6.22.1: libata-core.c (kernel.org),
in ata_fill_sg():

if sg_dma_address(sg) is 64k-aligned and sg_dma_len(sg) is 64k (0x10000),
then in the while loop, the "if ((offset..." test is false, since
it tests for *greater than* 64k

So then ap->prd[idx].flags_len gets set to (0x10000 & 0xFFFF) = 0 !

So this sg element ends up with a zero length, even though the
transfer size should be 64k.

Is this correct behaviour, if not, should it be corrected ?
Sorry if I'm just being paranoid !

Thanks,
MikeW

