From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia
 AHCI
Date: Tue, 15 Apr 2008 12:10:57 +0900
Message-ID: <48041CC1.1030909@gmail.com>
References: <200804092130.07149.tvrtko@ursulin.net> <480179D3.8070707@gmail.com> <200804130834.14257.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:61119 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761465AbYDODLT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 23:11:19 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1784457wff.4
        for <linux-ide@vger.kernel.org>; Mon, 14 Apr 2008 20:11:16 -0700 (PDT)
In-Reply-To: <200804130834.14257.tvrtko@ursulin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tvrtko A. Ursulin wrote:
> On Sunday 13 April 2008 04:11:15 Tejun Heo wrote:
>> Is auto spindown configured for the drive?
> 
> I don't think so - it's a 3.5" drive with no special PM features - but how to 
> tell?

Hmm... Can you please post the result of "smartctl --version" and 
"smartctl -a > out 2>&1" and dmesg after the smartctl command?

Thanks.

-- 
tejun
