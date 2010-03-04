From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] ahci: Add platform driver
Date: Thu, 04 Mar 2010 13:04:22 -0500
Message-ID: <4B8FF626.6060704@pobox.com>
References: <20100304170525.GA8126@oksana.dev.rtsoft.ru> <20100304170606.GB29022@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62002 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0CDSEZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Mar 2010 13:04:25 -0500
In-Reply-To: <20100304170606.GB29022@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/04/2010 12:06 PM, Anton Vorontsov wrote:
> This can be used for AHCI-compatible interfaces implemented inside
> System-On-Chip solutions, or AHCI devices connected via localbus.
>
> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
> ---
>   drivers/ata/Kconfig           |    8 ++
>   drivers/ata/Makefile          |    1 +
>   drivers/ata/ahci_platform.c   |  191 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/ahci_platform.h |   29 ++++++
>   4 files changed, 229 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/ata/ahci_platform.c
>   create mode 100644 include/linux/ahci_platform.h

applied 1-2 to #upstream

Thanks for this work, this will give me the kick-in-the-pants necessary 
to move forward on mv-ahci and acard-ahci.

	Jeff



