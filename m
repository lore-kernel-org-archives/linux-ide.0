From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sis: missing PM support
Date: Wed, 1 Jan 2014 16:40:08 -0500
Message-ID: <20140101214008.GC11501@htj.dyndns.org>
References: <20140101213924.19334.8990.stgit@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:62138 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbaAAVkN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jan 2014 16:40:13 -0500
Received: by mail-qe0-f44.google.com with SMTP id nd7so13776618qeb.31
        for <linux-ide@vger.kernel.org>; Wed, 01 Jan 2014 13:40:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140101213924.19334.8990.stgit@alan.etchedpixels.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Wed, Jan 01, 2014 at 09:39:31PM +0000, Alan wrote:
> sata_sis has no suspend/resume methods. The default ones will do fine and
> are needed on some systems.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Applied to libata/for-3.13-fixes.

Thanks.

-- 
tejun
