From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ #3
Date: Tue, 31 May 2005 11:05:16 -0400
Message-ID: <429C7D2C.9080703@pobox.com>
References: <20050531124659.GB1530@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:50816 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261623AbVEaPFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 May 2005 11:05:21 -0400
In-Reply-To: <20050531124659.GB1530@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> - (libata) import an error handling fix from Hannes.

Keep this separate, his fix is busted.  Calling scsi_eh_abort_cmds() 
without an abort handler is highly ineffective, and highly silly.


> Jeff, I'll update your ncq branch at the end of this week if you don't
> beat me to it.

Just an incremental patch will do it :)

	Jeff


