From: Borislav Petkov <petkov@uni-muenster.de>
Subject: [RFC] [PATCH 0/2] libata debugging
Date: Tue, 30 Aug 2005 11:46:52 +0200
Message-ID: <200508301146.53482.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:60602 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1750907AbVH3KAL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Aug 2005 06:00:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

Hi Jeff, hi all,

here's a preliminary patch that converts the libata debugging code to 
something similar to the netdev debugging mechanism. This is, however, only 
an alpha version and introduces the main concept as proposed by Jeff. Its 
purpose is to collect as much feedback from you all as possible in order for 
me to correct it and Do the Right Thing(tm). (That's why I converted only 
libata-core.c - the rest after the review.) Some questions that arose during 
the process:

1. ata_dev_classify() doesn't have an ata_port pointer defined in order to 
query the debugging level but its users have so should i convert it to 

unsigned int ata_dev_classify(struct ata_taskfile *tf, struct ata_port *ap)

so that the ata_port pointer gets passed and debugging is enabled?

2. ata_{host,device}_add() and ata_pci_init_one() are initialization functions 
and in this case an ata_port is not yet/still getting initialized. How should 
we print debugging messages there?

3. What about the assert() macro in <include/linux/libata.h>?

 Thanks and regards,
Borislav Petkov.
