From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 16/22] libata: implement new SCR handling and port on/offline
 functions
Date: Sun, 14 May 2006 10:29:33 +0900
Message-ID: <446687FD.8070406@gmail.com>
References: <1147348791300-git-send-email-htejun@gmail.com> <44665314.4040805@pobox.com> <4466695B.4050204@gmail.com> <44668399.2060101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.200]:28375 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWENB3j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 21:29:39 -0400
Received: by wx-out-0102.google.com with SMTP id i29so351668wxd
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 18:29:39 -0700 (PDT)
In-Reply-To: <44668399.2060101@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Implement ata_scr_{valid|read|write|write_flush}() and
>>>> ata_port_{online|offline}().  These functions replace
>>>> scr_{read|write}() and sata_dev_present().
>>>>
>>>> Major difference between between the new SCR functions and the old
>>>> ones is that the new ones have a way to signal error to the caller.
>>>> This makes handling SCR-available and SCR-unavailable cases in the
>>>> same path easier.  Also, it eases later PM implementation where SCR
>>>> access can fail due to various reasons.
>>>>
>>>> ata_port_{online|offline}() functions return 1 only when they are
>>>> affirmitive of the condition.  e.g.  if SCR is unaccessible or
>>>> presence cannot be determined for other reasons, these functions
>>>> return 0.  So, ata_port_online() != !ata_port_offline().  This
>>>> distinction is useful in many exception handling cases.
>>>
>>> If its SATA-specific, it should have a "sata_" not "ata_" prefix.
>>>
>>
>> I thought about it but the 'S' in SCR stands for Serial ATA and we 
>> also need to rename all PM functions to sata_pmp_xxx() - SCR and PMP 
>> are already SATA specific.  Do you think that's the way to go?
>>
>> For ata_port_on/offline(), I think it's better to leave them alone for 
>> hotpluggable IDE hotbays with presence detection.
> 
> Yeah, I feel pretty strongly about the sata_ prefix, even for 
> port_on/offline.  The implementation is purely SATA specific.
> 
> Should that ever change for sata_port_on/offline, it then becomes 
> trivial to create a ->port_on/offline hook, and update all SATA drivers 
> to pass sata_port_on/offline to it.  IOW, I think its unlikely that 
> these functions, as implemented and used, will morph in the future from
> 
>     sata-port-on
> 
> to
> 
>     if (sata)
>         sata-port-on
>     else if (hotpluggable PATA bays)
>         bay-on

I'm more concerned with where it's used rather than how it's 
implemented.  The ata_port_on/offline(), which gets morphed into 
ata_link_on/offline() with ata_link introduction, is used throughout 
libata core layer which covers both PATA and SATA.  And I've been 
careful such that no on/off info cases are handled properly without ugly 
sata/pata test in each location.

So, my suggestion is to keep ata_port_on/offline() interface as they 
are.  If you're uncomfortable with putting SATA only implementation into 
ata_port_on/offline(), I can separate out sata_port_on/offline() and put 
sata/pata test into ata_port_on/offline().  But, if we simply rename 
them, we'll have to put sata/pata tests where those functions are used, 
which is ugly.

> Its much more likely we will create two separate functions for the 
> separate functionality.  Thus, your ata_port_on will always be SATA 
> specific, and deserving of the spiffy sata_ prefix.  And hey, we want to 
> emphasize its SATA because SATA is cooler than PATA, too.

So, the current ata_port_on/off functions can be considered as including 
both PATA and SATA implementation, where SATA implementation got 
collapsed into it because PATA implementation is trivial.

I agree with you about other functions.  SATA, cool, good.

-- 
tejun
