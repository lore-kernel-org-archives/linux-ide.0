From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/10] ide: use pci_dev->revision
Date: Sat, 01 Sep 2007 20:21:30 +0400
Message-ID: <46D9918A.6000703@ru.mvista.com>
References: <200708292316.38779.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:49126 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755056AbXIAQSn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 12:18:43 -0400
In-Reply-To: <200708292316.38779.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Auke Kok <auke-jan.h.kok@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

Bartlomiej Zolnierkiewicz wrote:

> Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID so
> they were not converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65.

> ---
> Quick grep over kernel tree finds out many other places using either
> pci_read_config_dword(dev, PCI_CLASS_REVISION, ...) & 0xff or simply
> pci_read_config_byte(dev, PCI_CLASS_REVISION, ...) and they all can be
> converted to using dev->revision.

    Nice! I was wondering all the time why the revision ID isn't held with he 
device/vendor IDs (wile being a vital detail for many IDE chips ;-).

> Auke, a "PCI_CLASS_REVISION" follow-up to your previous patch would be great.
> :)

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
