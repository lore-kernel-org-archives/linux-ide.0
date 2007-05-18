From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Fri, 18 May 2007 14:46:46 +0200
Message-ID: <464DA036.50207@gmail.com>
References: <830792.81640.qm@web52605.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:48517 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbXERMq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 May 2007 08:46:59 -0400
Received: by nz-out-0506.google.com with SMTP id r28so1315347nza
        for <linux-ide@vger.kernel.org>; Fri, 18 May 2007 05:46:58 -0700 (PDT)
In-Reply-To: <830792.81640.qm@web52605.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org

Srihari Vijayaraghavan wrote:
>>> Can the Skymaster S3132, based on Sil3132,
>>> (http://umart.net/au/product_info.php?cPath=21_211&products_id=106108) do
>> 64
>>> bit DMA on Linux?
>> Yeah, sil3124/32 can do 64bit alright.
> 
> Sorry, I couldn't quite convince myself wasting a little bit of money on that.
> Temptation is hard to resist though.
> 
>> Maybe you can cc the ATI person here if you know the address.
> 
> Will do. Need to write a good story :-).

Earlier today, ATI guy contacted me and verified that the ATA controller
is at fault not the bridge.  I'm gonna forward the patch upstream soon.

-- 
tejun
