From: Gary Thomas <gary@mlbassoc.com>
Subject: SATA Promise
Date: Tue, 19 Dec 2006 08:54:07 -0700
Message-ID: <45880B1F.3030701@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sta-204-188-98-27.rockynet.com ([204.188.98.27]:2543 "EHLO
	hermes.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbWLSQN7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 11:13:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

I'm trying to use the sata_promise driver (1.04) with a CDROM
and having little luck.  I'm using this chipset:
   00:0b.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)

If I plug in a SATAPI drive, the driver hangs during initialization.
If I plug in a (PATA) ATAPI drive, I'm told:

ata3.01: ATAPI, max MWDMA2
ata3.01: configured for MWDMA2
   Vendor: ATA       Model: ST3250824NS       Rev: 3.AE
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata3.01: WARNING: ATAPI is not supported with this driver, device ignored.

Is there any way to get this working (I'm using Linux 2.6.18, with
linux-2.6-sata-promise-pata-ports.patch from Fedora Core 6)

Thanks for any help/pointers

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
