From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 13/13] libata-hp: move ata_do_reset() to libata-eh.c
Date: Fri, 19 May 2006 12:13:06 -0400
Message-ID: <446DEE92.50102@pobox.com>
References: <11480537082648-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:30122 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932436AbWESQNT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:13:19 -0400
In-Reply-To: <11480537082648-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> With ops->probe_init() gone, no user is left in libata-core.c.  Move
> ata_do_reset() to libata-eh.c and make it static.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 8-13


