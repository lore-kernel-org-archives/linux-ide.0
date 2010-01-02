From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: pata_pdc202xx_old regression?
Date: Sat, 02 Jan 2010 15:15:29 -0600
Message-ID: <4B3FB771.3070701@gmail.com>
References: <19263.43745.540746.751448@jabber.grueslayer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:61540 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0ABVPc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jan 2010 16:15:32 -0500
Received: by iwn1 with SMTP id 1so10095843iwn.33
        for <linux-ide@vger.kernel.org>; Sat, 02 Jan 2010 13:15:32 -0800 (PST)
In-Reply-To: <19263.43745.540746.751448@jabber.grueslayer.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugs+linux-ide@grueslayer.com
Cc: linux-ide@vger.kernel.org

On 01/02/2010 02:21 PM, David A Sinck wrote:
>
> Greetings&  Happy New Year!
>
> I believe I've come across one of two things:
>
> a) a regression in pata_pdc202xx_old
> b) a clueless end user wrt the list :-)
>
> The short version: running Ubuntu's Jaunty release (2.6.28-17-generic
> #58-Ubuntu i686) I can cleanly access the disks hanging off of an
> onboard Promise 20265; attempting to upgrade to Ubuntu Karmic
> (presumptively 2.6.31.16.29) has numerious problems reading these same
> drives, including:
>
>    e2label: No such file or directory while trying to open /dev/sda1
>    Couldn't find a valid filesystem superblock.
>
> I've documented as much as I can think of that's relevant here:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/489685
>
> I'm willing to run tests + update the bug with further information
> ... if I knew what would be useful.
>
> It might even be solved upstream from the release Karmic's using?

That dmesg output is from the working setup, correct? Can you get any 
output from the non-working one?
