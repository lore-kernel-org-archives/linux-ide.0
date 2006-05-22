From: Brian King <brking@us.ibm.com>
Subject: Re: libata/sas patches
Date: Mon, 22 May 2006 14:18:25 -0500
Message-ID: <44720E81.8020609@us.ibm.com>
References: <4471CC15.8000102@us.ibm.com> <4471F34F.2040600@garzik.org>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48516 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751139AbWEVTSh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2006 15:18:37 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4MJIZbL007827
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 15:18:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4MJIamQ089080
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 15:18:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4MJIZ19030636
	for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 15:18:35 -0400
In-Reply-To: <4471F34F.2040600@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Brian King wrote:
>> I just uploaded my updated libata patchset to support attaching
>> SATA devices to SAS HBAs. It's only lightly tested at this point.
>> I still need to give it another review myself and make sure
>> I'm happy with all the error cases, but the base function
>> is working for me, so I figured I'd post the link. I'll
>> hopefully submit the code to the list soon.
>>
>> http://prdownloads.sourceforge.net/iprdd/ipr-sata.tgz?download
> 
> Are you gonna be at the storage summit?  They are going to discuss 
> SAS/SATA integration there.
> 
> I won't be there, alas...

Yes. I will be there. Too bad you can't make it.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
