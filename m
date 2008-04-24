From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Thu, 24 Apr 2008 13:01:13 +0900
Message-ID: <48100609.6000508@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240528.30511.volker.armin.hemmann@tu-clausthal.de> <48100025.6080402@gmail.com> <200804240557.42428.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:26907 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYDXEBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 00:01:22 -0400
Received: by rn-out-0910.google.com with SMTP id e11so1332423rng.17
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 21:01:19 -0700 (PDT)
In-Reply-To: <200804240557.42428.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> On Donnerstag, 24. April 2008, Tejun Heo wrote:
>> Volker Armin Hemmann wrote:
>>> On Donnerstag, 24. April 2008, Tejun Heo wrote:
>>>> Ah.. right.  The patch is for libata-dev#upstream branch which contains
>>>> ahci_enable_ahci() refactoring change.  You'll need to get the latest
>>>> linux-2.6 git tree which contains it.
>>> which isn't -git4
>>>
>>> *sigh*
>>>
>>> then I did:
>>> git clone
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>>> Initialized empty Git repository in /usr/src/linux-2.6/.git/
>>> remote: Counting objects: 761806, done.
>>> remote: Compressing objects: 100% (130538/130538), done.
>>> remote: Total 761806 (delta 633235), reused 758782 (delta 630257)
>>> Receiving objects: 100% (761806/761806), 179.18 MiB | 10975 KiB/s, done.
>>> Resolving deltas: 100% (633235/633235), done.
>>> Checking out files: 100% (23886/23886), done.
>>>
>>> cd linux-2.6
>>> patch -p1 < ../ahci.patch
>>> patching file drivers/ata/ahci.c
>>> Hunk #1 FAILED at 556.
>>> 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej
>> If you can git, just do the following...
>>
>> $ git fetch
>> git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>> upstream:upstream $ git checkout -f upstream
>> $ patch -p1 < ahci.patch
>>
>> Thanks.
> 
> that did not work:
> 
> git fetch 
> git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
> upstream:upstream

Heh... it should have been git://git.kernel.org/pub/scm... w/o the 
double slashes.  Sorry.

-- 
tejun
