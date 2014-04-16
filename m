From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: do not request irq for dummy port
Date: Wed, 16 Apr 2014 13:22:14 -0400
Message-ID: <20140416172203.GL1257@htj.dyndns.org>
References: <1397666626-15163-1-git-send-email-dmilburn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:48840 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbaDPRWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 13:22:18 -0400
Received: by mail-qa0-f48.google.com with SMTP id s7so10306651qap.21
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2014 10:22:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397666626-15163-1-git-send-email-dmilburn@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org, agordeev@redhat.com

On Wed, Apr 16, 2014 at 11:43:46AM -0500, David Milburn wrote:
> System may crash in ahci_hw_interrupt() or ahci_thread_fn() when accessing
> the interrupt status in a port's private_data if the port is actually a
> DUMMY port.
> 
> # lspci | grep ATA
> 00:1f.2 SATA controller: Intel Corporation 82801JI (ICH10 Family) SATA AHCI Controller
> 
> # systemctl status kdump (to ensure kdump service is running)
> # echo c > /proc/sysrq-trigger
> 
> <snip console output for linux-3.15-rc1>
...
> 
> Cc: Alexander Gordeev <agordeev@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-of-by: David Milburn <dmilburn@redhat.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
