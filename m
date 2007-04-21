From: "David Lebel" <lebel@lebel.org>
Subject: Re: Correct way to enable port multiplier support in kernel 2.6.20-1?
Date: Fri, 20 Apr 2007 23:19:55 -0400
Message-ID: <d03b6e70704202019gfd7a20atbd9035daacfa9e48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:32678 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbXDUDT4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2007 23:19:56 -0400
Received: by an-out-0708.google.com with SMTP id b33so1176784ana
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2007 20:19:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> I don't see any patches to get port multiplier support working for kernel 2.6.20-1 I
> recompiled the kernel manually and made sure I config'd it with everything current but it
> appears port multiplier isn't in the mainline (it still does not work). My question is, what do I > need to do to get my addonics 3726 working with kernel 2.6.20-1? I'm not a developer
> by any means and the guide on the addonics website would have worked for me but
> it is out of date.

I have a similar issue.  I'm running Ubuntu-server 7.04, with kernel
2.6.20-15 and the kernel doesn't support PMP still.  Would have love
to use an older kernel with patch sets provided by the links from
addonics, but kernel compilation didn't work. Failed somehow.

I have a Fusion 500P device (which uses a 3726 chipset), plus a
3132-based controller.

Any easy-to-use, non-developper oriented patch that could allow me to
build a kernel package that would enable PMP so I can see all 5 drives
in my library, and not only the first one?

Ciao,
  ...David

-- 
// david lebel <lebel@lebel.org>
// http://www.lebel.org/
// pgp: 3633 6999 D47E 73ED 099F  4341 08A4 8E48 EF56 61D1
