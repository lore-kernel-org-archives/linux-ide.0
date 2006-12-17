From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
Date: Sun, 17 Dec 2006 23:52:30 +0300
Message-ID: <4585AE0E.4000607@ru.mvista.com>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216135650.GA3388@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:42839 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbWLQUvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2006 15:51:05 -0500
In-Reply-To: <20061216135650.GA3388@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Adrian Bunk wrote:

> This patch makes the needlessly global init_hwif_tc86c001() static.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

    If this patch hasn't been accepted by Andrew yet, could you add another 
fixlet: init_chipset_tc86c001() should've been __devinit.  If not or it's 
already accepted, I'll post the patchlet myself later...

WBR, Sergei
