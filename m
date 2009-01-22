From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2 v1] pata_via.c:  support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Fri, 23 Jan 2009 08:35:14 +0900
Message-ID: <497902B2.2050700@kernel.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB80889B843@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43362 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759456AbZAVXgn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 18:36:43 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB80889B843@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, sshtylyov@ru.mvista.com

JosephChan@via.com.tw wrote:
>>  for (config = via_isa_bridges; config->id != 
>> PCI_DEVICE_ID_VIA_ANON; config++)
>>
>> That way, you won't need any special handling and just use "UNKNOWN"
>> as the name of the wildcard entry.
>>
> 
> How about this? :) 
> I also found that if I modified to the following line.
> for (config = via_isa_bridges; config->id != PCI_DEVICE_ID_VIA_ANON; config++)
> I need to move the PCI_DEVICE_ID_VIA_ANON to the end of via_isa_bridges.
> Or the for loop will exit at 1st check.

Looks good to me.  :-)

Thanks.

-- 
tejun
