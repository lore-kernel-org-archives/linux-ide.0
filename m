From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_via: add missing PM hooks
Date: Fri, 04 May 2007 15:25:55 +0200
Message-ID: <463B3463.8040705@gmail.com>
References: <e34e42440705030542r1574dfdre143e2d43edd44d6@mail.gmail.com>	 <4639F59B.1080009@gmail.com>	 <e34e42440705040122r2ec59952w2684039868808fcb@mail.gmail.com>	 <463AF6C6.1050402@gmail.com> <e34e42440705040621n5d6b8c98g84796a3ce3fcbfb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:5255 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbXEDN0H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 09:26:07 -0400
Received: by wx-out-0506.google.com with SMTP id h31so741697wxd
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 06:26:07 -0700 (PDT)
In-Reply-To: <e34e42440705040621n5d6b8c98g84796a3ce3fcbfb8@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Janssen <jeroen.janssen@gmail.com>
Cc: linux-ide@vger.kernel.org

Jeroen Janssen wrote:
> Hi,
> 
> Thanks very much! This indeed solved the problem.
> Anything I can to help get it included in the next kernel release?

Well, the mystery here is how this bit was missing so there should be no
problem including it in the next release.  I'll forward it to -stable
team too.  It's also a bit amusing to see libata EH actually recovers
from suspend without explicit resuming.  :-)

Thanks.

-- 
tejun
