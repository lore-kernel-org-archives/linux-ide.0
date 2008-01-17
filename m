From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: sata_mv oops on module removal
Date: Thu, 17 Jan 2008 18:03:22 +0100
Message-ID: <478F8A5A.3030003@wpkg.org>
References: <478F5F1C.80608@wpkg.org> <478F6DB5.4080308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:34720 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbYAQRD3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 12:03:29 -0500
In-Reply-To: <478F6DB5.4080308@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Mark Lord schrieb:
> Tomasz Chmielewski wrote:
>> This is what happened when I tried to remove sata_mv module:
>>
>>
>> ACPI: PCI interrupt for device 0000:01:00.0 disabled
>> BUG: unable to handle kernel paging request at virtual address e0122028
>>  printing eip:
>> e0015599
>> *pde = 1f557067
>> *pte = 00000000
>> Oops: 0000 [#1]
>> Modules linked in: cpufreq_ondemand p4_clockmod speedstep_lib 
>> iscsi_scst crc32c libcrc32c scst_vdisk scst bonding dm_mirror 
>> dm_snapshot sata_mv
>> CPU:    0
>> EIP:    0060:[<e0015599>]    Not tainted VLI
>> EFLAGS: 00010046   (2.6.23.14-N5200-3 #8)
                        ^^^^^^^^^

> You did not say which exact kernel version this is from.
> A bug just like this was fixed not long ago.

It's 2.6.23.14.
I didn't find anything similar.
Am I looking wrong, or was it a fix for 2.6.24?


-- 
Tomasz Chmielewski
http://wpkg.org
