From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Allow pata_legacy to be built on non-ISA but
 PCI	systems
Date: Sat, 13 Feb 2010 17:45:56 -0500
Message-ID: <4B772BA4.9050505@garzik.org>
References: <20100208100429.2679.52367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196]:48814 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486Ab0BMWp7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 17:45:59 -0500
Received: by yxe34 with SMTP id 34so1633928yxe.15
        for <linux-ide@vger.kernel.org>; Sat, 13 Feb 2010 14:45:59 -0800 (PST)
In-Reply-To: <20100208100429.2679.52367.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 02/08/2010 05:04 AM, Alan Cox wrote:
> This is needed for some unsupported hardware setups on strange 64bit
> mainboards where crazy stuff has been done like putting flash ata adapters
> on the LPC bus, or where the real hardware is hidden/confused.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/Kconfig |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)

applied


