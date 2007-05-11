From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] Fix build failure for drivers/ata/pata_scc.c
Date: Fri, 11 May 2007 13:56:08 +0200
Message-ID: <464459D8.1030305@gmail.com>
References: <20070511064954.GE15955@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:58242 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803AbXEKL4V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 07:56:21 -0400
Received: by py-out-1112.google.com with SMTP id a29so763704pyi
        for <linux-ide@vger.kernel.org>; Fri, 11 May 2007 04:56:20 -0700 (PDT)
In-Reply-To: <20070511064954.GE15955@bakeyournoodle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, Akira Iguchi <akira2.iguchi@toshiba.co.jp>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, cbe-oss-dev@ozlabs.org

Tony Breeds wrote:
> The commit d4b2bab4f26345ea1803feb23ea92fbe3f6b77bc added deadline support to
> prereset and reset methods to libbata the pata_scc driver wasn't converted.
> This patch is a naive attempt to bring this driver up to scratch.
> 
> Build failures are:
> drivers/ata/pata_scc.c: In function 'scc_pata_prereset':
> drivers/ata/pata_scc.c:870: error: too few arguments to function 'ata_std_prereset'
> drivers/ata/pata_scc.c: In function 'scc_error_handler':
> drivers/ata/pata_scc.c:916: warning: passing argument 2 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c:916: warning: passing argument 3 of 'ata_bmdma_drive_eh' from incompatible pointer type
> drivers/ata/pata_scc.c: In function 'scc_pata_prereset':
> drivers/ata/pata_scc.c:871: warning: control reaches end of non-void function
> 
> On a releated note scc_bus_post_reset() is (AFACT) identical to
> ata_bus_post_reset(), would a patch to make ata_bus_post_reset() assesable to
> drivers be accepted?
> 
> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> CC: Tejun Heo <htejun@gmail.com>
> CC: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> CC: Jeff Garzik <jgarzik@pobox.com>
> CC: linux-ide@vger.kernel.org

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
