From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Wed, 19 May 2004 16:54:53 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8A55CC7D-A9E7-11D8-B31E-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40A7F641.3070809@pobox.com>
	 <1084819720.4328.86.camel@patibmrh9>  <40A90D96.2040002@pobox.com><108482
	 8		840.3211.26.camel@patibmrh9>  <40A92F69.6030309@pobox.com><1084831524.3
	2 11	.67.camel@patibmrh9>  <40A93E85.4010904@pobox.com> <1084920024.3191.8.
	ca mel@patibmrh9> <40AAA0BA.9040307@pobox.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:6565 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264665AbUESWy6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 18:54:58 -0400
In-Reply-To: <40AAA0BA.9040307@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

This actually almost does work.  Once via ssh I saw:

$ sudo modprobe ata-piix
$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00"
// x 6 29 sense
// -x0002 = -2 = plscsi.main exit int
$ plscsi /dev/sg0 -X time 5 0 -i 8 -x "25 00 00:00:00:00 00 00:00 00"
...

Argh I should have said -v to plscsi.  Meanwhile, without complete 
proof, I believe that "// x 6 29 sense" line from plscsi means an auto 
sense once ran well enough to produce sense byte 0 = x70, a sane 
additional length at offset 7, and SK ASC ASCQ = x 6 29 00 i.e. auto 
sense once mostly worked.

But then the second try of that same command dumped an indefinitely 
long series of what by eye and hand I transcribe as:

ata_scsi_translate: ENTER
ata_scsi_dump_cdb: CDB(2:0,0,0) 25 00 00 00 00 00 00 00 00

Sorry to say now real life intrudes, I'll report again later/ tomorrow.

Pat LaVarre

