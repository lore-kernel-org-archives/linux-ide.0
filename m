From: Tejun Heo <htejun@gmail.com>
Subject: Re: possibility to merge via_pata fixes to .19 stable series?
Date: Sun, 19 Nov 2006 14:34:52 +0900
Message-ID: <455FECFC.9070302@gmail.com>
References: <200611180759.34622.t.powa@gmx.de>	<20061118002357.564dbb9d.akpm@osdl.org>	<455F790C.2030509@garzik.org>	<20061118224334.72e3685c@localhost.localdomain> <20061118190720.4498d14e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:38590 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756428AbWKSFfG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Nov 2006 00:35:06 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1881742nfa
        for <linux-ide@vger.kernel.org>; Sat, 18 Nov 2006 21:35:05 -0800 (PST)
In-Reply-To: <20061118190720.4498d14e.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Tobias Powalowski <t.powa@gmx.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, matthieu castet <castet.matthieu@free.fr>

Andrew Morton wrote:
> On Sat, 18 Nov 2006 22:43:34 +0000
> Alan <alan@lxorguk.ukuu.org.uk> wrote:
> 
>> On Sat, 18 Nov 2006 16:20:12 -0500
>> Jeff Garzik <jeff@garzik.org> wrote:
>>>> I don't know if they're still concerns, nor if they're fatal concerns
>>>> either.  But I've been sitting on that patch for nearly five months.
>>> This isn't driver-specific, so a similar change should be applied to the 
>>> core.
>> Agreed - it belongs in the core code. We see the same problem on multiple
>> controllers and its one of the big things that at the moment makes it
>> impossible to progress the PATA drivers further.
> 
> A five month stall of a patch which makes the difference betweem "working"
> and "not working" sounds pretty serious.
> 
> Is this something someone is working on?  If not, is it something which
> Matthieu might have time to look into (please?)

Doing SETXFER via polling is proposed as solution and verfivied by Matthieu.

http://thread.gmane.org/gmane.linux.ide/13248/focus=13248

The patch has been updated and re-submitted a few days ago.

http://thread.gmane.org/gmane.linux.ide/14088/focus=14088

-- 
tejun
