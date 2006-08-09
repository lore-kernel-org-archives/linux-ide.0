From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: Add full Compact Flash support to libata
Date: Tue, 08 Aug 2006 23:42:27 -0400
Message-ID: <44D959A3.1090908@pobox.com>
References: <1154016810.13509.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:6555 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030443AbWHIDm3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 23:42:29 -0400
In-Reply-To: <1154016810.13509.61.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

ACK, but patch doesn't apply to libata-core.c.

Also, git-applymbox complains that you add trailing whitespace:
> 
> [jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
> 1 patch(es) to process.
> 
> Applying 'Add full Compact Flash support to libata'
> 
> Adds trailing whitespace.
> .dotest/patch:119:      { XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 },
> Adds trailing whitespace.
> .dotest/patch:120:      { XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 },
> Adds trailing whitespace.
> .dotest/patch:190:      if (ata_id_major_version(id) >= 3 &&  id[82] != 0xFFFF &&
> Adds trailing whitespace.
> .dotest/patch:195:
> error: patch failed: drivers/scsi/libata-core.c:3073
> error: drivers/scsi/libata-core.c: patch does not apply

