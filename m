From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Mon, 24 Jun 2013 15:46:31 -0700
Message-ID: <20130624224631.GN1918@mtj.dyndns.org>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:55008 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab3FXWqg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2013 18:46:36 -0400
Received: by mail-qc0-f180.google.com with SMTP id a1so6737920qcx.39
        for <linux-ide@vger.kernel.org>; Mon, 24 Jun 2013 15:46:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201306232325.04732.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, aaron.lu@intel.com

On Sun, Jun 23, 2013 at 11:25:04PM +0400, Sergei Shtylyov wrote:
> There are  some SATA controllers which have both devices 0 and 1 but this module
> just zeroes out taskfile and sets then ATA_TFLAG_DEVICE (not sure that's needed)
> which could  lead to a wrong device being selected just before issuing command.
> Thus we should  call ata_tf_init()  which sets  up the device register value
> properly, like  all other users of ata_exec_internal() do...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.11 w/ stable cc'd.

Thanks.

-- 
tejun
