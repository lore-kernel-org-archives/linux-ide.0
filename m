From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] libata: only call ->done once all per-tag
	ressources are released
Date: Mon, 5 Oct 2015 08:01:17 +0200
Message-ID: <20151005060117.GA2294@lst.de>
References: <1443892871-10413-1-git-send-email-hch@lst.de> <1443892871-10413-2-git-send-email-hch@lst.de> <20151004173429.GD19652@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:52546 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbbJEGBT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Oct 2015 02:01:19 -0400
Content-Disposition: inline
In-Reply-To: <20151004173429.GD19652@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org

On Sun, Oct 04, 2015 at 01:34:29PM -0400, Tejun Heo wrote:
> Hmmm... has this actually been observed?  All these are run under ata
> port lock and so is the command issue path, so even if the tag gets
> reissued, it will have to wait till the completion path is done.

No - I stumbled over this while trying to debug
https://lkml.org/lkml/2015/6/25/620 (which could use some libata experience,
btw), but it didn't help.  I still would like to see it fixes as similar
patterns in SCSI drivers have caused crashes.
