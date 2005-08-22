From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata:upstream] fix atapi_packet_task vs. intr race (take
 2)
Date: Mon, 22 Aug 2005 16:06:36 +0900
Message-ID: <4309797C.8050004@gmail.com>
References: <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com> <20050822035956.GB28721@htj.dyndns.org> <43095156.7080500@pobox.com> <20050822055924.GA32362@htj.dyndns.org> <430976B1.5070007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:46218 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751469AbVHVWe0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:34:26 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.207])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M77kRp032501
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 00:07:47 -0700
Received: by rproxy.gmail.com with SMTP id i8so903198rne
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 00:06:41 -0700 (PDT)
In-Reply-To: <430976B1.5070007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  Hello, Jeff.
>>
>>  Here's the updated patch.  Though I have a question.  Why always use
> 
> 
> Looks OK to me.  Have you tested it?  :)
> 

  Yes, I've tested both normal and error cases.  I don't get assertion 
failures anymore with ongoing disk traffic.

  Thanks.

-- 
tejun
