From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Store bus addresses (versus -mm for testing)
Date: Sat, 28 Jul 2007 17:11:42 +0900
Message-ID: <46AAFA3E.50407@gmail.com>
References: <20070726192315.61ffe93d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:39849 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbXG1ILt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 04:11:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so170266rvb
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 01:11:48 -0700 (PDT)
In-Reply-To: <20070726192315.61ffe93d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
> As we cannot reverse iomap results portably as we tried before the libata
> layer needs to keep bus addresses around for reporting. This first big
> patch adds a structure for it and teaches the drivers to keep the
> information. Thankfully most drivers go via libata-sff and it can do the
> work for them.
> 
> For the others we replace ata_std_ports with ata_std_io_ports /
> std_mmio_ports and pass both the mapped and some bus address info.
> 
> We don't keep all the mappings in both forms. We only need cmd, ctrl and
> status (for wait_status() reporting). We also keep a "base" for devices
> where the taskfile (cmd/ctl) mapping makes no sense.
> 
> This patch stores all the data but doesn't yet change the display side.
> I've got a couple of variants I'm playing with on the display side and
> want to get that right. In the mean time this should store all the data
> and have no side effects for anyone, so is a good first chunk for testing
> alone.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Eeeek... I don't think this is a good idea.  I liked the getting
original address from mapped address thing.  Is it impossible to get
that working on some archs?  Or is it just not there yet?

Thanks.

-- 
tejun
