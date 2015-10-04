From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: cleanup ata_scsi_qc_complete
Date: Sun, 4 Oct 2015 13:39:07 -0400
Message-ID: <20151004173907.GE19652@htj.duckdns.org>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
 <1443892871-10413-3-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34131 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbJDRjL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Oct 2015 13:39:11 -0400
Received: by ykdg206 with SMTP id g206so150771659ykd.1
        for <linux-ide@vger.kernel.org>; Sun, 04 Oct 2015 10:39:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443892871-10413-3-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Sat, Oct 03, 2015 at 07:21:11PM +0200, Christoph Hellwig wrote:
> Remove an incorrect comment and untangle an if statement in
> ata_scsi_qc_complete.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.4.

Thanks.

-- 
tejun
