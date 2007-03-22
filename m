From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 22 Mar 2007 16:09:53 +0900
Message-ID: <46022BC1.70602@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com> <4600BA1C.7060300@tw.ibm.com> <4600F45C.3000303@gmail.com> <46021CDA.3070807@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:10112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXCVHKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 03:10:00 -0400
Received: by ug-out-1314.google.com with SMTP id 44so603105uga
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 00:09:59 -0700 (PDT)
In-Reply-To: <46021CDA.3070807@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: YUP <yupadmin@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>

Albert Lee wrote:
> Hi Yarema,
> 
> Thanks for the detailed log.
> It looks like the bad INQUIRY command
>   "CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00" (INQUIRY, length=254, EVPD=1)
> is coming from the user space, not the SCSI mid-layer.
> 
> I guess two problems together caused this bug:
> 1. Ubuntu Linux issues an incorrect INQUIRY command to the drive.
>    (Other distros seem to have the INQUIRY correct.)
> 2. The incorrect INQUIRY happens to cause the AOpen drive frozen.
>    (The HP drive is immune from the incorrect INQUIRY command.
>     "check condition" is returned for the bad INQUIRY.)
> 
> We have two possible solutions here:
> a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
> b. Patch kernel, such that the AOpen drives are blacklisted.
>    Each INQUIRY is inspected for the blacklisted drives.
>    If the INQUIRY looks wrong, the INQUIRY is rejected.
> 
> I guess a. is the preferred solution...

I second Albert's opinion.  Please report this to ubuntu people so that
the origin of the problem can be fixed.

Thanks a lot.  I admire your ability and patience in tracking these
difficult issues.  :-)

-- 
tejun
