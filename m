From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 20 May 2004 21:05:02 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <A6CE2F32-AAD3-11D8-8B8A-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	 <1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482
	 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3
	2 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com> <1084920024.3191.8.
	ca mel@patibmrh9> <40AAA0BA.9040307@pobox.com> <8A55CC7D-A9E7-11D8-B31E-003
	065635034@ieee.org> <6AC5FDFB-AACA-11D8-8B8A-003065635034@ieee.org> <6E36A1
	1B-AACB-11D8-8B8A-003065635034@ieee.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:62633 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265357AbUEUDFF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2004 23:05:05 -0400
In-Reply-To: <6E36A11B-AACB-11D8-8B8A-003065635034@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> yes indeed, ata_scsi_translate re-entered itself at least 4551 times 
> ...

printk tells me reentry occurs after ata_scsi_translate calls 
ata_scsi_qc_new, before ata_scsi_qc_new returns.

dump_stack tells me we're looking at indefinite serial reentry, not 
recursion.

Reworking ata_eng_timeout to call ata_dma_complete or ata_qc_complete 
even after atapi_error, same as when we need no auto sense, doesn't 
stop the indefinite reentry but does let me halt the indefinite reentry 
by counting reentries and then past some limit returning from 
ata_scsi_translate before calling ata_scsi_qc_new.

By contrast, with ata_eng_timeout as posted, that kind of reentry trap 
does not halt the reentry.

Pat LaVarre

