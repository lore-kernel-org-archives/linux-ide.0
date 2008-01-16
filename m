From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] sata_qstor: convert to new data_xfer prototype
Date: Wed, 16 Jan 2008 05:24:32 -0500
Message-ID: <478DDB60.7050904@garzik.org>
References: <11992723701811-git-send-email-htejun@gmail.com> <11992723713373-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37608 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbYAPKYe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Jan 2008 05:24:34 -0500
In-Reply-To: <11992723713373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> While merging data_xfer prototype change, pata_pcmcia was left out.
> Convert it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/pata_pcmcia.c |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)

applied


