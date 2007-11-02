From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: [Bug 9274] segfault after upgrade from 2.6.19.4 to 2.6.23.1
Date: Sat, 3 Nov 2007 00:54:56 +0100
Message-ID: <200711030054.56892.marogge@onlinehome.de>
References: <20071102174440.53BE210807D@picon.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64345 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbXKBXzJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 19:55:09 -0400
In-Reply-To: <20071102174440.53BE210807D@picon.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Friday 02 November 2007 18:44:40 you wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=9274
>
>
> sshtylyov@ru.mvista.com changed:
>
>            What    |Removed                     |Added
> ---------------------------------------------------------------------------
>- CC|                            |marogge@onlinehome.de
>
>
>
>
> ------- Comment #4 from sshtylyov@ru.mvista.com  2007-11-02 10:44 -------
> (In reply to comment #3)
>
> > Created an attachment (id=13381)
>
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=13381&action=view)
> [details]
>
> > Do not use MRDMODE for interrupt status on PCI-64[89]
> >
> > This is not a final patch at this point, but the one that should show us
> > whether  MRDMODE is not usable for the interrupt status despite what the
> > chip specs say...
>
> Martin, this bug looks like your report too. Please try the patch attached
> and report the result. Sorry for a long delay -- I've been busy with other
> stuff.

Hi,

I am not sure I can reply directly to bugzilla.kernel.org...

Anyway, I applied the patch to 2.6.23 (had to transcribe the last chunk 
manually). The resulting code is not pretty, but it fixes the problem. 

The debugging output shows a lot of lines ending in 

irq_stat: 0x04 mrdmode: 0x04

cu Martin

