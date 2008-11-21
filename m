From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Date: Fri, 21 Nov 2008 18:12:05 +0000
Message-ID: <20081121181205.7c9da385@lxorguk.ukuu.org.uk>
References: <49261BE5.2010406@caviumnetworks.com>
	<4926F1EB.8090506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35121 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751838AbYKUSMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 13:12:05 -0500
In-Reply-To: <4926F1EB.8090506@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>

>     About the 8-bit mode: you need to issue the Set Features command with 
> opcode 1 to enable that mode -- libata currently doesn't do that, so it won't 
> work I suppose...

That depends on the hardware interface. I have worked with at least one
board that is 8bit to the CPU for data transfers and 16bit to the disk.
Also Set Features 8bit is strictly for TrueIDE mode (see CF 4.0 spec pg
150).

Alan
