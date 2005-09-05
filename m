From: Tejun Heo <htejun@gmail.com>
Subject: Re: [sata_sil24] v0.10 works, v0.20 doesn't
Date: Mon, 05 Sep 2005 13:22:42 +0900
Message-ID: <431BC812.5030803@gmail.com>
References: <loom.20050904T095233-120@post.gmane.org> <20050904140239.GA11855@htj.dyndns.org> <loom.20050905T024247-999@post.gmane.org> <431BC732.2010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:28052 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932196AbVIEEWt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Sep 2005 00:22:49 -0400
Received: by zproxy.gmail.com with SMTP id r28so602673nza
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 21:22:47 -0700 (PDT)
In-Reply-To: <431BC732.2010907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Marc Bevand <mb@opensc.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
  >  Okay, it seems that command is normally issued and completed.  My
> primary suspicion now is regarding memory IO mapping.
> 
>  - How much memory do you have on the system?
>  - Can you try to boot with iommu=off kernel parameter?

  Please try iommu=soft instead of off.  Sorry.

>  - Can you try to boot with x86 kernel?
> 
>  Thanks.
> 


-- 
tejun
