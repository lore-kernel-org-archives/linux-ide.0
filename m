From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH UPDATED #upstream] ahci: misc cleanups for EM stuff
Date: Wed, 20 May 2009 16:12:05 -0400
Message-ID: <4A146415.8020903@garzik.org>
References: <49F642FC.1090602@kernel.org> <4A086AB9.3020002@garzik.org> <4A08D795.70102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50442 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbZETUMG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 16:12:06 -0400
In-Reply-To: <4A08D795.70102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, David Milburn <dmilburn@redhat.com>

Tejun Heo wrote:
> Make the following EM related cleanups.
> 
> * Use msleep(1) instead of udelay(100) and reduce retry count to 5.
> 
> * s/MAX_SLOTS/EM_MAX_SLOTS/, s/MAX_RETRY/EM_MAX_RETRY/
> 
> * Make EM constants enums as suggested by Jeff.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: David Milburn <dmilburn@redhat.com>
> ---
>  drivers/ata/ahci.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

applied


