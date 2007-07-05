From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Thu, 05 Jul 2007 11:38:46 +0900
Message-ID: <468C59B6.1030502@gmail.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com> <20070703222205.GA18532@electric-eye.fr.zoreil.com> <468B3126.3080706@gmail.com> <468B3452.6040509@gmail.com> <20070704185936.GA13212@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:65358 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbXGECiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 22:38:52 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3446923wah
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 19:38:51 -0700 (PDT)
In-Reply-To: <20070704185936.GA13212@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Francois Romieu wrote:
> Tejun Heo <htejun@gmail.com> :
>> Tejun Heo wrote:
>>> Francois Romieu wrote:
>>>> I have rebuilt on top of 872aad45d6174570dd2e1defc3efee50f2cfcc72 and it
>>>> still seems bizarre:
>> Okay, 872aad45 doesn't have the patch yet.  Either apply the patch
>> manually or you need to wait a bit more.
> 
> I am confused. 4031826b3ca40982880f6b9f2282c7d7fad60d77 appears in the log:
> Author: Tejun Heo <htejun@gmail.com>                                            
> Date:   Tue Jul 3 01:38:47 2007 +0900                                           
>                                                                                 
>     libata: fix assigned IRQ reporting                                          

Apparently, I'm more confused than you are.  My "master" was at 872aad45
but my index was at rc7.  Can you please force checkout the head and
re-test?  I've tested both native and legacy modes and it's fixed here.

Thanks.

-- 
tejun
