From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: add softreset
Date: Wed, 1 Mar 2006 14:35:43 +0900
Message-ID: <20060301053543.GB20926@htj.dyndns.org>
References: <11396427632078-git-send-email-htejun@gmail.com> <43EE72D5.1050005@pobox.com> <20060215063659.GB9621@htj.dyndns.org> <44049296.10006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:8281 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbWCAFft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 00:35:49 -0500
Received: by zproxy.gmail.com with SMTP id 13so59139nzn
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 21:35:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44049296.10006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Tue, Feb 28, 2006 at 01:12:38PM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Now that libata is smart enought to handle both soft and hard resets,
> >add softreset method.
> >
> >Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ACK, finally
> 
> (though I am dropping all your other pending patches as requested)
> 

Good, and I forgot to resend the regenerated patches after writing I
would do that ASAP.  I was about to do that but then quilt2git didn't
work and, after fixing it, I completely forgot why I fixed quilt2git
in the first place.  Duh... Will send soon.

> 
> >+	/* spec says at least 5us, but be generous and sleep for 1ms */
> >+	msleep(1);
> 
> FWIW msleep simply guarantees a minimum delay.  Depending on the 
> scheduler tick granularity, msleep(1) may delay 10-100ms.
> 
> This FWIW may or may not warrant updating the above comment, I leave it 
> up to you.
> 

I think the comment is okay as it is and, more importantly, it
wouldn't fit in one line with any more detail.  :-P

-- 
tejun
