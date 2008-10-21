From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET #upstream] libata: separate out SFF and BMDMA
Date: Tue, 21 Oct 2008 18:26:08 +0900
Message-ID: <48FDA030.1010400@kernel.org>
References: <1224580680-13698-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43463 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYJUJ2N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 05:28:13 -0400
In-Reply-To: <1224580680-13698-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org

Hello, a few more things.

The tree is available in the following git tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git separate-sff-bmdma
 http://www.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git;h=separate-sff-bmdma

I've tested the changes on the following drivers.

 ahci, ata_generic, ata_piix, pata_hpt3x2n, pata_jmicron, pdc_adma,
 sata_inic162x, sata_promise, sata_sil, sata_via.

Thanks.

-- 
tejun
