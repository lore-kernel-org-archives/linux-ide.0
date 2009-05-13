From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 15:32:35 +0200
Message-ID: <200905131532.35154.bzolnier@gmail.com>
References: <bug-13286-11633@http.bugzilla.kernel.org/> <200905130758.n4D7wnL4014055@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61153 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZEMN2x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:28:53 -0400
Received: by fxm2 with SMTP id 2so648457fxm.37
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 06:28:53 -0700 (PDT)
In-Reply-To: <200905130758.n4D7wnL4014055@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Wednesday 13 May 2009 09:58:49 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13286
> 
> 
> 
> 
> 
> --- Comment #2 from fibre_optic@go2.pl  2009-05-13 07:58:48 ---
> "Does 2.6.27.21 use DMA?"
> 
> I will check it today evening.
> 
> "Is this system equipped with on-board IDE->CF adapter,
> or is it an add-on one?"
> 
> It is an additional hardware. The hardwer is connected to mother board (IDE
> ifc) and CF-CARD is inserted in a slot on the hardware.

Ok.

> "Does this adapter support DMA at the hardware level
> (some adapters don't have DMA lines)?"
> 
> Take a look belllow, is it what you need?
> 
> # hdparm  -i /dev/hda

We know that the device supports DMA but we don't know
about the adapter.

Unfortunately there is no software method to check it so
you need to look at PCB and verify if there are any routes
connected to pins 21 and 29 (DMARQ and -DMACK lines).
