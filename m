From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/13] libata-hp: move ata_do_reset() to libata-eh.c
Date: Thu, 08 Jun 2006 16:58:22 -0400
Message-ID: <44888F6E.10005@pobox.com>
References: <11490747461666-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:4314 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965016AbWFHU6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 16:58:33 -0400
In-Reply-To: <11490747461666-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With ops->probe_init() gone, no user is left in libata-core.c.  Move
> ata_do_reset() to libata-eh.c and make it static.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK 4-13


