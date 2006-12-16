From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [-mm patch] drivers/ide/pci/tc86c001.c: make a function static
Date: Sat, 16 Dec 2006 14:18:13 +0000
Message-ID: <20061216141813.16233431@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061216135650.GA3388@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51915 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932408AbWLPOOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Dec 2006 09:14:42 -0500
In-Reply-To: <20061216135650.GA3388@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

> I'm not sure whether it'd be a good idea to include such a driver for 
> the legacy IDE subsystem without a libata based driver for the same 
> hardware.

It would be nice to have a libata driver but having the hardware
supported is far better than no support at all.
