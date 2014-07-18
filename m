From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] Add support for the Promise FastTrak TX8660 SATA HBA
 (ahci mode)
Date: Fri, 18 Jul 2014 18:00:36 -0400
Message-ID: <20140718220036.GB1819@htj.dyndns.org>
References: <1405094893-9768-1-git-send-email-romain.degez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:42986 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbaGRWAk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jul 2014 18:00:40 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so3481733qaq.13
        for <linux-ide@vger.kernel.org>; Fri, 18 Jul 2014 15:00:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405094893-9768-1-git-send-email-romain.degez@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Romain Degez <romain.degez@gmail.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jul 11, 2014 at 06:08:13PM +0200, Romain Degez wrote:
> Add support of the Promise FastTrak TX8660 SATA HBA in ahci mode by registering the board in the ahci_pci_tbl[].
> 
> Note: this HBA also provide a hardware RAID mode when activated in BIOS but specific drivers from the manufacturer are required in this case.
> 
> Signed-off-by: Romain Degez <romain.degez@gmail.com>
> Tested-by: Romain Degez <romain.degez@gmail.com>

Applied to libata/for-3.16-fixes.

Thanks.

-- 
tejun
