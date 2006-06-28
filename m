From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets case,
 take #3
Date: Wed, 28 Jun 2006 19:42:17 +0900
Message-ID: <44A25D09.4060705@gmail.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com> <20060612140538.GA3892@htj.dyndns.org> <44A25979.3020709@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:26966 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423267AbWF1KmA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 06:42:00 -0400
Received: by wr-out-0506.google.com with SMTP id i24so372587wra
        for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 03:41:59 -0700 (PDT)
In-Reply-To: <44A25979.3020709@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian King <brking@us.ibm.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Unicorn Chang <uchang@tw.ibm.com>

Albert Lee wrote:
> Hmm, the current patch looks more like a temporary solution. The legacy mode
> ATA_HOST_SIMPLEX host_set->flags could be assigned to both legacy ports.
> In the long term, have one host_set for both legacy ports
> instead of two host_sets for both legacy ports can fix the problem.
> 
> A patch was submitted by Unicorn, but it looks not good/elegant enough. :(
> It will be nice if you have plan for furthur legacy two host_sets case fixes...

Hello, Albert.

Yeap, this host_set->next thing is a temporary solution and we need to 
handle legacy ports in one host_set.  I've seen Unicorn's patches.  I 
agree that those are in the right direction but we seem to need more 
clean up in driver initialization code.  I'll look into it once the next 
iteration of PMP patches are finished.

Thanks.

-- 
tejun
