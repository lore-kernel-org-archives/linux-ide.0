From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata SATAPI no data
Date: 30 May 2004 09:24:03 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1085930643.4318.6.camel@patibmrh9>
References: <1085607715.4148.128.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:8130 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263942AbUE3PYH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 30 May 2004 11:24:07 -0400
In-Reply-To: <1085607715.4148.128.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > Subject: Re: [PATCH] atapi request sense work
> > ...
> > in fact we have NOT yet explained
> > how to insert an ATA op x00 "NOP" ...
> > Instead, my kernel goes down  ...

Precisely as expected from our past work,

2.6.7-rc2, even with the not-substantive ata_check_bmdma rewording,
still can't cope with expecting no data for a CDB.  A CDB that actually
copies is ok only if I lie to say I expect data:

$ # "INQUIRY" for up to zero bytes
$ sudo plscsi -i 0x12 -x "12 00:00:00 00 00"
$

Honesty receives its expected penalty:

$ sudo plscsi -x "12 00:00:00 00 00"
$
Message from syslogd@patibmrh9 at Sun May 30 09:18:00 2004 ...
patibmrh9 kernel: Disabling IRQ #18

$

Pat LaVarre


