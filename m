From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Sun, 11 Feb 2007 17:03:11 -0800
Message-ID: <45CFBCCF.8090605@gmail.com>
References: <74342.74582.qm@web52304.mail.yahoo.com> <457E040D.2020707@gmail.com> <20070203201449.GA1222@useful.obra.se> <20070203231757.GA2035@useful.obra.se> <45C82F6C.90604@gmail.com> <20070206175541.GA20533@useful.obra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:6277 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933044AbXBLGpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 01:45:09 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1586039wra
        for <linux-ide@vger.kernel.org>; Sun, 11 Feb 2007 22:45:08 -0800 (PST)
In-Reply-To: <20070206175541.GA20533@useful.obra.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fredrik Rinnestam <fredrik@obra.se>
Cc: linux-ide@vger.kernel.org

Fredrik Rinnestam wrote:
>> Sorry but can't really find anything specific in your log.  Please...
>>
>> 1. give a host at 2.6.20.  It will give us yet more info about errors.
>>
>> 2. turn on "Kernel hacking -> Show timing information on printks."
>>
>> 3. report the result of "lspci -nn"
>>
>> 4. try to connect harddrives to separate power supply or use other
>> hardware debugging tactics.  There have been a lot of SATA bug reports
>> which turned out to be hardware problems.  SATA seems to be the first to
>> get hit when there is generic hardware problem (e.g. insufficient / bad
>> power supply).
>>
> 
> I replaced the SiL card with a Promise SATA 300 TX4 - no errors.
> 
> I plugged the SiL card in another computer and managed to produce the
> same errors.

It just seems you have a bad controller.  Time for RMA?

-- 
tejun

