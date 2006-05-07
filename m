From: Tejun Heo <htejun@gmail.com>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 07 May 2006 21:20:43 +0900
Message-ID: <445DE61B.5060201@gmail.com>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>	<445D6298.7090003@gmail.com> <20060507140443.7ae89a68.moe@lunar-linux.org> <445DE54B.4000609@vip.cybercity.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:9123 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932133AbWEGMVM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 08:21:12 -0400
Received: by nz-out-0102.google.com with SMTP id 13so997827nzn
        for <linux-ide@vger.kernel.org>; Sun, 07 May 2006 05:21:12 -0700 (PDT)
In-Reply-To: <445DE54B.4000609@vip.cybercity.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mogensv@vip.cybercity.dk
Cc: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org

Mogens Valentin wrote:
> Moritz Heiber wrote:
>> On Sun, 07 May 2006 11:59:36 +0900
>> Tejun Heo <htejun@gmail.com> wrote:
>>
>>> More info can be obtained by printing SCR_CONTROL, just print the
>>> result of scr_read(ap, SCR_CONTROL) from
>>> libata.c::sata_print_link_status(), which prints the SStatus value.
>>
>>
>> I'm going to try to follow that lead. There doesn't seem to be any sort
>> of tool or application that runs the exact same test yet, is there?
>> hdparm fails on me.
> 
> You might want to take a look at Douglas Gilbert's sdparm.
> 

Unfortunately, PHY spd setting is currently not exported to user space 
in anyway.  So, sdparm won't be of much use for this.

-- 
tejun
