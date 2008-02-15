From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [PATCH 09/11] ata: fix sparse warning in pata_marvell.c
Date: Fri, 15 Feb 2008 15:29:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802151528240.30301@fbirervta.pbzchgretzou.qr>
References: <3ad7c41048d88a3f8aad098570b9fac9ff719aff.1202965399.git.harvey.harrison@gmail.com>
 <1202966069.2748.25.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:36478 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757100AbYBOO3a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 09:29:30 -0500
In-Reply-To: <1202966069.2748.25.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>


On Feb 13 2008 21:14, Harvey Harrison wrote:
>drivers/ata/pata_marvell.c:88:2: warning: returning void-valued expression

This is interesting. Why did not gcc warn us about this?

(foo.c:3: warning: "return" with a value, in function returning void)

