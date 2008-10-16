From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] sgiioc4: kill useless address checks
Date: Thu, 16 Oct 2008 21:39:39 +0200
Message-ID: <200810162139.39612.bzolnier@gmail.com>
References: <200810152329.20095.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:49132 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757925AbYJPTwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 15:52:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so145098fkq.5
        for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 12:52:41 -0700 (PDT)
In-Reply-To: <200810152329.20095.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

On Wednesday 15 October 2008, Sergei Shtylyov wrote:
> The driver performs a number of checks on the virtual/physical addresses which
> would always evaluate as true:
> 
> - for sgiioc4_init_hwif_ports(), its caller, sgiioc4_ide_setup_pci_device(),
>   guarantees that 'ctrl_port' and 'irq_port' parameters are never 0;
> 
> - in sgiioc4_read_status(), we always read the IDE status register, so there's
>   no need to check the register's address (must be a leftover from the times
>   when this function implemented the INB() method);
> 
> - in ide_dma_sgiioc4(), 'dma_base' can never be 0 as IOC4_DMA_OFFSET is not 0.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied patches #1-2 (#1 w/ fixed patch description)
