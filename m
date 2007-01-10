From: Michael Bueker <m.bueker@berlin.de>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 23:32:22 +0100
Message-ID: <45A56976.10208@berlin.de>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com> <45A435A3.2020506@berlin.de> <45A4DAED.9070404@ru.mvista.com> <45A51259.2020904@berlin.de> <45A52228.1020803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sour.ops.eusc.inter.net ([84.23.254.154]:62827 "EHLO
	sour.ops.eusc.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965158AbXAJWdB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2007 17:33:01 -0500
In-Reply-To: <45A52228.1020803@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Jeff Garzik wrote:
> Does the libata driver work?

Nope. There's no verbose error messages, but the kernel dies about where 
the controller is addressed.

~Mik

-- 
So, how can you tell me you're lonely?
And say that you don't have no life?
Let me take you by the hand and show you all the geeks of London
I'll show you something to make you change your mind!
