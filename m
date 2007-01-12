From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
Date: Fri, 12 Jan 2007 11:58:34 -0500
Message-ID: <45A7BE3A.40508@garzik.org>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59083 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932281AbXALQ6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Jan 2007 11:58:42 -0500
In-Reply-To: <200701120958.l0C9wICB019343@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com

Akira Iguchi wrote:
> Dear everyone,
> 
> This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> which access the taskfile registers. The idea comes from drivers/ide
> IN*/OUT* calls.
> 
> As you know, these calls are unnecessary for most libata drivers.
> But the Celleb PATA driver needs them to use the libata common code.
> And using these calls, it is possible to remove similar code
> about PIO/MMIO access.

Sorry, but NAK.

libata intentionally provides higher level hooks than just I/O accessors.

A low level I/O hook approach makes it difficult to take into account 
platform-specific details like mmiowb(), especially on embedded platforms.

The high level hook approach also enables greater efficiency.  For 
example, an embedded platform could do

	__raw_writeb(datum, mmio_address + ATA_REG_FOO);
	__raw_writeb(datum, mmio_address + ATA_REG_BAR);
	eieio();

to optimize an entire taskfile-read or taskfile-write operation.

	Jeff



