From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: Bug is fixed in 2.6.23.1: sata_promise: port is slow to respond,
 reset failed
Date: Mon, 15 Oct 2007 19:55:29 +0200
Message-ID: <4713A991.3030308@how.dk>
References: <200710150821.l9F8LHdS025458@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:43095 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538AbXJORzd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 13:55:33 -0400
In-Reply-To: <200710150821.l9F8LHdS025458@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hi

Mikael Pettersson wrote:
> However, I don't see how the sata_promise changes from 2.6.22 to 2.6.23
> can explain this. The only functional changes there are a critical fix
> for FastTrack TX4200 (not your card), and support for SATA hotplugging
> (not happening here).
> 
> So I'm suspecting something in libata core might have changed to fix this.
> 
> Just to make sure, what's the numerical PCI IDs for your card?

01:08.0 0180: 105a:3d17 (rev 02)
         Subsystem: 105a:3d17
         Flags: bus master, 66MHz, medium devsel, latency 72, IRQ 19
         I/O ports at a400 [size=128]
         I/O ports at a800 [size=256]
         Memory at e9024000 (32-bit, non-prefetchable) [size=4K]
         Memory at e9000000 (32-bit, non-prefetchable) [size=128K]
         [virtual] Expansion ROM at 300a0000 [disabled] [size=32K]
         Capabilities: [60] Power Management version 2


Best regards,

Peter
