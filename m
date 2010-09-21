From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: ahci rmmodable and shouldn't
Date: Tue, 21 Sep 2010 10:14:28 +0400
Message-ID: <4C984D44.1080109@msgid.tls.msk.ru>
References: <201009162256.04765.pedrogfrancisco@gmail.com> <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net> <4C933A8F.2080305@gmail.com> <1284892106.2650.4.camel@sundae-v2> <4C9602E4.4090007@gmail.com> <1284974726.11757.9.camel@sundae-v2> <4C9729D7.70500@gmail.com>  <4C972C60.8010506@gmail.com> <1285015465.26023.10.camel@sundae-v2> <4C97DB80.4060403@gmail.com> <4C97DBE2.8070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:35009 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab0IUGOa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Sep 2010 02:14:30 -0400
In-Reply-To: <4C97DBE2.8070707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Pedro Francisco <pedrogfrancisco@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

21.09.2010 02:10, Tejun Heo wrote:
> On 09/21/2010 12:09 AM, Tejun Heo wrote:
>> Hello,
>>
>> On 09/20/2010 10:44 PM, Pedro Francisco wrote:
>>> To which tree shall I apply it? It currently fails both on Linus'
>>> linux-2.6 and
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git .
>>
>> Hmm... weird.  It's against Linus' tree.  Checking, yeap, it applies
>> cleanly to 2.6.36-rc4, commit 2422084a (Merge branch 'for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha-2.6).
> 
> Attaching the patch just in case.

I tried it on 2.6.35 kernel.  The ahci module usage count now
increases and decreases properly, at least from what I see here.
That's definitely better than previous 2.6.35 variant.

Thanks!

/mjt

