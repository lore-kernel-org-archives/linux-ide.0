From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (pata-2.6 fix queue) cmd64x: fix primary channel address
 setup time
Date: Wed, 28 Feb 2007 16:27:16 +0300
Message-ID: <45E58334.4030506@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702280049.36593.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:15977 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932317AbXB1N1Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 08:27:24 -0500
In-Reply-To: <200702280049.36593.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

> The driver used to merge the address setup timing for the secondary channel but
> this must have been done for both channels actually despite the primary channel
> had separate registers for each drive (I'afraid that this is too common mistake
> in both hardware and software -- address setup timing must be the same accross
> an IDE channel).  Thus, do a number of changes to the program_drive_counts():

    Oops, looks like it was another mind glitch of mine and was fixing a 
non-issue -- if I just looked into the spece I would have read there that the 
hardware itself handles this for the primary channel (the question is WTF they 
didn't do the same for the secondary one?).  So, simpley disregard this patch.
I'll send the MWDMA patch soon.

MBR, Sergei
