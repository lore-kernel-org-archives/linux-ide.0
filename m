From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 6/6] pata_piccolo: Driver for old Toshiba chipsets
Date: Thu, 03 Dec 2009 02:36:08 -0500
Message-ID: <4B176A68.9000401@garzik.org>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <20091130132310.27236.83518.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:46659 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZLCHgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:36:04 -0500
Received: by gxk26 with SMTP id 26so995273gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 02 Dec 2009 23:36:10 -0800 (PST)
In-Reply-To: <20091130132310.27236.83518.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org, davem@davemloft.net

On 11/30/2009 08:23 AM, Alan Cox wrote:
> We were never able to get docs for this out of Toshiba for years. Dave
> Barnes produced a NetBSD driver however and from that we can fill in the
> needed tables.
>
> As we correct the PCI identifiers a bit also update the old ide generic driver
> at the same time so it stays compiling.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/Kconfig           |    9 +++
>   drivers/ata/Makefile          |    1
>   drivers/ata/ata_generic.c     |    5 +
>   drivers/ata/pata_piccolo.c    |  140 +++++++++++++++++++++++++++++++++++++++++
>   drivers/ide/ide-pci-generic.c |    3 +
>   include/linux/pci_ids.h       |    7 +-
>   6 files changed, 160 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/ata/pata_piccolo.c

applied 1-6 (hi DaveM)


