From: Tejun Heo <htejun@gmail.com>
Subject: Re: Is the SIL 3112 capable of PMP support?
Date: Mon, 13 Nov 2006 23:03:40 +0900
Message-ID: <45587B3C.3080303@gmail.com>
References: <455810BC.6090304@wasp.net.au> <45587548.7020808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:44411 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754662AbWKMODu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Nov 2006 09:03:50 -0500
Received: by wr-out-0506.google.com with SMTP id i28so472878wra
        for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 06:03:50 -0800 (PST)
In-Reply-To: <45587548.7020808@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Brad Campbell wrote:
>> I've been planning on doing some testing with PMP's and noticed that 
>> sata_sil does not support PMP. Is that a hardware limitation or just 
>> that nobody has implemented it in the driver yet ?
> 
> Well, it doesn't support hardware context switching.  It probably 
> supports PMP "the slow way" (one PMP-attached device at a time)

I doubt 3112 can do pmp even "the slow way".  It doesn't expose FIS 
interface nor does it have PMP field in its SControl register.  It just 
can't generate PMP-aware FIS.

-- 
tejun
