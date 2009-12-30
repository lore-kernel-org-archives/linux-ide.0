From: "werner" <w.landgraf@ru.ru>
Subject: Fwd: the biggest regression at all
Date: Wed, 30 Dec 2009 01:35:05 -0400
Message-ID: <web-126022622@zbackend1.aha.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_===126022622====zbackend1.aha.ru===_"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zfrontend2.aha.ru ([195.2.83.148]:58480 "EHLO aha.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751510AbZL3GfL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Dec 2009 01:35:11 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mmarek@suse.cz, linux-ide@vger.kernel.org

This is a multi-part MIME message

--_===126022622====zbackend1.aha.ru===_
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Content-Transfer-Encoding: 8bit

"werner" <w.landgraf@ru.ru>


   --- the forwarded message follows ---
---
Professional hosting for everyone - http://www.host.ru

--_===126022622====zbackend1.aha.ru===_
Content-Type: message/rfc822

Return-Path: <rjw@sisk.pl>
X-Spam-Flag: NO
Received: from [62.113.100.74] (HELO izenguard-zmail-1.zenon.net)
  by zfrontend1.aha.ru (CommuniGate Pro SMTP 4.3.12)
  with ESMTP id 124302235 for w.landgraf@ru.ru; Wed, 30 Dec 2009 01:34:48 +0300
Received: from izenguard-zmail-1.zenon.net (localhost [127.0.0.1])
	by izenguard-zmail-1.zenon.net (Postfix) with SMTP id EF6621756
	for <w.landgraf@ru.ru>; Wed, 30 Dec 2009 01:34:48 +0300 (MSK)
Received: from zfrontend1.aha.ru (zfrontend1.aha.ru [195.2.83.147])
	by izenguard-zmail-1.zenon.net (Postfix) with ESMTP id C1E621759
	for <w.landgraf@ru.ru>; Wed, 30 Dec 2009 01:34:48 +0300 (MSK)
Received: from zfrontend1.aha.ru (zfrontend1.aha.ru [195.2.83.147])
	by zfrontend1.aha.ru (Postfix) with ESMTP id BE6775563
	for <w.landgraf@ru.ru>; Wed, 30 Dec 2009 01:34:48 +0300 (MSK)
X-iZenGuard: ZMAIL
Received: from ogre.sisk.pl ([217.79.144.158] verified)
  by zfrontend1.aha.ru (CommuniGate Pro SMTP 4.3.12)
  with ESMTP id 124302258 for w.landgraf@ru.ru; Wed, 30 Dec 2009 01:34:48 +0300
Received-SPF: none
 receiver=zfrontend1.aha.ru; client-ip=217.79.144.158; envelope-from=rjw@sisk.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 7FE4616BA11
	for <w.landgraf@ru.ru>; Tue, 29 Dec 2009 23:31:26 +0100 (CET)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 16295-10 for <w.landgraf@ru.ru>; Tue, 29 Dec 2009 23:31:19 +0100 (CET)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 7A1FC167DA4
	for <w.landgraf@ru.ru>; Tue, 29 Dec 2009 23:31:19 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "werner" <w.landgraf@ru.ru>
Subject: Re: the biggest regression at all
Date: Tue, 29 Dec 2009 23:35:10 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.33-rc2-tst; KDE/4.3.3; x86_64; ; )
References: <LptzGUUXbTK.A.MSF.ymhOLB@chimera> <200912292153.32853.rjw@sisk.pl> <web-125862914@zbackend1.aha.ru>
In-Reply-To: <web-125862914@zbackend1.aha.ru>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912292335.10178.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
X-iZenGuard-Host: izenguard-zmail-1.zenon.net
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Wed Dec 30 01:34:48 2009
X-DSPAM-Confidence: 0.9992
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 103265,4b3a8408543481716141

Hi,

First of all, I'm not the right person to report these problems to.

On Tuesday 29 December 2009, werner wrote:
> It's very important your work to collect regressions. 
> Because in the last months accumulate more and more 
> regressions, which gave on more and more computers 
> (especially, laptops) problems.
> 
> There continues two problems which I reported earlier, and 
> which are big problems, making impossible the instalation 
> of new Linux kernels on a good part of laptops, but which 
> were ignored or even negated, anyway not resolved.
> 
> / The earlier hda=scsi command line parameter don't work 
> more correctly or perhaps was substituted (I dont know 
> exactly, because the kernel command line parameter list is 
> obsolete, too).   Anyway, there are laptops, whose IDE 
> devices during booting is reclamed as ocupied, without 
> end.  After some minutes the boot process cancel this and 
> continues, however without assign the device as detected. 
> Then booting fails because the disk and the system isn't 
> found.
> 
> The only manner how I found to get detected the IDE device 
> is with pci=off (I tried plenty other things).  But then 
> other things like sound, grafics etc are not detected (and 
> lspci don't give output) and the system works only in text 
> mode.
> 
> For my opinion, the best solution is to introduce an 
> option pci=noide, so that only the IDE devices will be 
> excluded and then detected or taken over by the BIOS. All 
> other things should be detected normally.

The issue above should better be reported to the people on
linux-ide@vger.kernel.org , as no one else really can take care of it.

Still, I think there's a known way to solve this problem, since I've never
seen it myself and I happen to install Linux quite often on notebooks.

What distribution do you use?

> / When I compile the kernel with a machine with more than 
> 4 GB memory (my big computer has 8 GB) then during 
> makemenuconfig I dont can switch off HIGHMEN64 and PAE . 
> Even when before in config I edit them as not set, then 
> they are setted automatically.
> 
> This is a very serios problem, because this means that 
> kernels compiled on machines with more than 4 GB, always 
> works only on PAE machines, but not on older machines.
> 
> Generally, I suggest to change the kernel makeconfig 
> routine, in the sense that one ALWAYS can switch on or off 
> any configuration but that then all necessary dependencies 
> are switched on/off automatically too. At least this 
> config manner should be alternatively.   Otherwhise often 
> one cannot switch on or of certain parameters which one 
> inconditionally need.

I _think_ the problem is that one option (or more) in your config selects
the HIGHMEM64.  As I told you previously, I've never seen this problem myself,
most likely because I've been building kernels on 64-bit machines for quite
some time now.

Nevertheless, you can report it to Michal Marek <mmarek@suse.cz>, who's our
new kbuild maintainer.

Rafael



--_===126022622====zbackend1.aha.ru===_--
