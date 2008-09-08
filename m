From: "xerces8" <xerces8@butn.net>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Mon, 08 Sep 2008 13:43:51 +0200
Message-ID: <WorldClient-F200809081343.AA43510194@butn.net>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org> <WorldClient-F200809062012.AA12270277@butn.net> <WorldClient-F200809062331.AA31030286@butn.net> <48C50E1F.9040407@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:22051 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbYIHLoF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 07:44:05 -0400
Received: from dedal.perftech.si (unknown [10.12.0.44])
	by ikar.perftech.si (Spam Firewall) with ESMTP id 96BA11DC9B4
	for <linux-ide@vger.kernel.org>; Mon,  8 Sep 2008 13:43:57 +0200 (CEST)
Received: from dedal.perftech.si ([10.12.0.44]) by ikar.perftech.si with ESMTP id UdcQS6PZUbLGppg2 for <linux-ide@vger.kernel.org>; Mon, 08 Sep 2008 13:43:57 +0200 (CEST)
Received: from WorldClient by butn.net (MDaemon PRO v9.6.4)
	with ESMTP id 57-md50000233369.msg
	for <linux-ide@vger.kernel.org>; Mon, 08 Sep 2008 13:43:53 +0200
In-Reply-To: <48C50E1F.9040407@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, stein@hermes.si

Tejun Heo wrote:

> xerces8 wrote:
> > I put more debug in the function that failed and tracked the problem down to setup_irq().
> > I also enabled CONFIG_DEBUG_SHIRQ. The kernel messages are attached.
> 
> Aieee... please disable ide-generic.

(you mean CONFIG_IDE_GENERIC, right ?)

Can you elaborate ?
Is this some bug ?

I can't just a tell distro owner to change a kernel build option
because someone told me to :-)
(remember, this is a problem with the kernel of RIPLinux, a small recovery live CD)

Regards,
David


