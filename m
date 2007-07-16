From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Mon, 16 Jul 2007 17:12:25 +0800
Message-ID: <469B3679.20804@tw.ibm.com>
References: <200707111026.l6BAQ5kh003472@harpo.it.uu.se>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:44680 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760901AbXGPJMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:12:38 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6G96xKG004661
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 05:06:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6G9CbHR240078
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:12:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6G9Cam9006689
	for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 03:12:37 -0600
In-Reply-To: <200707111026.l6BAQ5kh003472@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, bahadir.balban@gmail.com, dwm@enoyolf.org, jeff@garzik.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sshtylyov@ru.mvista.com

Mikael Pettersson wrote:
> On Wed, 11 Jul 2007 10:45:35 +0800, Albert Lee wrote:
> 
>>So, it seems both mdelay(37) and do_gettimeofday() are working properly on PowerMac G3.
>>Maybe the calculated wrong PLL input is due to wrong reading of the counter register?
>>Could you please try the attached debug patch for more clue, thanks.
> 
> 
> This, supposedly debug-only, patch gives me much better PLL calibration:
> 
> pata_pdc2027x 0000:00:0e.0: version 0.9
> bccrh [0] bccrl [0]
> bccrhv[0] bccrlv[0]
> bccrh [7FCF] bccrl [15ED]
> bccrhv[7FCF] bccrlv[15D4]
> start[0] end[1072141805] 
> usec_elapsed for mdelay(100) [105500]
> start time: [1184152411]s [689475]us 
> end   time: [1184152411]s [794975]us 
> PLL input clock[-1563248254]Hz
> usec_elapsed for mdelay(37) [35432]
> start time: [1184152411]s [818033]us 
> end   time: [1184152411]s [853465]us 
> bccrh [7FC9] bccrl [1A4B]
> bccrhv[7FC9] bccrlv[1A4B]
> bccrh [7F98] bccrl [3038]
> bccrhv[7F98] bccrlv[301F]
> start[1071946315] end[1070346296] 
> usec_elapsed for mdelay(100) [103571]
> start time: [1184152411]s [874717]us 
> end   time: [1184152411]s [978288]us 
> PLL input clock[15440000]Hz
> usec_elapsed for mdelay(37) [35431]
> start time: [1184152411]s [997039]us 
> end   time: [1184152412]s [32470]us 
> pata_pdc2027x 0000:00:0e.0: PLL input clock 15440 kHz
> 
> and from then on things are fine.
> 
> Weird. I'll try with an older gcc later (been using gcc-4.2.0 so far).
> 

Is the problem reproducible with more reload loops? Maybe we could try
something like:

#!/bin/sh
while : ; do 
  rmmod pata_pdc2027x
  sleep 1
  modprobe pata_pdc2027x
done

and "tail -f /var/log/messages|grep PLL > pll_test.log" to check the
PLL clock.
--
albert

