From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
Date: Sun, 17 Dec 2006 21:08:43 +0300
Message-ID: <458587AB.5000108@ru.mvista.com>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216135650.GA3388@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:42439 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932232AbWLQSHR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2006 13:07:17 -0500
In-Reply-To: <20061216135650.GA3388@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Adrian Bunk wrote:

>>+toshiba-tc86c001-ide-driver-take-2.patch

> This patch makes the needlessly global init_hwif_tc86c001() static.

    Duh, I hoped tha this driver may get into 2.6.20-rc1 and finally 
overlooked this. Sigh, uou won't believe how much time this driver rewrite 
spent in an unfinished state in my internal tree... :-/

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> BTW:
> I'm not sure whether it'd be a good idea to include such a driver for 
> the legacy IDE subsystem without a libata based driver for the same 
> hardware.

    Well, I'd agree with Alan here. Don't expect me to convert this to libata 
in the foreseeable future... I'd like to join the folks hacking on libata but 
this certainly won't happen soon (if at all)...

WBR, Sergei
