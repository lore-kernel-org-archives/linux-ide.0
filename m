From: Felix Domke <tmbinc@elitedvb.net>
Subject: Re: [patch 5/7] xenon: add SATA support
Date: Wed, 07 Mar 2007 22:07:17 +0100
Message-ID: <45EF2985.1020407@elitedvb.net>
References: <20070307180144.812594000@elitedvb.net>> <20070307180526.194853000@elitedvb.net>> <45EF285C.1090800@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.multimedia-labs.de ([82.149.226.172]:46214 "EHLO
	mail.multimedia-labs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965672AbXCGVc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 16:32:59 -0500
In-Reply-To: <45EF285C.1090800@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Linuxppc-dev@ozlabs.org, Linux IDE <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
> Felix Domke wrote:
>> This adds support for the HDD and DVD SATA controller on the xenon
>> southbridge.
>   Pleas post this to linux-ide@vger.kernel.org in the future.
I'll do.

>> It also disables ATA_TFLAG_POLLING in libata-core, which prevented the
>> DVD drive
>> from being detected. It needs to be investigated what exactly is wrong
>> here. 

>>      tf.protocol = ATA_PROT_PIO;
>> -    tf.flags |= ATA_TFLAG_POLLING; /* for polling presence detection */
>> +//    tf.flags |= ATA_TFLAG_POLLING; /* for polling presence
>> detection */
>    I doubt that this could *ever* get accepted.
It was not meant to be accepted, but to work around the problem which
was introduced in 2.6.19. I have far too less knowledge of the SATA
layer to understand why this flag exactly causes the detection of the
DVD-Drive fail.

As said, this needs to be investigated, and fixed (in the driver, of
course, not in the subsystem).

>> +static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned
>> int sc_reg, int device)
>> +{
>> +    unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
>> +
>    Why we need device and port_no arguments here?
As there is only one device/port per PCI device, the arguments should
probably be removed from this function, right.

>> +    if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
>> +        return 0; /* assume no error */
>    Since SCR_ERROR == 1, this check seems broken.
Why?


Felix
