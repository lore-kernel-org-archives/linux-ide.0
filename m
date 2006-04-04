From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata/sata status on ich[?]
Date: Tue, 04 Apr 2006 19:56:17 +0900
Message-ID: <443250D1.3020403@gmail.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it> <44323C24.4010402@garzik.org> <44323DE9.7030106@gmail.com> <443241F4.7080801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.192]:50374 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751851AbWDDK4X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Apr 2006 06:56:23 -0400
Received: by xproxy.gmail.com with SMTP id t10so958518wxc
        for <linux-ide@vger.kernel.org>; Tue, 04 Apr 2006 03:56:22 -0700 (PDT)
In-Reply-To: <443241F4.7080801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mauro Tassinari <mtassinari@cmanet.it>, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This should be fixed by the ata_piix map patch I've submitted and is 
>> currently in #upstream. [ P0 P1 P2 P3 ] should be [ P0 P2 P1 P3 ].
> 
> If you are referring to this fix:
> 
>> commit 79ea24e72e59b5f0951483cc4f357afe9bf7ff89
>> Author: Tejun Heo <htejun@gmail.com>
>> Date:   Fri Mar 31 20:01:50 2006 +0900
>>
>>     [PATCH] ata_piix: fix ich6/m_map_db
> 
> then its already in linux-2.6.git, and 2.6.17-rc1.
> 

Yeap, that one.  I'm very sure 2.6.17-rc1 fixes the problem then.

-- 
tejun
