From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 2 Jun 2008 13:07:01 -0400
Message-ID: <87f94c370806021007i5df45716u38f5b7ce525c03b0@mail.gmail.com>
References: <20080508161008.59361de5@appleyard>
	 <20080527143202.4bab5bf0@appleyard> <20080527225926.GE6843@mit.edu>
	 <20080527163251.04054a74@appleyard> <20080531080015.GG5405@ucw.cz>
	 <4842F5A8.9020708@garzik.org> <20080602080440.25fc663c@core>
	 <4843A4A7.3020809@garzik.org> <4843EF88.2040606@rtr.ca>
	 <48441AA6.8080704@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:45222 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbYFBRHE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 13:07:04 -0400
Received: by wx-out-0506.google.com with SMTP id h29so719325wxd.4
        for <linux-ide@vger.kernel.org>; Mon, 02 Jun 2008 10:07:02 -0700 (PDT)
In-Reply-To: <48441AA6.8080704@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 2, 2008 at 12:07 PM, Jeff Garzik <jeff@garzik.org> wrote:
> Mark Lord wrote:
>>
>> For the power-off of unused ports, the current patch still sounds
>> extremely vendor-specific (Intel).
>>
>> Does it actually work (demonstrate, please) on any other hardware ?
>
> Ding...  correct.  We need something per-port that's not Intel specific.
>
>        Jeff

But, isn't Alan correct that the new logic is useful to some and with
a simple boot option is can be used to enable / disable it.

So if it is defaulted it to disabled, and the end user is allowed to
have a boot option to enable it, you get a reasonable first step for
now.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
