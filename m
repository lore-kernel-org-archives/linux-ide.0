From: "Patrick Ale" <patrick.ale@gmail.com>
Subject: Re: Fwd: [LIBATA] drives not detected
Date: Fri, 16 Feb 2007 11:18:23 +0100
Message-ID: <8d158e1f0702160218t38a147f7i1ff5f84f9a47637c@mail.gmail.com>
References: <8d158e1f0702150048x4eb73acawc3c3b87d0d80a6d4@mail.gmail.com>
	 <8d158e1f0702150052l25fb03fnf17ba315dc6f912d@mail.gmail.com>
	 <8d158e1f0702160010k2ed986ddtaccf8d2678ae1231@mail.gmail.com>
	 <45D56FE4.3090900@tw.ibm.com>
	 <8d158e1f0702160056j11ab6df1v99b4d72866f3e1b2@mail.gmail.com>
	 <45D574B1.8080109@tw.ibm.com>
	 <8d158e1f0702160148v366ce96bm8e3ff3e7c64a7198@mail.gmail.com>
	 <45D58270.4080909@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:36026 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXBPKS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 05:18:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so97804uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 02:18:24 -0800 (PST)
In-Reply-To: <45D58270.4080909@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

> >

>
> 1. Hmm, the patch looks useless: if the port is disabled, there should
> be a error message saying "port disabled. ignoring". But we don't see such
> message. So, please disregard the patch. If you have time, please try if any
> previous kernel version like 2.6.17 to 2.6.19 works.

Yep, will do, I'm sorry I cant test it right away, but when I reboot I
get dumped into the GRUB bash shell, which is not very cool when
you're 60KM away from where the server is (at home).

>
> It seems scsi_add_host() is completed for scsi11. But the boot probe
> detects nothing. Adding Tejun to the cc list for advice.

This is actually what I find the weirdest, (not the CC-ing Tejun :P) ,
I'd expect the driver to give me the same abnormal status error it
gives me for the ports I have no drives attached to.

I'll test asap!

Patrick
