From: "Grant Grundler" <grundler@google.com>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 09:29:55 -0700
Message-ID: <da824cf30810140929o4b82f69fs9a826ef880d3f462@mail.gmail.com>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
	 <48F3D8E2.8000006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:11754 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYJNQaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 12:30:05 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id m9EGTwAm001357
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 17:29:59 +0100
Received: from ug-out-1314.google.com (ugfk3.prod.google.com [10.66.187.3])
	by zps38.corp.google.com with ESMTP id m9EGTu9i009397
	for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 09:29:57 -0700
Received: by ug-out-1314.google.com with SMTP id k3so868477ugf.9
        for <linux-ide@vger.kernel.org>; Tue, 14 Oct 2008 09:29:56 -0700 (PDT)
In-Reply-To: <48F3D8E2.8000006@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Mon, Oct 13, 2008 at 4:25 PM, Tejun Heo <tj@kernel.org> wrote:
...
>> Tejun, what kind of throughput have you seen when you have been testing
>> the sil3132 and multipliers?
>
> That's the limit of sil3124/3132.  Dunno why but you can't go over that.

To be clear, I understood "that" ==  ~100 MB/s

>  There's 3132-2 chip on the market.  Maybe it's worth a try?

Are you possibly thinking of 3124-2 ? (4-port PCI-X device, not PCI-e)

I didn't see mention of 3132-2 on
http://www.siliconimage.com/products/product.aspx?id=32

thanks,
grant
