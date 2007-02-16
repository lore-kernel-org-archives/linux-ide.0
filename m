From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 16 Feb 2007 17:09:05 +0800
Message-ID: <45D574B1.8080109@tw.ibm.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>	 <45D56FE4.3090900@tw.ibm.com> <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:38693 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966248AbXBPJJK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 04:09:10 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G999F1025733
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 04:09:09 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1G9992Q486006
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 02:09:09 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1G9996d026880
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 02:09:09 -0700
In-Reply-To: <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: linux-ide@vger.kernel.org

Patrick Ale wrote:
> On 2/16/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> :
> 
>> It's strange that your on-board Promise adapter works but the add-on
>> adapter detects no devices.
>>
>> Could you please try reloading the pata_pdc2027x driver by
>> "rmmod pata_pdc2027x; modprobe pata_pdc2027x" and send the dmesg.
> 
> 
> Ofcourse I can :)
> 
> The output is attached as dmesg-reprobe.txt
> 
> Maybe this it totaly unrelated, but I remember that in the IDE drivers
> there was an option to force the card online, even when the BIOS was
> disabled. I *do* see the drives being detected and it tells me the
> BIOS is installed on boot time, but you never know :)
> 
> The controller with problems is scsi11 if I see correctly. Since on
> that channel no disks are attached and no "abnormal status" is
> outputted, you do see this "error" twice tho, since i have nothing
> connected to the secundary channel on both controllers.
> 
> 

Maybe the Promise BIOS set the adapter as disabled...
Could you please try the attached patch?

--
albert

--- linux-2.6.20-git11/drivers/ata/pata_pdc2027x.c~	2007-02-16 13:35:31.000000000 +0800
+++ linux-2.6.20-git11/drivers/ata/pata_pdc2027x.c	2007-02-16 17:02:02.000000000 +0800
@@ -315,8 +315,8 @@ static inline int pdc2027x_port_enabled(
 static int pdc2027x_prereset(struct ata_port *ap)
 {
 	/* Check whether port enabled */
-	if (!pdc2027x_port_enabled(ap))
-		return -ENOENT;
+	//if (!pdc2027x_port_enabled(ap))
+		//return -ENOENT;
 	pdc2027x_cbl_detect(ap);
 	return ata_std_prereset(ap);
 }

