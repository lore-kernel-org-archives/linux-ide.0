From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 07/11] ata_piix: convert to new EH
Date: Sat, 13 May 2006 18:23:04 -0400
Message-ID: <44665C48.2020003@pobox.com>
References: <11473536883879-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56711 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932368AbWEMWXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:23:14 -0400
In-Reply-To: <11473536883879-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> ata_piix can use stock BMDMA EH routines.  Convert to new EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


