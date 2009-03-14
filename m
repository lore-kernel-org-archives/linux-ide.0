From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Sat, 14 Mar 2009 10:48:13 +0000
Message-ID: <20090314104813.5b479747@lxorguk.ukuu.org.uk>
References: <20090313074120.48682.qmail@web4108.mail.ogk.yahoo.co.jp>
	<49BA7172.80908@gmail.com>
	<A88EBC06918A4B0789B55D31ECDAF1BB@DIAMOND8600>
	<49BB1341.2020203@gmail.com>
	<20090314084827.2f2b05c2@lxorguk.ukuu.org.uk>
	<078E30E4A81049A2847E24B3CF39BB5C@DIAMOND8600>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60348 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751654AbZCNKr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 06:47:57 -0400
In-Reply-To: <078E30E4A81049A2847E24B3CF39BB5C@DIAMOND8600>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Norman Diamond <n0diamond@yahoo.co.jp>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jim Paris <jim@jtan.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>

> That doesn't explain why ide0=noprobe ide1=noprobe hda=none hdb=none 
> hdc=none hdd=none still didn't stop the old IDE layer from grabbing 
> something.  ATA didn't report whether there was something it couldn't grab 
> onto, all it did was report loading and that was the end of it.

It doesn't report that case because that case is considered quite normal
and in addition the probing is handled by the PCI core so it would have
to make a real effort to do so.

As to why ide0=noprobe doesn't work you'd have to ask the IDE folks but
it used to be the case that didn't deal with PCI devices just legacy
