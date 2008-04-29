From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_via: Fix 6410 misdetect
Date: Tue, 29 Apr 2008 17:43:42 -0400
Message-ID: <4817968E.2070008@garzik.org>
References: <20080429141057.650e6b0a@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40837 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbYD2Vnw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 17:43:52 -0400
In-Reply-To: <20080429141057.650e6b0a@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The discrete VIA ATA chips don't have 0x40 enable bits. We check that
> properly in one location but not another. This causes some users 6410
> RAID cards to be incorrectly skipped.
> 
> Would be good if this made the next kernel (may also be appropriate for
> stable)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


