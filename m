From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 16 Feb 2007 16:48:36 +0800
Message-ID: <45D56FE4.3090900@tw.ibm.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com> <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:59213 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbXBPIsp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 03:48:45 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G8miFr028242
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 03:48:44 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1G8mi2e487238
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 01:48:44 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1G8miMf022007
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 01:48:44 -0700
In-Reply-To: <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrick Ale <patrick.ale@gmail.com>
Cc: linux-ide@vger.kernel.org

Patrick Ale wrote:
> Hi All,
> 
> I got asked to forward this email I sent to the lkml to here :)
> So that's what I do.
> 
> 
> The problem below exists with 2.6.20-git11 and the Jeff's libata-dev
> linus-upstream tree, which I cloned yesterday evening at the unholy
> hour of 00:10 GMT
> 
> I am not on the ide list, so if you could CC me in anything regarding
> my problem I'd be very thankfull :)
> 
> 
> I attached a complete dmesg output.
> 
> 
> Patrick
> 
> ---------- Forwarded message ----------
> From: Patrick Ale <patrick.ale@gmail.com>
> Date: Feb 15, 2007 9:52 AM
> Subject: Re: [LIBATA] drives not detected
> To: linux-kernel <linux-kernel@vger.kernel.org>
> 
> 
> On 2/15/07, Patrick Ale <patrick.ale@gmail.com> wrote:
> 
>> Good morning all,
> 
> 
>> Now, when I boot up, I miss two drives, exactly the two connected to
>> this promise card.
>> I have another onboard Promise controller which works just fine, so
>> the driver gets loaded properly, and since i see all my other disks
>> but these two I think we can rule out a misconfiguration of the kernel
>> config this time ;-)
> 
> 
> It would be nice if I'd also mention the kernel I use eh.
> It's linux-2.6-git8
> 
> 

It's strange that your on-board Promise adapter works but the add-on
adapter detects no devices.

Could you please try reloading the pata_pdc2027x driver by
"rmmod pata_pdc2027x; modprobe pata_pdc2027x" and send the dmesg.

Thanks,

Albert

