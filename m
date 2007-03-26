From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 26 Mar 2007 13:53:11 +0800
Message-ID: <46075FC7.2050305@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <200703232313.24942.bzolnier@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:34826 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933575AbXCZFxR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Mar 2007 01:53:17 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2Q5rHf5023700
	for <linux-ide@vger.kernel.org>; Mon, 26 Mar 2007 01:53:17 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2Q5rHFB065908
	for <linux-ide@vger.kernel.org>; Sun, 25 Mar 2007 23:53:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2Q5rG3K022440
	for <linux-ide@vger.kernel.org>; Sun, 25 Mar 2007 23:53:16 -0600
In-Reply-To: <200703232313.24942.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Monday 19 March 2007, Sergei Shtylyov wrote:
> 
>>Hello.
>>
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>
>>>It seems that the drive works just fine in PIO mode with pdc202xx_new
>>>IDE driver (it doesn't support ATAPI DMA at the moment)
>>
>>    There used to be Albert's patch enabling ATAPIT DMA in this driver:
>>
>>    http://marc.info/?l=linux-ide&m=111027913608663
> 
> 
> applied

Great, thanks Bart.

> 
> 
>>Oh my, that was 2 years ago, and all slipped thru the cracks... :-)
> 
> 
> f*ck, indeed and it seems I'm to blame here... :-(
> 
> Albert, I want to apologize for losing your patch.
> 

It's nice we have the IDE maintainer back. :)

--
albert



