From: Chris Dearman <chris@ftp.linux-mips.org>
Subject: Re: [PATCH 0/1] sata_sil: Option to use IO space to access TF
	registers.
Date: Thu, 23 Oct 2008 00:34:39 +0100
Message-ID: <20081022233439.GA30488@ftp.linux-mips.org>
References: <20081022182243.9471.87443.stgit@linux-chris2.mips.com> <20081022221623.344aea62@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([213.58.128.207]:52254 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYJVXek (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 19:34:40 -0400
Received: (from localhost user: 'chris' uid#10014 fake: STDIN
	(chris@ftp.linux-mips.org)) by ftp.linux-mips.org id S22165899AbYJVXej
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Oct 2008 00:34:39 +0100
Content-Disposition: inline
In-Reply-To: <20081022221623.344aea62@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Alan,

> You need to fix your ioread8/iowrite8 and other accessors to work around
> this if at all possible and that will cover all your devices.

 I would like to have a generic solution for all devices, but
unfortunately I don't think that's possible. There is no way to
generate a read cycle to PCI memory space on this hardware without all
of the byte enables being set. Normally this isn't a problem, a full
word is read on the PCI bus and the processor picks out the bytes it
needs, but memory mapped registers with access restrictions are a
problem.  PCI memory writes and PCI IO reads/writes do generate the
correct byte enables.

  I did consider checking for accesses to particular locations on
particular PCI devices in ioread8/ioread16 and silently converting
them into equivalent IO accesses (assuming one exists of course...),
but it gets pretty nasty. Eg on this SATA chip I would have to map
the IO BARS behind the drivers back, and it's still not a generic
solution - for each new device I would have to add affected
addresses to ioread8/ioread16. 

  The patch is a relatively clean work around for limitations in the
hardware I'm using, but I know it probably looks like just more
cruft from an outside perspective so I won't be championing it :)

Chris
