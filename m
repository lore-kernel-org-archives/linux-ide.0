From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] libata: fix ata_id_logical_per_physical_sectors
Date: Wed, 03 Feb 2010 12:42:13 -0500
Message-ID: <4B69B575.9060201@pobox.com>
References: <20100128104234.GA25693@lst.de> <20100128123011.GA32001@lst.de> <20100203173721.GA21703@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:49994 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758Ab0BCRmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Feb 2010 12:42:15 -0500
Received: by gxk24 with SMTP id 24so2051833gxk.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Feb 2010 09:42:15 -0800 (PST)
In-Reply-To: <20100203173721.GA21703@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, stable@kernel.org

On 02/03/2010 12:37 PM, Christoph Hellwig wrote:
> Jeff, ping?  Without this patch the minimum I/O size for 4k drives will
> be reported incorrectly, which will make paritions misaligned on modern
> distros.

It's queued locally.  I'm waiting to push on the flush_dache_page() 
discussion for 2.6.33, but I'll make sure your patch gets pushed today 
one way or the other.

	Jeff


