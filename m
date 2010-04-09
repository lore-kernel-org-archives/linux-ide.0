From: Tim Small <tim@buttersideup.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 09 Apr 2010 17:37:44 +0100
Message-ID: <4BBF57D8.6040800@buttersideup.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br>	<4bbde1ea.c701be0a.60ec.0270@mx.google.com>	<20100408150920.5689564b@lxorguk.ukuu.org.uk>	<4bbde4f7.1702be0a.5f6c.028e@mx.google.com>	<4BBE6CA6.1010808@gmail.com>	<4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>	<n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>	<4bbe8f84.1502be0a.0f89.0f16@mx.google.com>	<o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>	<4BBEFDA1.5050607@buttersideup.com>	<z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com> <20100409160707.6116965e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecurenet.com ([63.246.152.102]:39644 "EHLO
	relay1.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392Ab0DIQhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 12:37:53 -0400
In-Reply-To: <20100409160707.6116965e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, =?ISO-8859-1?Q?D=E2niel_Frag?= =?ISO-8859-1?Q?a?= <fragabr@gmail.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> Some laptop BIOSes do try to access the controller at certain points,
>> like suspend or powerdown (presumably to make sure the drive heads are
>> unloaded or something) - we've run into problems in the past when the
>> controller was disabled at points where the BIOS didn't expect it to
>> be and it was trying to poke at it, causing a big delay until it
>> finally gave up.
>>     
>
>
> Suspend/powerdown are less of a problem because any patch to put it into
> AHCI mode should put it back as it was before during suspend/poweroff.
>   

Using DECLARE_PCI_FIXUP_SUSPEND etc?  I'll see if I can get some time to
have a go at this.  The hardware I have access to without AHCI BIOS
options are Dell Poweredge R200s and R300s.

As far as I can workout, from my experiments using setpci+fakehp two of
the port IO regions get coalesced, and an additional memory IO BAR gets
set up on the ICH9R when in AHCI mode, so I'll have to try and work out
how to handle this properly in the quirk.

As Robert said, the "off-by-default + if it breaks, you get to keep both
pieces" policy is what I had in mind, and I think this should go into
arch/x86/pci/fixup.c ?  Any obvious pit-falls to avoid?


Cheers,

Tim.
