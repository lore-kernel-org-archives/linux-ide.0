From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 23 Mar 2007 11:40:36 +0800
Message-ID: <46034C34.5000602@tw.ibm.com>
References: <45F873AC.6010204@gmail.com>	<200703172107.42107.bzolnier@gmail.com>	<45FD0F68.7090207@gmail.com>	<200703181610.33714.bzolnier@gmail.com>	<45FE7DCC.3000507@ru.mvista.com>	<45FEE5EB.9020909@gmail.com>	<4600BA1C.7060300@tw.ibm.com>	<4600F45C.3000303@gmail.com>	<46021CDA.3070807@tw.ibm.com> <20070322123729.14f11b96@lxorguk.ukuu.org.uk>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:36613 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422664AbXCWDkn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 23:40:43 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2N3ehmi030622
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 23:40:43 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2N3eg32064174
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 21:40:42 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2N3efBf027546
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 21:40:42 -0600
In-Reply-To: <20070322123729.14f11b96@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: albertl@mail.com, YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, dougg@torque.net

Alan Cox wrote:
>>We have two possible solutions here:
>>a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
>>b. Patch kernel, such that the AOpen drives are blacklisted.
>>   Each INQUIRY is inspected for the blacklisted drives.
>>   If the INQUIRY looks wrong, the INQUIRY is rejected.
>>
>>I guess a. is the preferred solution...
> 
> 
> We have two problems here
> 
> #1 Ubuntu got the inquiry command wrong
> 
> #2 Until now we considered "INQUIRY" a safe command for SG_IO passthrough.
> 
> We can't really take INQUIRY out of SG_IO so do we decide its the
> hardware vendors problem or do something cleverer in the filters ?
> 

Maybe the SG_IO author has better idea (ccing Doug)?

BTW, in addition to the AOpen "INQUIRY with EVPD" problem, we have
another imperfect ATAPI drive (TORiSAN) that freezes when "READ >= 128KB".
(http://bugzilla.kernel.org/show_bug.cgi?id=6710)

We can limit "dev->max_sectors" to workaround the TORiSAN problem.
But I don't know whether "dev->max_sectors" also works for SG_IO?
If no, some user space application, unaware of the problem,
might send a "correct" READ that locks the drive completely.

--
albert






