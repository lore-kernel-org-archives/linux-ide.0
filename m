From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 06/10] libata-eh: decode all taskfile protocols
Date: Thu, 14 Jul 2016 10:48:09 -0400
Message-ID: <20160714144809.GH15005@htj.duckdns.org>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-7-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36638 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNOsL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 10:48:11 -0400
Received: by mail-yw0-f195.google.com with SMTP id y188so5072248ywf.3
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 07:48:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468454751-12466-7-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Thu, Jul 14, 2016 at 09:05:47AM +0900, Christoph Hellwig wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Some taskfile protocol values where missing in ata_eh_link_report().
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied 5-6 to libata/for-4.8.

For the rest, I'll wait for the response on 4.

Thanks.

-- 
tejun
