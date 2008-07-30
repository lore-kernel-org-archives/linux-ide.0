From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Wed, 30 Jul 2008 17:04:53 +0800
Message-ID: <48902EB5.8070102@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com> <488F1C6C.9000002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 215.47.DSNET ([211.144.215.47]:34433 "EHLO
	cnshjsmin03.cn.alcatel-lucent.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751812AbYG3JgI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 05:36:08 -0400
In-Reply-To: <488F1C6C.9000002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>


>
> Can you try disabling the IDE driver (CONFIG_IDE) and enabling the 
> newer libata driver?  (CONFIG_ATA)
>
Jeff, I tried moving to ATA driver for PIIX4 today and found ATA need to 
request
2 IRQ lines, each one of them belongs to primary and secondary channel. 
However,
when I make PIIX4 worked under IDE driver, it also need to request one 
IRQ for "ide1".
So it's necessary to disable secondary channel manually?

Another question is my PIIX4 chip has device ID + vendor ID of 
0x71108086. But it finally
was mapped to following ID of piix_pci_tbl[] array. Device of 0x7110 and 
0x7010 should
be quit different, right?

 { 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },

Gavin
