From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Thu, 22 Mar 2007 14:06:18 +0800
Message-ID: <46021CDA.3070807@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com> <4600BA1C.7060300@tw.ibm.com> <4600F45C.3000303@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:42341 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965826AbXCVGGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 02:06:34 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2M66YWD027468
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 02:06:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2M66X8U069432
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 00:06:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2M66Xup018951
	for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 00:06:33 -0600
In-Reply-To: <4600F45C.3000303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>

Hi Yarema,

Thanks for the detailed log.
It looks like the bad INQUIRY command
  "CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00" (INQUIRY, length=254, EVPD=1)
is coming from the user space, not the SCSI mid-layer.

I guess two problems together caused this bug:
1. Ubuntu Linux issues an incorrect INQUIRY command to the drive.
   (Other distros seem to have the INQUIRY correct.)
2. The incorrect INQUIRY happens to cause the AOpen drive frozen.
   (The HP drive is immune from the incorrect INQUIRY command.
    "check condition" is returned for the bad INQUIRY.)

We have two possible solutions here:
a. Patch Ubuntu, such that the incorrect INQUIRY is fixed.
b. Patch kernel, such that the AOpen drives are blacklisted.
   Each INQUIRY is inspected for the blacklisted drives.
   If the INQUIRY looks wrong, the INQUIRY is rejected.

I guess a. is the preferred solution...

--
albert

