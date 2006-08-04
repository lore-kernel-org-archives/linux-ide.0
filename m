From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata-dev#upstream pdc_adma fails IDENTIFY w/ AC_ERR_HSM
Date: Fri, 04 Aug 2006 23:18:22 +0900
Message-ID: <44D3572E.6040907@gmail.com>
References: <44D336EE.5000907@gmail.com> <44D351F9.3070302@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:61811 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932359AbWHDOSa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Aug 2006 10:18:30 -0400
Received: by py-out-1112.google.com with SMTP id t32so324583pyc
        for <linux-ide@vger.kernel.org>; Fri, 04 Aug 2006 07:18:29 -0700 (PDT)
In-Reply-To: <44D351F9.3070302@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Mark Lord wrote:
>> I've tested both cards and cables Mark sent me (thanks!), and both 
>> show the same symptom for ATA harddisk and ATAPI cdrom, so this seems 
>> to be a driver issue.  Any ideas?
> 
> Well, ATAPI not working is no suprise -- officially that chipset doesn't
> support ATAPI (on MS Win), but it ought to be workable in PIO mode for us.

IDENTIFY_PACKET_DEVICE fails the same way as IDENTIFY_DEVICE does, so...

> But not finding the HD is more of an issue.  I wonder what motherboard/CPU
> you are trying this on, and has it *ever* worked for you Tejun?

This is P5LD2 (ICH7R) w/ P4 celeron.  The kernel was built for i386. 
This is my first time to actually try these cards.  I'm updating 
initialization, so I'm doing sweep-test on all the cards I have.  I'll 
put it into via-c3 and see what happens.  I'll also try older kernel 
before big libata EH updates.

> My newish old AMD64 box here seems to have problems with a number
> of boards, including the pdc_adma ones.  Not sure why, as the exact same
> kernels work fine with the exact same board/drives in my Intel P4 box.

I have two sil3112s whose BIOSen hang during boot if certain port (not 
sure which one) is occupied on boot.  It worked fine before on the same 
machine (again, P5LD2) but it got broken after some point.  As both 
cards show the same symptom, I'm suspecting system BIOS update is the 
trigger.  Both cards work fine if booted with no device attached and 
hotplugged later.

> Something to add to the list of things to look at, I suppose.

As we're talking about pdc_adma, when are you gonna convert it to the 
new EH?  :-)

-- 
tejun
