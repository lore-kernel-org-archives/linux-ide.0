From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev-2.6-ncq: ahci: remove ata_port_start/stop()
 calls
Date: Sun, 26 Jun 2005 13:29:07 -0400
Message-ID: <42BEE5E3.9050204@pobox.com>
References: <20050626145250.GF24968@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8652 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261484AbVFZR3L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 13:29:11 -0400
In-Reply-To: <20050626145250.GF24968@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: axboe@suse.de, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
>  Hello, Jens.
> 
>  This is the last of six misc updates to ncq.
> 
>  This patch removes unnecessary ata_port_start/stop() calls from
> ahci_port_start/stop().
> 
>  Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK


