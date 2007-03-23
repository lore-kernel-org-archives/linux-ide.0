From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Fri, 23 Mar 2007 23:13:24 +0100
Message-ID: <200703232313.24942.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FE7DCC.3000507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:22740 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbXCWXrc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 19:47:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1161878uga
        for <linux-ide@vger.kernel.org>; Fri, 23 Mar 2007 16:47:30 -0700 (PDT)
In-Reply-To: <45FE7DCC.3000507@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: YUP <yupadmin@gmail.com>, albertl@mail.com, linux-ide@vger.kernel.org


Hi,

On Monday 19 March 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > It seems that the drive works just fine in PIO mode with pdc202xx_new
> > IDE driver (it doesn't support ATAPI DMA at the moment)
> 
>     There used to be Albert's patch enabling ATAPIT DMA in this driver:
> 
>     http://marc.info/?l=linux-ide&m=111027913608663

applied

> Oh my, that was 2 years ago, and all slipped thru the cracks... :-)

f*ck, indeed and it seems I'm to blame here... :-(

Albert, I want to apologize for losing your patch.

Bart
