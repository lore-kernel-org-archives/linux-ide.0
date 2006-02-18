From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: make ata_sg_setup_one() trim zero length sg
Date: Sat, 18 Feb 2006 11:35:53 +0900
Message-ID: <43F68809.8040700@gmail.com>
References: <20060217075309.GA31835@htj.dyndns.org> <43F6416D.50807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:26804 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750715AbWBRCgF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Feb 2006 21:36:05 -0500
Received: by xproxy.gmail.com with SMTP id h30so373729wxd
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 18:36:02 -0800 (PST)
In-Reply-To: <43F6416D.50807@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> This patch makes ata_sg_setup_one() trim sg entry (thus making
>> qc->n_elem zero) if padding results in zero length sg entry.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>> Jeff, currently, in both sg_setup() and sg_setup_one() cases, zero
>> length sg entry can reach low level driver fill_sg() function which
>> could possibly cause weird problems.  This and a following patch kill
>> such cases.
> 
> 
> Can you redo this series against vanilla upstream (and/or #upstream-fixes)?
> 

Hello, Jeff.

Actually, this series is already against the vanilla upstream[1].  The 
order is...

libata: fix WARN_ON() condition in *_fill_sg() [2]
libata: make ata_sg_setup_one() trim zero length sg [3]
libata: fix qc->n_elem == 0 case handling in ata_qc_next_sg [4]

-- 
tejun

[1] f1b318793dcd2d9ff6b5ac06e7762098fa079cee
[2] http://article.gmane.org/gmane.linux.ide/8090
[3] http://article.gmane.org/gmane.linux.ide/8091
[4] http://article.gmane.org/gmane.linux.ide/8092
