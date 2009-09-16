From: Tejun Heo <tj@kernel.org>
Subject: Commit 54c38444fad6a99b4b19512f8f0055d69115e69e
Date: Wed, 16 Sep 2009 20:56:08 +0900
Message-ID: <4AB0D258.60503@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36174 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004AbZIPL4m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Sep 2009 07:56:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff,

Commit 54c38444fad6a99b4b19512f8f0055d69115e69e triggers
WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN); in ata_qc_complete().
>From the commit history, it seems the change was to add DMA engine
disable to sil_freeze(), right?  I can't see why changing the orders
would matter there.  ata_port_abort() just changes the internal state
of libata and doesn't affect low level driver or the hardware.
Whether doing it before or after __ata_port_freeze() shouldn't make
any different to sata_sil's freeze callback.  Am I missing something?

Thanks.

-- 
tejun
