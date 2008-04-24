From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Thu, 24 Apr 2008 12:36:05 +0900
Message-ID: <48100025.6080402@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240351.13586.volker.armin.hemmann@tu-clausthal.de> <480FF70B.6050600@gmail.com> <200804240528.30511.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.244]:47295 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753111AbYDXDgN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 23:36:13 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1696805rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 20:36:10 -0700 (PDT)
In-Reply-To: <200804240528.30511.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> On Donnerstag, 24. April 2008, Tejun Heo wrote:
> 
>> Ah.. right.  The patch is for libata-dev#upstream branch which contains
>> ahci_enable_ahci() refactoring change.  You'll need to get the latest
>> linux-2.6 git tree which contains it.
> 
> which isn't -git4
> 
> *sigh*
> 
> then I did:
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Initialized empty Git repository in /usr/src/linux-2.6/.git/
> remote: Counting objects: 761806, done.
> remote: Compressing objects: 100% (130538/130538), done.
> remote: Total 761806 (delta 633235), reused 758782 (delta 630257)
> Receiving objects: 100% (761806/761806), 179.18 MiB | 10975 KiB/s, done.
> Resolving deltas: 100% (633235/633235), done.
> Checking out files: 100% (23886/23886), done.
> 
> cd linux-2.6
> patch -p1 < ../ahci.patch
> patching file drivers/ata/ahci.c
> Hunk #1 FAILED at 556.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej

If you can git, just do the following...

$ git fetch git://git.kernel.org//pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream:upstream
$ git checkout -f upstream
$ patch -p1 < ahci.patch

Thanks.

-- 
tejun
