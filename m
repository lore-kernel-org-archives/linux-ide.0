From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA ACPI (was Re: Linux 2.6.21-rc5)
Date: Wed, 28 Mar 2007 18:51:05 +0900
Message-ID: <460A3A89.2050809@gmail.com>
References: <Pine.LNX.4.64.0703251559560.6730@woody.linux-foundation.org> <4608B0CA.1040005@garzik.org> <4608B1A2.3040305@gmail.com> <20070327213200.GA5842@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:63624 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbXC1JvL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Mar 2007 05:51:11 -0400
Received: by nz-out-0506.google.com with SMTP id s1so2720418nze
        for <linux-ide@vger.kernel.org>; Wed, 28 Mar 2007 02:51:10 -0700 (PDT)
In-Reply-To: <20070327213200.GA5842@ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Pavel Machek wrote:
> Hi!
> 
>>>> So if you have reported a regression in the 2.6.21-rc 
>>>> series, please check 2.6.21-rc5, and update your 
>>>> report as appropriate (whether fixed or "still 
>>>> problems with xyzzy").
>>> [just got back from vacation, or would have sent this 
>>> earlier]
>>>
>>> FWIW, I'm still leaning towards disabling libata ACPI 
>>> support by default for 2.6.21.
>>>
>>> Upstream has Alan's fix for the worst PATA problems, 
>>> but for different reasons, I think PATA ACPI and SATA 
>>> ACPI support in libata does not feel quite ready for 
>>> prime time in 2.6.21.
>>>
>>> Scream now, or hold your peace until 2.6.22... :)
>> I second disabling ACPI for 2.6.21.
> 
> Ugh.. does that mean we'll have 'regression reports' as in 'it worked
> ok in -rc5, broken in final?
> 
> Well, suspend is currently so broken that we'll be flooded by reports,
> anyway, but.... could we get at least define in code so that we can
> tell users to flip it?

Just the default value for libata.noacpi is changed to 1, so user can
easily reenable it by passing boot/module parameter.

-- 
tejun
