From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA Problems: Back in the Land of the Unhappy Camper
Date: Sat, 02 Feb 2008 14:46:36 +0900
Message-ID: <47A403BC.4050100@gmail.com>
References: <479F9748.5010301@bobjweil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:42427 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbYBBFqn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 00:46:43 -0500
Received: by rv-out-0910.google.com with SMTP id k20so971901rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 21:46:42 -0800 (PST)
In-Reply-To: <479F9748.5010301@bobjweil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rgheck <rgheck@bobjweil.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

rgheck wrote:
> pata_amd 0000:00:0d.0: version 0.3.10
> PCI: Setting latency timer of device 0000:00:0d.0 to 64
> scsi6 : pata_amd
> scsi7 : pata_amd
> ata7: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
> ata8: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
> ata7.00: ATAPI: PLEXTOR CD-R   PX-W1610A, 1.05, max MWDMA2
> ata7.00: configured for MWDMA2

Hmm... libata definitely has some problem with mwdma support.  We still
don't know what.  Till now, I've seen similar mwdma failures in
pata_ali, pata_serverworks, pata_hpt3x2n and pata_amd.  Some or all of
them could be different issues but I think there's some common problem.

Can you read medias okay?

-- 
tejun
