From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 20 May 2004 20:06:11 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <6E36A11B-AACB-11D8-8B8A-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	 <1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482
	 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3
	2 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com> <1084920024.3191.8.
	ca mel@patibmrh9> <40AAA0BA.9040307@pobox.com> <8A55CC7D-A9E7-11D8-B31E-003
	065635034@ieee.org> <6AC5FDFB-AACA-11D8-8B8A-003065635034@ieee.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:50933 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265332AbUEUCGN
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2004 22:06:13 -0400
In-Reply-To: <6AC5FDFB-AACA-11D8-8B8A-003065635034@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> a trivial recursion trap I added ..., this time around.

I meant to say reentry trap.

(I'm too much of a newbie to know how to distinguish reentry from 
recursion in Linux.)

Anyhow, yes indeed, ata_scsi_translate re-entered itself at least 4551 
times before my Ctrl+C and `reboot` took effect, when provoked by a 
standard "INQUIRY" after auto sense, specifically:

plscsi /dev/sg0 -X time 5 0 -v

The only -bk6 dmesg I get are an indefinitely long series of:

ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
kernel: ata_scsi_translate: ENTER

Pat LaVarre

