From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ICH10 not working with AHCI kernel option
Date: Fri, 9 Apr 2010 17:04:32 -0600
Message-ID: <n2o51f3faa71004091604w91e65e58m3ed972ac10226f1a@mail.gmail.com>
References: <eo2197-4lb.ln1@tux.abusar.org.br> <4BBE6CA6.1010808@gmail.com>
	 <4bbe8a6a.8602be0a.7951.0fb8@mx.google.com>
	 <n2x51f3faa71004081909la494824ds60fcb5d26b53027a@mail.gmail.com>
	 <4bbe8f84.1502be0a.0f89.0f16@mx.google.com>
	 <o2i51f3faa71004081952s68d4861w28b9b73da284c91d@mail.gmail.com>
	 <4BBEFDA1.5050607@buttersideup.com>
	 <z2x51f3faa71004090747n908c389ez17cba33301c4c998@mail.gmail.com>
	 <20100409160707.6116965e@lxorguk.ukuu.org.uk>
	 <4BBF57D8.6040800@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:38419 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0DIXJu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Apr 2010 19:09:50 -0400
Received: by yxe1 with SMTP id 1so1599158yxe.33
        for <linux-ide@vger.kernel.org>; Fri, 09 Apr 2010 16:09:50 -0700 (PDT)
In-Reply-To: <4BBF57D8.6040800@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, =?ISO-8859-1?Q?D=E2niel_Fraga?= <fragabr@gmail.com>, linux-ide@vger.kernel.org

On Fri, Apr 9, 2010 at 10:37 AM, Tim Small <tim@buttersideup.com> wrote=
:
> Alan Cox wrote:
>>> Some laptop BIOSes do try to access the controller at certain point=
s,
>>> like suspend or powerdown (presumably to make sure the drive heads =
are
>>> unloaded or something) - we've run into problems in the past when t=
he
>>> controller was disabled at points where the BIOS didn't expect it t=
o
>>> be and it was trying to poke at it, causing a big delay until it
>>> finally gave up.
>>>
>>
>>
>> Suspend/powerdown are less of a problem because any patch to put it =
into
>> AHCI mode should put it back as it was before during suspend/powerof=
f.
>>
>
> Using DECLARE_PCI_FIXUP_SUSPEND etc? =A0I'll see if I can get some ti=
me to
> have a go at this. =A0The hardware I have access to without AHCI BIOS
> options are Dell Poweredge R200s and R300s.

Yeah, you'll really want to enable AHCI mode in the header stage on
boot and on resume, and disable it on suspend and shutdown (not sure
if we actually have a hook for the shutdown case?)

>
> As far as I can workout, from my experiments using setpci+fakehp two =
of
> the port IO regions get coalesced, and an additional memory IO BAR ge=
ts
> set up on the ICH9R when in AHCI mode, so I'll have to try and work o=
ut
> how to handle this properly in the quirk.
>
> As Robert said, the "off-by-default + if it breaks, you get to keep b=
oth
> pieces" policy is what I had in mind, and I think this should go into
> arch/x86/pci/fixup.c ? =A0Any obvious pit-falls to avoid?

We seem to have most related quirks for this in drivers/pci/quirks.c,
but I guess it could go into either..
