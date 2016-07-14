From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 03/10] libsas: use ata_is_ncq() and ata_has_dma()
 accessors
Date: Thu, 14 Jul 2016 10:45:36 -0400
Message-ID: <20160714144536.GG15005@htj.duckdns.org>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-4-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33824 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcGNOpj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 10:45:39 -0400
Received: by mail-yw0-f195.google.com with SMTP id l125so5030804ywb.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 07:45:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468454751-12466-4-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Thu, Jul 14, 2016 at 09:05:44AM +0900, Christoph Hellwig wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Use accessors instead of the raw protocol value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> [hch: trivial cleanup of the ata_task assignments]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied 1-3 to libata/for-4.8.

Thanks.

-- 
tejun
