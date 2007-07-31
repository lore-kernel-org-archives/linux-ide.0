From: Tejun Heo <htejun@gmail.com>
Subject: Re: errors on shutdown with PMP
Date: Tue, 31 Jul 2007 13:32:49 +0900
Message-ID: <46AEBB71.9040003@gmail.com>
References: <200707272153.l6RLrE5r007622@outgoing-alum.mit.edu> <46AAF12F.9020301@gmail.com> <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:19337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968127AbXGaEc4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 00:32:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1975532wah
        for <linux-ide@vger.kernel.org>; Mon, 30 Jul 2007 21:32:56 -0700 (PDT)
In-Reply-To: <200707310341.l6V3ex5r011162@outgoing-alum.mit.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bejarano <beej@alum.mit.edu>
Cc: linux-ide@vger.kernel.org

Marc Bejarano wrote:
> At 03:33 7/28/2007, Tejun Heo wrote:
>>Device times out write.
> 
> odd that it would be able to be part of an lv's filesystem that had
> hundreds of gigabytes recently written to it and then choke on flushing
> during shutdown.
> 
>>And then never comes back.
> 
> asleep at the wheel ;)
> 
>>Please post the result of 'smartctl -a /dev/sdX' where sdX is the device
>>which went offline.
> 
> i suppose i should have seen that coming.  here you go:
> ===
> [root@dell ~]# /usr/local/sbin/smartctl -a /dev/sdc
> smartctl version 5.37 [x86_64-unknown-linux-gnu] Copyright (C) 2002-6
> Bruce Allen
> Home page is http://smartmontools.sourceforge.net/
> 
> === START OF INFORMATION SECTION ===
> Model Family:     Seagate Barracuda 7200.10 family
> Device Model:     ST3750640AS
[--snip--]
> ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     
> UPDATED  WHEN_FAILED RAW_VALUE
>   1 Raw_Read_Error_Rate     0x000f   090   079   006    Pre-fail  Always
>      -       66902364
>   5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  Always
>      -       31
>   7 Seek_Error_Rate         0x000f   081   060   030    Pre-fail  Always
>      -       146651228
> 195 Hardware_ECC_Recovered  0x001a   056   049   000    Old_age   Always
>      -       102514302
> 198 Offline_Uncorrectable   0x0010   099   099   000    Old_age  
> Offline      -       40

Counters don't look too friendly.  Do you happen to have another drive
of the same model?  If so, can you post smartctl -a of the drive?

-- 
tejun
