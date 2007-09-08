From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Remove sync waiting code from libata
Date: Sat, 08 Sep 2007 17:14:21 +0900
Message-ID: <46E259DD.5090609@gmail.com>
References: <20070907024632.GH27404@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:38149 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbXIHRIR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Sep 2007 13:08:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so690083rvb
        for <linux-ide@vger.kernel.org>; Sat, 08 Sep 2007 10:08:16 -0700 (PDT)
In-Reply-To: <20070907024632.GH27404@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Matthew Wilcox wrote:
> By using the scsi async probing code, we can remove the 'sync' argument
> from ata_scsi_scan_host():

Hmmm... How so?  @sync is there to keep device numbering stable even
when SCSI scan fails due to allocation failure.  I don't see how async
probing changes that.

-- 
tejun

