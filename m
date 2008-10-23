From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/2 #upstream-fixes] sata_via: load DEVICE register when
 CTL changes
Date: Wed, 22 Oct 2008 20:43:06 -0400
Message-ID: <48FFC89A.6010104@garzik.org>
References: <48FDF935.6010307@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50745 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178AbYJWAnN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 20:43:13 -0400
In-Reply-To: <48FDF935.6010307@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Joseph Chan <JosephChan@via.com.tw>

Tejun Heo wrote:
> VIA controllers clear DEVICE register when IEN changes.  Make sure
> DEVICE is updated along with CTL.
> 
> This change is separated from Joseph Chan's larger patch.
> 
>   http://thread.gmane.org/gmane.linux.kernel.commits.mm/40640
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Joseph Chan <JosephChan@via.com.tw>
> ---
> These two patches are on top of
> 
> linus#master
> + [1] libata-eh-fix-slave-link-EH-action-mask-handling
> + [2] libata-transfer-EHI-control-flags-to-slave-ehc_i
> + [3] libata-set-device-class-to-NONE-if-phys_offline
> 
> [1] http://article.gmane.org/gmane.linux.ide/35390
> [2] http://article.gmane.org/gmane.linux.ide/35393
> [3] http://article.gmane.org/gmane.linux.ide/35436
> 
> and finally gets vt8251 working.  I'll integrate this into the
> separate-sff-bmdma git tree.  :-)

applied


