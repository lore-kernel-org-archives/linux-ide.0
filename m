From: Martin Rogge <marogge@onlinehome.de>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Sun, 21 Oct 2007 22:55:49 +0200
Message-ID: <200710212255.50123.marogge@onlinehome.de>
References: <200710142211.03382.marogge@onlinehome.de> <200710200109.58872.marogge@onlinehome.de> <471A36DC.4040509@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:65106 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbXJUU4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2007 16:56:32 -0400
In-Reply-To: <471A36DC.4040509@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On Saturday 20 October 2007 19:11:56 Sergei Shtylyov wrote:
>     What I don't like is that both PIIX4 and PCI-648 are sharing IRQ15
> (PIIX4 is in legacy mode, so it uses edge-triggered IRQ15 which is not
> shareable). You don't have drives connected to PIIX4, do you?  However, it
> doesn't look like a glitch on IRQ15, it looks like MRDMODE reg. doesn't
> work as documented...

Well, don't worry too much about the PIIX device. I have disabled it in the 
BIOS, and I haven't compiled the driver into the kernel. The IRQ sharing 
hasn't troubled any linux version yet, nor any OS from the other side.

MOst likely you're on the right track with the mrdmode register.

cu Martin
