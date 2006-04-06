From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/8] sata_sil24: enable 64bit
Date: Fri, 7 Apr 2006 01:55:36 +0900
Message-ID: <20060406165536.GI31998@htj.dyndns.org>
References: <11442437424186-git-send-email-htejun@gmail.com> <443545CF.9020904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:46473 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932196AbWDFQzm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:55:42 -0400
Received: by zproxy.gmail.com with SMTP id o37so196059nzf
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 09:55:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <443545CF.9020904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

On Thu, Apr 06, 2006 at 12:46:07PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Enable 64bit.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> tested with >4GB of memory, or at least with addresses >4GB?
> 

No, unfortunately don't have such a machine, but I can confirm that
giving wrong upper address breaks on < 4GB machine.

-- 
tejun
