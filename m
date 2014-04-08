From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix i.MX AHCI driver dependencies
Date: Tue, 8 Apr 2014 08:37:35 -0400
Message-ID: <20140408123735.GA21329@htj.dyndns.org>
References: <20140408110626.0eebbbf2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:40222 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbaDHMhi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Apr 2014 08:37:38 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so784332qaq.28
        for <linux-ide@vger.kernel.org>; Tue, 08 Apr 2014 05:37:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140408110626.0eebbbf2@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Tue, Apr 08, 2014 at 11:06:26AM +0200, Jean Delvare wrote:
> The ahci_imx driver is only needed on Freescale i.MX platforms so
> don't let it be built on other platforms, except for build test
> purpose.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Richard Zhu <r65037@freescale.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
