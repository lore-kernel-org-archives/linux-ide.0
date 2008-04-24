From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ahci: retry enabling AHCI a few times before spitting
 out WARN_ON()
Date: Thu, 24 Apr 2008 11:57:15 +0900
Message-ID: <480FF70B.6050600@gmail.com>
References: <480F231A.7020401@gmail.com> <200804240224.09518.volker.armin.hemmann@tu-clausthal.de> <480FE3BA.9020508@gmail.com> <200804240351.13586.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:7179 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbYDXC5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2008 22:57:25 -0400
Received: by an-out-0708.google.com with SMTP id d31so781200and.103
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 19:57:25 -0700 (PDT)
In-Reply-To: <200804240351.13586.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Volker Armin Hemmann <volker.armin.hemmann@tu-clausthal.de>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Peer Chen <pchen@nvidia.com>

Volker Armin Hemmann wrote:
> On Donnerstag, 24. April 2008, Tejun Heo wrote:
>> Volker Armin Hemmann wrote:
>>> Hi,
>>>
>>> patch -p1 <  ../ahci.patch
>>> patching file drivers/ata/ahci.c
>>> Hunk #1 FAILED at 556.
>>> 1 out of 1 hunk FAILED -- saving rejects to file drivers/ata/ahci.c.rej
>> Have you backed out the original patch?  It works fine here.
> 
> I removed the whole directory and installed the sources (with emerge 
> vanilla-sources).
>  After the failed attempt  I removed it again and unpacked the tarball - same 
> result.
> 
> I copied the text from kmail into nano and kedit - and both produced identical 
> patch files. If it is some whitespace damage, it should still apply, correct?

Ah.. right.  The patch is for libata-dev#upstream branch which contains 
ahci_enable_ahci() refactoring change.  You'll need to get the latest 
linux-2.6 git tree which contains it.

-- 
tejun
