From: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: [RFC] libata debugging
Date: Sun, 28 Aug 2005 08:40:43 +0200
Message-ID: <200508280840.44037.petkov@uni-muenster.de>
References: <430C10E7.9060502@pobox.com> <200508242304.22998.petkov@uni-muenster.de> <200508251836.46738.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:3560 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S1750735AbVH1Gke (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Aug 2005 02:40:34 -0400
In-Reply-To: <200508251836.46738.petkov@uni-muenster.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

HI Jeff,

another question: 
unsigned int ata_dev_classify(struct ata_taskfile *tf) 

in drivers/scsi/libata-core.c doesn't have access to an ata_port struct and it 
thus cannot be converted to the new ata_msg_xxx usage. However, this function 
has only two users which both have ata_port defined in their function bodies. 
Should I change the interface of ata_dev_classify from 

unsigned int ata_dev_classify(struct ata_taskfile *tf)

to 

unsigned int ata_dev_classify(struct ata_taskfile *tf, struct ata_port *ap)

so that it can be converted to the proper logging system? I'm asking not 
because it is open source but because you probably might have some other 
interface design considerations or concerns that I (mostly) can't know of and 
an interface change is not an option.

--
Regards,
Boris.
