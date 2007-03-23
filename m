From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 23 Mar 2007 11:21:01 +0800
Message-ID: <4603479D.9070803@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com> <4600BA1C.7060300@tw.ibm.com> <4600F45C.3000303@gmail.com> <46021CDA.3070807@tw.ibm.com> <4602979F.80002@ru.mvista.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:54576 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422659AbXCWDVb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 23:21:31 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2N3LUrA015927
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 23:21:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2N3LUjg045378
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 21:21:30 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2N3LTQb030175
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 21:21:30 -0600
In-Reply-To: <4602979F.80002@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: albertl@mail.com, YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>

Sergei Shtylyov wrote:
> Hello.
> 
> Albert Lee wrote:
> 
>> Thanks for the detailed log.
>> It looks like the bad INQUIRY command
>>   "CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00" (INQUIRY, length=254,
>> EVPD=1)
>> is coming from the user space, not the SCSI mid-layer.
> 
> 
>> I guess two problems together caused this bug:
>> 1. Ubuntu Linux issues an incorrect INQUIRY command to the drive.
>>    (Other distros seem to have the INQUIRY correct.)
> 
> 
>    But what is incorrect about sending INQUIRY with EVPD bit?

Nothing wrong from the SCSI point of view.
However, in the early ATAPI spec (sff-8020i), this EVPD bit is
"reserved". And apprently some imperfect ATAPI CD-ROM drive doesn't
handle it well when EVPD = 1. :(

Hmm, how about the revised version:
1. Ubuntu Linux issues a correct INQUIRY command to the drive
   which set EVPD = 1. However, EVPD is "reserved" per early ATAPI
   spec and the AOpen 56X/AKH drive times out in this case.
   ...

--
albert



