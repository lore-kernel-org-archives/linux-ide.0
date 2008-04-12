From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6 patch] make ali_atapi_dma static
Date: Sat, 12 Apr 2008 10:07:33 +0900
Message-ID: <48000B55.7040000@gmail.com>
References: <20080411172827.GC25788@cs181133002.pp.htv.fi> <20080411193608.16e7147b@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.245]:43467 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756785AbYDLBHw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 21:07:52 -0400
Received: by rv-out-0506.google.com with SMTP id k29so81207rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 18:07:51 -0700 (PDT)
In-Reply-To: <20080411193608.16e7147b@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Fri, 11 Apr 2008 20:28:27 +0300
> Adrian Bunk <bunk@kernel.org> wrote:
> 
>> This patch makes the needlessly global ali_atapi_dma static.
>>
>> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> Acked-by: Alan Cox <alan@redhat.com>

Acked-by: Tejun Heo <htejun@gmail.com>

What was I thinking?

-- 
tejun
