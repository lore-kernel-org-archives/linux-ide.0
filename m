From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Tue, 10 Jul 2007 11:52:59 +0800
Message-ID: <4693029B.2070706@tw.ibm.com>
References: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:42608 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbXGJDxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 23:53:14 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6A3rDTU002494
	for <linux-ide@vger.kernel.org>; Mon, 9 Jul 2007 23:53:13 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6A3rDE1255110
	for <linux-ide@vger.kernel.org>; Mon, 9 Jul 2007 21:53:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6A3rCiA021406
	for <linux-ide@vger.kernel.org>; Mon, 9 Jul 2007 21:53:13 -0600
In-Reply-To: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, bahadir.balban@gmail.com, dwm@enoyolf.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sshtylyov@ru.mvista.com

Mikael Pettersson wrote:
> (cc:ing linuxppc-dev)
> 
> On Tue, 26 Jun 2007 13:43:15 +0800, Albert Lee wrote:
> 
>>Recently the PLL input clock of pata_pdc2027x is sometimes detected
>>higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
>>It seems sometimes the mdelay() function is not as precise as it
>>used to be. Per Alan's advice, HT or power management might affect
>>the precision of mdelay().
>>
>>This patch calls gettimeofday() to mesure the time elapsed and
>>calculate the PLL input clock accordingly.
> 
> 
> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:
> 
<snip>
> 
> In fairness, this is a slightly non-standard PowerMac G3, in that it
> has a G4 upgrade processor. The firmware doesn't recognise the CPU
> and gives some CPU core frequency-related properties too low values.
> However, the bus frequency property _is_ correct, which is what
> most or all timing stuff should be based on.
> 
> Looks like a platform bug.
> 

According to the document, do_gettimeofday() has microsecond
resolution. Since the driver calls mdelay(100) (100000 microseconds), 
it won't affect the PLL input clock calculation much if somehow
do_gettimeofday() drifts several (say 100) microseconds.

Could you please apply the attached debug patch and collect more info
on the PowerMac G3. Hopefully we can have more clue. Thanks.
--
albert

(BTW, maybe opening a bug in bugzilla.kernel.org would help the
debugging.)

--- 00_libata-dev/drivers/ata/pata_pdc2027x.c	2007-07-07 09:58:55.000000000 +0800
+++ 01_debug/drivers/ata/pata_pdc2027x.c	2007-07-10 11:18:38.000000000 +0800
@@ -722,6 +722,15 @@ static long pdc_detect_pll_input_clock(s
 	pll_clock = (start_count - end_count) / 100 *
 		(100000000 / usec_elapsed);
 
+	do_gettimeofday(&start_time);
+	mdelay(37);
+	do_gettimeofday(&end_time);
+	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
+		(end_time.tv_usec - start_time.tv_usec);
+	printk(KERN_ERR "usec_elapsed for mdelay(37) [%ld]\n", usec_elapsed);
+	printk(KERN_ERR "start time: [%ld]s [%ld]us \n", start_time.tv_sec, start_time.tv_usec);
+	printk(KERN_ERR "end   time: [%ld]s [%ld]us \n", end_time.tv_sec, end_time.tv_usec);
+
 	PDPRINTK("start[%ld] end[%ld] \n", start_count, end_count);
 	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
 


