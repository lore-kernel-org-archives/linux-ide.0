From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13286] dma_timer_expiry: DMA status (0x21)
Date: Wed, 13 May 2009 13:28:55 GMT
Message-ID: <200905131328.n4DDSt3T009249@demeter.kernel.org>
References: <bug-13286-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36705 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbZEMN2z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:28:55 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4DDStOC009250
	for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 13:28:55 GMT
In-Reply-To: <bug-13286-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13286





--- Comment #3 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-13 13:28:55 ---
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

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
