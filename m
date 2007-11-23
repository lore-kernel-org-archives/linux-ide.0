From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Lost interrupt with cmd 64x
Date: Fri, 23 Nov 2007 13:45:07 +0100
Message-ID: <200711231345.08052.bzolnier@gmail.com>
References: <BAY139-W374C1413B6CEBCB202A330A37D0@phx.gbl> <200711222312.58589.bzolnier@gmail.com> <4746BBBA.3010209@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:7137 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbXKWMhU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 07:37:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so498205ugc
        for <linux-ide@vger.kernel.org>; Fri, 23 Nov 2007 04:37:19 -0800 (PST)
In-Reply-To: <4746BBBA.3010209@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tobias Oed <tobiasoed@hotmail.com>, linux-ide@vger.kernel.org

On Friday 23 November 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > This problem should have been already fixed by:
> 
> > 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6183289cd4356b790c5eaa619020fb887ec0fa44
> 
> > which was merged into 2.6.24-rc3.
> 
>     Put your attenction at the version against which this was reported -- it's 
> eralier than when the regression was introduced.

Indeed, you are correct!

However it still would be worth to give 2.6.24-rc3 a try.

Thanks,
Bart
