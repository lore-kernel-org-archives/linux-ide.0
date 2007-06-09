From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PROBLEM + PATCH] Sata port disabled by BIOS gets initialized
 by ata_piix drive
Date: Sat, 09 Jun 2007 14:51:51 +0900
Message-ID: <466A3FF7.4090302@gmail.com>
References: <9493.1181310368198.JavaMail.root@wombat.diezmil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:2863 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXFIFxQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 01:53:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1332264wah
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 22:53:15 -0700 (PDT)
In-Reply-To: <9493.1181310368198.JavaMail.root@wombat.diezmil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shyam_iyer@dell.com
Cc: linux-ide@vger.kernel.org

shyam_iyer@dell.com wrote:
> Problem Sata disks are connected to onboard sata ports of PowerEdge
> 1900 (ESB2 southbridge chipset). If one of the port is disabled in
> the bios then they get enabled again by the ata_piix driver because
> of a default port map being written to the Port control and status
> register(0x91-93). Instead the driver should preserve the bios
> setting by way of a fix like this.

What happens if the port is enabled by the kernel?

> Fix: The BIOS configured PCS value must be anded logically with the
> default port map for the chipset. This way the BIOS information will
> not be lost by the reinitialization of the config space by the
> ata_piix driver. The below patch is against 2.6.21 kernel.

I'm not sure whether this is a good idea and it has potential to break a
lot of other configurations.  That part of code is used for *all*
ata_piix out there, so we need a really really good reason to change
that.  So, please explain what you're trying to fix better.

-- 
tejun
