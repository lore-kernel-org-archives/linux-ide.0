From: Tejun Heo <htejun@gmail.com>
Subject: Re: Strange arbitrary port resets on ICH9R with Seagate drives
Date: Sat, 20 Oct 2007 11:25:42 +0900
Message-ID: <47196726.8@gmail.com>
References: <op.tzhs1xqexci36i@akima.lan> <op.tzjpvoqnxci36i@akima.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:42120 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXJTCZs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 22:25:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so624500rvb
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 19:25:47 -0700 (PDT)
In-Reply-To: <op.tzjpvoqnxci36i@akima.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bell <doggs.lay.eggs@googlemail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jonathan Bell wrote:
> On Mon, 01 Oct 2007 01:30:59 +0100, Jonathan Bell 
> <doggs.lay.eggs@googlemail.com> wrote:
> 
>> Hello
>>
>> I've just purchased a brand spanking new G33/ICH9R based system for 
>> use as a home fileserver with 4x ST3750840AS Seagate SATA drives as 
>> the main grunt drives.
>>
>> The problem is that all of the seagate drives keep resetting, as this 
>> dmesg excerpt shows:
> 
> Oops. Hardware problem. Insufficient power applied to the hotswap caddy 
> resulted in the drives bugging out when all 4 were accessed, hence 
> cat/dd on an individual drive caused no problems.
> 
> Now running these drives quite successfully in raid-5 with NCQ and 
> 3.0Gbps links.

Yeah, this kind of problem is pretty common and difficult to debug.  It 
just seems SATA link is very sensitive to power quality and sucky power 
supplies are easy to come by.

-- 
tejun
