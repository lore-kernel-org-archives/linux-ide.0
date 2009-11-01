From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: Does ICH9M support eSATA Port Multiplier?
Date: Sun, 01 Nov 2009 21:34:09 +0100
Message-ID: <4AEDF0C1.5030905@aon.at>
References: <4AE9EEA3.1040404@aon.at> <4AEA2D16.50701@gmail.com> <4AEB6458.20401@aon.at> <4AEC6DA5.9090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from WARSL404PIP3.highway.telekom.at ([195.3.96.115]:64845 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752265AbZKAUeJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 Nov 2009 15:34:09 -0500
Received: from 212-183-98-186.adsl.highway.telekom.at (HELO [192.168.0.102]) ([212.183.98.186])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub97.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 1 Nov 2009 20:34:09 -0000
In-Reply-To: <4AEC6DA5.9090603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 10/30/2009 04:10 PM, Peter Klotz wrote:
>> Robert Hancock wrote:
>>>> Can I enable it somehow maybe by using a module option?
>>>
>>> No module parameter for that, you'd have to hack the code in ahci.c to
>>> force the option on. No guarantees it's going to work if the
>>> controller doesn't report the capability, though.
>>
>> Could you please give me a hint what to change in ahci.c?
>>
>> I would like to try and see what happens.
> 
> Based on the version in Linus' git, you'd likely want to add to 
> ahci_save_initial_config something like:
> 
> cap |= HOST_CAP_PMP;
> 
>>
>> Could such a hack damage the hardware?
> 
> Not likely. It's not impossible that data loss could result though, 
> better back up important files first..

Thanks a lot. I had already prepared the kernel, then I found the Intel 
datasheet, which states that ICH9 does not support port multipliers.

http://www.intel.com/assets/pdf/datasheet/316972.pdf

Regards, Peter.
