From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] AHCI: use ATA_BUSY
Date: Mon, 24 Jun 2013 16:30:24 -0700
Message-ID: <20130624233024.GR1918@mtj.dyndns.org>
References: <201306230139.39597.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:35356 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab3FXXab (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2013 19:30:31 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so180061qak.2
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 16:30:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201306230139.39597.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org

On Sun, Jun 23, 2013 at 01:39:39AM +0400, Sergei Shtylyov wrote:
> ahci_hardreset() and ahci_p5wdh_hardreset() use bare numbers for the BSY bit of
> the  ATA status  register, despite it's #define'd in <linux/ata.h>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.11.

Thanks.

-- 
tejun
