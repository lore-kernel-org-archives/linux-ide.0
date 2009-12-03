From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 17:08:21 -0500
Message-ID: <4B1836D5.9010502@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912031339.14440.bzolnier@gmail.com> <4B17FB37.2030501@garzik.org> <200912032045.48728.bzolnier@gmail.com> <4B182A9F.5090708@garzik.org> <4B18357E.9050900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:37176 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbZLCWIW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 17:08:22 -0500
In-Reply-To: <4B18357E.9050900@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 05:02 PM, Sergei Shtylyov wrote:
> Hello.
>
> Jeff Garzik wrote:
>
>>> pata_efar: MWDMA0 is unsupported
>>
>> skipped, pending discussion (just sent email)
>
> There's basically nothing to discuss -- the PIIX like chips don't
> support MWDMA0 (with an acceptable cycle length, if at all, anyway). The
> way the driver is written, MWDMA0 is simply programmed overclocked.
>
>>
>>> pata_hpt3x2n: fix overclocked MWDMA0 timing
>>
>> skipped, pending discussion (just sent email)
>
>
> Nothing to discuss either, this looks like a single digit typo to me...
>
>>
>>> pata_hpt3x3: Power Management fix
>>
>> applied, on a hope and a prayer (did not see this posted to mailing
>> list?).
>
> http://marc.info/?l=linux-ide&m=125916980522990

Yeah, missed that.  Bart provided a link, too.


>>> pata_it8213: MWDMA0 is unsupported
>>
>> skipped, pending discussion (just sent email)
>
> Nothing to discuss...

Perhaps discuss was the wrong word.  After reviewing each thread, in 
each case, it remained unclear whether the original patch was correct or 
not, especially since the docs seemed to list MWDMA0 as supported on 
PIIX-like chips.

Thanks for going over these, that should clear up my confusion.

	Jeff



