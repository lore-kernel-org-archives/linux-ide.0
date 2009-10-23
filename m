From: Tim Small <tim@seoss.co.uk>
Subject: Re: ahci timeouts, retries etc.
Date: Fri, 23 Oct 2009 12:26:57 +0100
Message-ID: <4AE19301.9000906@seoss.co.uk>
References: <4AD60194.8030106@seoss.co.uk> <4AD7C3D9.9090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:54269 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZJWLY4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 07:24:56 -0400
In-Reply-To: <4AD7C3D9.9090805@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Robert Hancock wrote:
>>
>> I'm assuming that the kernel will retry these requests after the sata
>> link has been reset?
>
> Yes.
>
>>
>> The errors appear to be randomly distributed over the four drives on
>> this machine - all are Seagate ST31000340NS with either firmware version
>> SN05 or SN16...
>
> This kind of problem often seems to be due to signal integrity or 
> power problems. For whatever reason, an insufficient power supply (or 
> something like overloading one power cable) can tend to trigger SATA 
> errors as an early symptom..

Thanks for the reply Robert...  The power (and SATA signal) delivery to 
these drives is via a hot-swap backplane which is built-into the chassis 
- I had considered some sort of hardware fault here, and that would seem 
possible, but I don't really have any way to check as I don't have 
access to another one of these machines in order to swap-out parts etc.  
IPMI info looks OK (although I realise this may not catch transient 
power problems at the drives etc.).

The timeouts appear to happen about 4 times per month.  In the absence 
of any other easy strategies, I've disabled SMART data collection on 
this machine, on the off-chance that that makes any difference....

Cheers,

Tim.
