From: Tejun Heo <htejun@gmail.com>
Subject: Re: Serial ATA does not find partitions (Hitachi HD, new? ATI controller)
 where old SATA works
Date: Thu, 04 Oct 2007 11:14:04 +0900
Message-ID: <47044C6C.5030905@gmail.com>
References: <46FC4384.7080607@df.uba.ar> <46FCCD57.2020507@gmail.com> <47014740.5080002@df.uba.ar> <4701EA71.2000609@gmail.com> <470220FE.2090506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:9281 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbXJDCOM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 22:14:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so24477wah
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 19:14:11 -0700 (PDT)
In-Reply-To: <470220FE.2090506@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hgsolari@gmail.com, solari@df.uba.ar
Cc: linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

Hernan G Solari wrote:
>>>   netconsole, pritty nice debunging system... but (yes, there is always
>>> a but) it does not get to run.
>>>   the method was well implemented, adding the acpi=off it sends the
>>> information to the receiving machine (I can even see passing a
>>> netconsole probing message in the machine under testing), but without
>>> turning off acpi it does not reach the point of loading and,
>>> consequently, it does not send a byte to the receiving machine.
>>>
>>> Hence, result: empty output.
>>>    
>>>
>> Hmmm.. Are netconsole support and network driver built into the kernel?
>>
> yes, they are

If you can set up a serial console, it would be better.  If not, can you
please take a photo of the crash and post it?

-- 
tejun
