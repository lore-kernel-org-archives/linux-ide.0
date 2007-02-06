From: Tejun Heo <htejun@gmail.com>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Tue, 06 Feb 2007 16:34:04 +0900
Message-ID: <45C82F6C.90604@gmail.com>
References: <74342.74582.qm@web52304.mail.yahoo.com> <457E040D.2020707@gmail.com> <20070203201449.GA1222@useful.obra.se> <20070203231757.GA2035@useful.obra.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.235]:62261 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXBFHeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 02:34:09 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1811089wxd
        for <linux-ide@vger.kernel.org>; Mon, 05 Feb 2007 23:34:08 -0800 (PST)
In-Reply-To: <20070203231757.GA2035@useful.obra.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fredrik Rinnestam <fredrik@obra.se>
Cc: linux-ide@vger.kernel.org

Fredrik Rinnestam wrote:
>> I get very similar error-messages with my SiI 3512 controller. I just
>> noticed this while connecting a second drive and moving data from sdb to
>> sda. Copying stuff from the internal ide-controller (nvidia) to sda does
>> not produce any errors. I've also tried diffrent cables without any
>> luck. Kernel is 2.6.19.2
>>
> uhm, scratch that:
> 
> this is from normal operation on the second drive (fileserver):

Sorry but can't really find anything specific in your log.  Please...

1. give a host at 2.6.20.  It will give us yet more info about errors.

2. turn on "Kernel hacking -> Show timing information on printks."

3. report the result of "lspci -nn"

4. try to connect harddrives to separate power supply or use other
hardware debugging tactics.  There have been a lot of SATA bug reports
which turned out to be hardware problems.  SATA seems to be the first to
get hit when there is generic hardware problem (e.g. insufficient / bad
power supply).

Thanks.

-- 
tejun
