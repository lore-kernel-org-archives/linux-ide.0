From: "Shane McDonald" <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] Resurrect IT8172 IDE controller driver
Date: Wed, 3 Dec 2008 21:08:30 -0600
Message-ID: <b2b2f2320812031908se18efdft1a94cb2b158f540e@mail.gmail.com>
References: <E1L4UpB-0007ro-1g@localhost> <492A8306.9000400@ru.mvista.com>
	 <492A9A1F.50401@ru.mvista.com>
	 <20081124123231.555f2395@lxorguk.ukuu.org.uk>
	 <492AAE6C.7000103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:47310 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbYLDDIc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2008 22:08:32 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1622857yxm.1
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 19:08:31 -0800 (PST)
In-Reply-To: <492AAE6C.7000103@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Nov 24, 2008 at 7:38 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Alan Cox wrote:
>
>>>>  It's 240, not 242 ns as 33 is actually 33.333.
>
>>>  The maximum values give cycle time of 480 ns menaing that the controller
>>> doesn't support PIO mode 0. Hm...
>
>> Even if you clear the enable for the timing register ?
>
>   These fast timing bits are documented as reserved.

The spec says that PIO mode 0 is supported, but Sergei is correct --
the maximum values give a cycle time of 480 ns.  How can this be?  The
old driver appeared to have tried to support PIO mode 0 by setting to
the maximum.

  Which fast timing bits are documented as reserved?  My spec has the
IDE Drive 0/1 Recovery Time and IDE Drive 0/1 Pulse Width bits in it.
Are there other timing bits that aren't documented in my spec?

  Please excuse my dumb question -- I'm a little over my head here.

>> Alan
>
> MBR, Sergei

Shane
