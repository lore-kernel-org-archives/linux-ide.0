From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: Kernel 2.6.37 erroneously limiting to UDMA/33
Date: Fri, 07 Jan 2011 06:31:41 -0600
Message-ID: <4D2707AD.1060406@hardwarefreak.com>
References: <4D24B98D.6080307@earthlink.net> <4D2503B1.4080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:55093 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab1AGMbm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 07:31:42 -0500
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id 7C4B46C11C
	for <linux-ide@vger.kernel.org>; Fri,  7 Jan 2011 06:31:41 -0600 (CST)
In-Reply-To: <4D2503B1.4080500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Robert Hancock put forth on 1/5/2011 5:50 PM:
> (CCing linux-ide)
> 
> On 01/05/2011 12:33 PM, Stephen Clark wrote:
>> Hello,
>>
>> Why is the kernel limiting me to udma/33 when the device says it can do
>> ata2.01: CFA: TRANSCEND, 20070831, max UDMA/66
>>
>> There is no cable the compact flash is a socket on the motherboard!

Make and model of the motherboard?  Is it possible the trace layout
between the CF socket and the IDE chip on that board doesn't actually
support UDMA/66, due to noise, cross talk, etc, thus the omission of the
pin 34 connection?  If we assume the board designer did his job
correctly, that pin 34 no-connect is there for a reason, and limiting
you to UDMA/33 was also done for a reason.  Most board designers don't
just forget specs, or throw them out the window on a whim.  The pin 34
no-connect was very likely intentional.

> The kernel has no way to know that, and presumably the board isn't
> connecting the signal for IDE pin 34 to ground in order to properly
> signal that an 80-wire cable (or equivalent) is connected so that speeds
> over UDMA33 can be used.
> 
> You should be able to use the libata.force=80c option on the kernel
> command line to override the cable detection.

Stephen, you may want to absolutely verify the board supports UDMA/66 on
that CF socket before forcing it as to avoid possible data corruption, etc.

Something you didn't note in your original post is whether UDMA/66
worked with this mobo/cf slot with older kernels, or if the problem
magically appeared with 2.6.37.  If the latter, forcing UDMA/66 should
obviously be ok.

-- 
Stan
