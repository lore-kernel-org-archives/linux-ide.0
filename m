From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Tue, 20 Mar 2007 17:07:35 +0800
Message-ID: <45FFA457.4000305@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com> <45FEE5EB.9020909@gmail.com> <45FF8CE7.4040905@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:44109 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbXCTJHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 05:07:42 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2K95xck032005
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 05:05:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2K97fL2069898
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 03:07:41 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2K97fJ3031099
	for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 03:07:41 -0600
In-Reply-To: <45FF8CE7.4040905@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Albert Lee wrote:
> YUP wrote:
> 
>>Hi Sergei, Albert and Bartek,
>>
>>Thanks for the patch. If you dealt with it, could you please apply this
>>patch to 2.6.20.3 kernel and send me diff? I'm just afraid that I
>>couldn't do it right.
>>
>>Albert and Bartek,
>>
>>please find latest dmsg output with Albert's patch. I quoted here only
>>output after the first "qc timeout" as Albert requested (see below).
>>Hope it will help you.
>>
> 
> 
> Thanks for the help. Your trace is valuable.
> It seems we have identified the cause.
> 
> The AOpen drive returned 0x51 (check condition) on INQUIRY of 254 bytes,
> and it seems to mess up when REQUEST SENSE was issued:
> 
> [  105.480046] CDB (4:0,1,0) 12 01 00 00 fe 00 00 00 00
> [  105.480101] ata4: protocol 5 task_state 4 (dev_stat 0x58) <== INQUIRY
> [  105.480551] ata4: protocol 5 task_state 1
> [  105.480555] ata4: host_stat 0x4
> [  105.480561] ata4: protocol 5 task_state 1 (dev_stat 0x51)
> [  105.480564] ata4: protocol 5 task_state 2 (dev_stat 0x51)
> [  105.480567] ata4: protocol 5 task_state 3 (dev_stat 0x51) <= check condition
> [  105.480644] ata4: protocol 5 task_state 4 (dev_stat 0x58)  <== REQUEST SENSE
> [  113.509692] ata4: protocol 5 task_state 1 <== interrupt. device BSY.
> [  113.509703] ata4: host_stat 0x0           <== device messed up
> [  113.510276] ata4: protocol 5 task_state 1
> [  113.510280] ata4: host_stat 0x0
> [  113.510890] ata4: protocol 5 task_state 1
> [  113.510894] ata4: host_stat 0x0
> [  113.512120] ata4: protocol 5 task_state 1 <== .. loop until time out
> 
> This INQUIRY problem can be reliable reproduced:

Hi Yarema,

Could you please apply the attached patch (which adds the AOpen 56X/AKH to
the BLIST_INQUIRY_36 blacklist) on top of previous patches.

(Please keep using the libata + pata_pdc2027x to drive the AOpen 56X.)

Let's see if this can fix the INQUIRY time out problem of the AOpen 56X/AKH.

--
Thanks,

Albert

--- linux-2.6.20.3/drivers/scsi/scsi_devinfo.c	2007-03-14 02:27:08.000000000 +0800
+++ linux-2.6.20.3-patch/drivers/scsi/scsi_devinfo.c	2007-03-20 16:52:29.000000000 +0800
@@ -236,6 +236,7 @@ static struct {
 	{"XYRATEX", "RS", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"Zzyzx", "RocketStor 500S", NULL, BLIST_SPARSELUN},
 	{"Zzyzx", "RocketStor 2000", NULL, BLIST_SPARSELUN},
+	{"E-IDE", "CD-ROM 56X/AKH", NULL, BLIST_INQUIRY_36},
 	{ NULL, NULL, NULL, 0 },
 };
 



