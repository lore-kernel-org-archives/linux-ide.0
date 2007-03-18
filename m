From: YUP <yupadmin@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sun, 18 Mar 2007 16:22:15 +0100
Message-ID: <45FD5927.7080104@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172107.42107.bzolnier@gmail.com> <45FD0F68.7090207@gmail.com> <200703181610.33714.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:3888 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbXCRPXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 11:23:42 -0400
Received: by nf-out-0910.google.com with SMTP id o25so785923nfa
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 08:23:40 -0700 (PDT)
In-Reply-To: <200703181610.33714.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org

Hello Bartek,

 >
 > Thanks, does reading from CD/DVD media also work fine now?

Yes, drives can read all media cd and dvd I have.


> It seems that the drive works just fine in PIO mode with pdc202xx_new
> IDE driver (it doesn't support ATAPI DMA at the moment) and fails
> with pata_pdc2027x libata (even with DMA blacklist patch from Albert).

Does it mean that I have to recompile all the time kernels from ubuntu 
repositories? Is there any possibility to blacklist pata_pdc2027x 
module and enable pdc202xx_new (just to compile one and add to the list 
of modules) ?

Wishes,

Yarema

