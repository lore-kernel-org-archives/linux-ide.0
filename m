From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: only call ->done once all per-tag ressources
 are released
Date: Sun, 4 Oct 2015 13:34:29 -0400
Message-ID: <20151004173429.GD19652@htj.duckdns.org>
References: <1443892871-10413-1-git-send-email-hch@lst.de>
 <1443892871-10413-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33273 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbJDRed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Oct 2015 13:34:33 -0400
Received: by ykft14 with SMTP id t14so152344322ykf.0
        for <linux-ide@vger.kernel.org>; Sun, 04 Oct 2015 10:34:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1443892871-10413-2-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Sat, Oct 03, 2015 at 07:21:10PM +0200, Christoph Hellwig wrote:
> Without this the SCSI midlayer can race and queue another command
> before the tag data has been released, which could lead to incorrect
> manipulation of the ata command state.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hmmm... has this actually been observed?  All these are run under ata
port lock and so is the command issue path, so even if the tag gets
reissued, it will have to wait till the completion path is done.

Thanks.

-- 
tejun
