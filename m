From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: track spindown status and skip spindown_compat
 if possible
Date: Wed, 16 May 2007 01:22:12 -0400
Message-ID: <464A9504.1020405@garzik.org>
References: <46498B82.1030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53465 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762713AbXEPFWP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 01:22:15 -0400
In-Reply-To: <46498B82.1030802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Our assumption that most distros issue STANDBYNOW seems wrong.  The
> upstream sysvinit and thus many distros including gentoo and opensuse
> don't take any action for libata disks on spindown.  We can skip
> compat handling for these distros so that they don't need to update
> anything to take advantage of kernel-side shutdown.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> This patch is generated on top of fix-shutdown-warning-message-printing.
> 
>   http://article.gmane.org/gmane.linux.ide/18823
> 
> Jeff, I think we can avoid a lot of problems with this.  Those distros
> which didn't do anything on shutdown would still cause emergency
> unload on older kernels but at least it isn't a regression and things
> should just work on newer kernels.
> 
> If you ack this, I'll update the shutdown.html page accordingly.
> Thanks.

applied to #upstream-fixes


