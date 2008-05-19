From: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:46:51 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04690276@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com> <4831ECF0.5090101@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690239@ismail.innsys.innovsys.com> <4831F364.8020702@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:29238 "EHLO
	mail.innovsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751873AbYESVqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 17:46:30 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4831F364.8020702@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Scott Wood wrote:
> Try calling irq_set_chip_and_handler() with handle_level_irq, rather
> than irq_set_chip().  The -rt patch doesn't seem to have threadified
>   the __do_IRQ() path.

The demuxer is setting itself up with set_irq_chained handler(), any
pointers on how to change to irq_set_chip_and_handler()?
