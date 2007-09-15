From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/10] ide: add ->chipset field to ide_pci_device_t
Date: Sat, 15 Sep 2007 21:20:25 +0400
Message-ID: <46EC1459.8000709@ru.mvista.com>
References: <200709112339.34991.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59465 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751541AbXIORRJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 13:17:09 -0400
In-Reply-To: <200709112339.34991.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Add ->chipset field to ide_pci_device_t and use it in ide_hwif_configure()
> to set hwif->chipset.  Convert cmd64x, cy82c693, rz1000 and trm290 host
> drivers to use this new ability.

> While at it define hwif_chipset_t as u8 to save some space in hw_regs_t,
> ide_hwif_t and ide_pci_device_t instances.

    I( wonder what's so special about say cmd64x_chipset -- why it's got its 
own value?  Some histerical raisins? :-)

MBR, Sergei
