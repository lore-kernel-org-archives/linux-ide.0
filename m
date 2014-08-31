From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libahci_platform: Staticize
 ahci_platform_<en/dis>able_phys()
Date: Sun, 31 Aug 2014 00:01:58 -0400
Message-ID: <20140831040158.GA5013@htj.dyndns.org>
References: <1409427549-1846-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:48780 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaHaECC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2014 00:02:02 -0400
Received: by mail-qg0-f52.google.com with SMTP id z60so3995245qgd.11
        for <linux-ide@vger.kernel.org>; Sat, 30 Aug 2014 21:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409427549-1846-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Aug 30, 2014 at 04:39:09PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> ahci_platform_enable_phys() and ahci_platform_disable_phys() are currently
> exported, but they are not used anywhere else other than libahci_platform.c.
> 
> So make them static and do not export them to fix the following sparse
> warnings:
> 
> drivers/ata/libahci_platform.c:52:5: warning: symbol 'ahci_platform_enable_phys' was not declared. Should it be static?
> drivers/ata/libahci_platform.c:88:6: warning: symbol 'ahci_platform_disable_phys' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to libata/for-3.18. Thanks.

-- 
tejun
