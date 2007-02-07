From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_inic162x: fix a few glitches in hardreset
Date: Tue, 06 Feb 2007 19:44:07 -0500
Message-ID: <45C920D7.7010109@garzik.org>
References: <20070202062952.GB1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56959 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932952AbXBGAoI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:44:08 -0500
In-Reply-To: <20070202062952.GB1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> * Hardreset must not exit without actually performing reset regardless
>   of link status.  We're resetting the link after all.
> 
> * Minor message update.
> 
> * 150ms delay is meaningful iff link is online after reset is
>   complete.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_inic162x.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)

applied


