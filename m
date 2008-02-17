From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ICH7: ata_piix twice as fast as ahci?
Date: Sun, 17 Feb 2008 16:10:33 +0000
Message-ID: <20080217161033.3bb420fd@core>
References: <6b9952490802170741h1de9be53nefccea3775f7de00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39338 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751720AbYBQQSv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 11:18:51 -0500
In-Reply-To: <6b9952490802170741h1de9be53nefccea3775f7de00@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joris <joris@v5.be>
Cc: Linux IDE <linux-ide@vger.kernel.org>

On Sun, 17 Feb 2008 16:41:42 +0100
Joris <joris@v5.be> wrote:

> Hello List,
> 
> Odd problem on my machines: the sata disks appear to be a lot slower
> when used via ata_piix vs the ahci driver.

I would expect that. AHCI allows the use of NCQ and unloads a ton of work
from the processor. It also means you pretty much avoid the inter command
latency that limits standard IDE performance.
