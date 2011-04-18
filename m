From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: libata-sff/pata_cmd64x problem with hardwired configurations
Date: Mon, 18 Apr 2011 20:16:42 +0400
Message-ID: <4DAC63EA.4000707@ru.mvista.com>
References: <1303084704.2583.23.camel@mulgrave.site>	 <4DAC0EAB.2090306@ru.mvista.com> <1303142114.7167.6.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37391 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab1DRQSh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 12:18:37 -0400
Received: by wwa36 with SMTP id 36so5869789wwa.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Apr 2011 09:18:35 -0700 (PDT)
In-Reply-To: <1303142114.7167.6.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide <linux-ide@vger.kernel.org>, 622997@bugs.debian.org

Hello.

James Bottomley wrote:

>>> I can get all of this working by fixing up all the hard coded knowledge
>>> in libata-sff only to use a single port.
>>> However, I can't fix the libata-sff driver until I know how to tell
>>> there's only one port wired.  Does anyone with cmd649 knowledge have any
>>> idea how I might tell this?

>>     The secondary port is enabled in the PCI config. space: register 0x51 bit 
>> 3 controls this. Unfortunately, pata_cmd64x driver still doesn't check the 
>> channel enable bits; the cmd64x driver does though, so it might be worth trying...

> So this is the enablebits code in driver/ide

    We still need to ensure that these are indeed the enable bits that are at 
play here...

> that's missing from any of
> the libata stuff?

    Not from any. It's handled in some drivers, like pata_hpt37x, for example -- 
in their prereset() methods.

> Should this be generic in libata-sff? ...

    There's even libata core function, pci_test_config_bits() that facilitates 
this check.

> I mean even on an x86 where arbitrary memory can be poked without consequence,
> trying to activate a disabled port will still produce lots of noise.

    The story with pata_cmd64x is somewhat convoluted: originally (when the 
libata driver was created) in the IDE driver there were only enable bits for the 
secondary channel of PCI0646 (and even those wrong); I fixed those and added the 
enable bits for other chips back in 2007 but it never got propagated to 
pata_cmd64x. Well, I have some plans for changes to this driver but not much 
time to actually do them currently...

> James

WBR, Sergei
