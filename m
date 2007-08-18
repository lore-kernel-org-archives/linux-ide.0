From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/8] alim15x3: PIO fallback fix
Date: Sat, 18 Aug 2007 17:50:06 +0400
Message-ID: <46C6F90E.203@ru.mvista.com>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56980 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751033AbXHRNrm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Aug 2007 09:47:42 -0400
In-Reply-To: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] alim15x3: PIO fallback fix

> If DMA tuning fails always set the best PIO mode.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    Oh, it's belated now. :-/
    BTW, I'm going to hack on this driver since I've acquired a board with 
M1543C chip (that one for which there was an urgent bug that I had to fix some 
weeks ago :-)...

MBR, Seregi
