From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Thu, 19 Aug 2010 14:05:34 -0400
Message-ID: <4C6D726E.6030709@garzik.org>
References: <20100810155559.7620.79711.stgit@localhost.localdomain> <4C6AB68D.8000102@kernel.org>	<20100817174257.3691ed68@lxorguk.ukuu.org.uk> <4C6AB919.7060203@kernel.org>	<20100817180158.179e7780@lxorguk.ukuu.org.uk> <4C6ABFFA.2000502@kernel.org>	<20100817192353.3529733c@lxorguk.ukuu.org.uk> <4C6B7B72.4090405@kernel.org>	<20100818110306.03ce2fbc@lxorguk.ukuu.org.uk> <4C6BE9C8.4030803@kernel.org>	<20100818161521.430ba361@lxorguk.ukuu.org.uk> <4C6CFB63.2070001@kernel.org> <20100819110959.40312e58@linux.intel.com> <4C6D13E2.1010703@kernel.org> <4C6D29FB.3000002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60109 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab0HSSFi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2010 14:05:38 -0400
Received: by vws3 with SMTP id 3so2079313vws.19
        for <linux-ide@vger.kernel.org>; Thu, 19 Aug 2010 11:05:38 -0700 (PDT)
In-Reply-To: <4C6D29FB.3000002@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, kay.sievers@suse.de

On 08/19/2010 08:56 AM, Tejun Heo wrote:
> Hello, again.
>
> On 08/19/2010 01:22 PM, Tejun Heo wrote:
>> On 08/19/2010 12:09 PM, Alan Cox wrote:
>>>> what if ata_piix is already compiled in or already loaded but ahci is
>>>> not for an ich6 controller?  We have priorities in the drivers, if the
>>>> user/admin wants to use the lower priority ones that much, he/she
>>>> shall.  This isn't an issue.  There's no way to hotplug intel IDEs
>>>> anyway.
>>>
>>> The PIIX4 in the IBM docking stations is hot plug - and its why I also
>>> have to check 0x40 and write it if zero. So the case exists.
>>
>> I see.  Most of the problems are solved by driver priority but yeah
>> that's an actual corner case.  Driver priority doesn't work unless all
>> the matching drivers are loaded by the time driver matching starts, so
>> the same problem could happen with pata_acpi depending on probe order
>> during normal boot, so pata_acpi should be blacklisted by default.
>
> It seems priority thing can't handle this at all.  So, to the original
> patch,
>
> Acked-by: Tejun Heo<tj@kernel.org>

Cool, though still waiting on resend to fix problems mentioned earlier 
in the thread, notably s/&&/&/

Or if Alan wants to sign-off on my doing that correction myself, since a 
resend hasn't appeared?

