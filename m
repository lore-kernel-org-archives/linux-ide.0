From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v2] libata: only call ->done once all per-tag
 ressources are released
Date: Mon, 12 Oct 2015 12:23:42 -0400
Message-ID: <20151012162342.GD23399@mtj.duckdns.org>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
 <1443892871-10413-2-git-send-email-hch@lst.de>
 <20151004173429.GD19652@htj.duckdns.org>
 <20151008082541.GA8969@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34379 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076AbbJLQXp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Oct 2015 12:23:45 -0400
Received: by ykdg206 with SMTP id g206so138768220ykd.1
        for <linux-ide@vger.kernel.org>; Mon, 12 Oct 2015 09:23:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151008082541.GA8969@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Thu, Oct 08, 2015 at 10:25:41AM +0200, Christoph Hellwig wrote:
> When calling ->done before releasing resources we could run into a
> race where the SCSI midlayer sends another command and races with
> the resources beeing manipulated.  For libata this can't currently
> happen as synchronization happens at a higher level, but I'd still
> like to fix it to future proof libata and to avoid copy & paste
> into SCSI drivers where this pattern has led to reproducible crashes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
