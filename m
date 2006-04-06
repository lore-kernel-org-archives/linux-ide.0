From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/8] sata_sil24: fix on-memory structure byteorder
Date: Fri, 7 Apr 2006 01:56:52 +0900
Message-ID: <20060406165652.GJ31998@htj.dyndns.org>
References: <11442437422203-git-send-email-htejun@gmail.com> <443545FB.2080300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.177]:41868 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbWDFQ46 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:56:58 -0400
Received: by pproxy.gmail.com with SMTP id f28so219800pyf
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 09:56:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <443545FB.2080300@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

On Thu, Apr 06, 2006 at 12:46:51PM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Data structures residing on memory and fetched by the controller
> >should have LE ordering.  Fix it.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Do you have access to a big endian machine to test this?
> 

No, unfortunately not. :(  It's obviously broken though.

-- 
tejun
