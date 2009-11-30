From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata PM question
Date: Mon, 30 Nov 2009 13:25:43 +1100
Message-ID: <1259547943.2076.50.camel@pasglop>
References: <1259547765.2076.48.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58109 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbZK3C0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Nov 2009 21:26:23 -0500
In-Reply-To: <1259547765.2076.48.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Mon, 2009-11-30 at 13:22 +1100, Benjamin Herrenschmidt wrote:
> Hi there !
> 
> So I (finally !) resumed work on pata_macio.c to replace ide/pmac.c :-)
> 
> I've started looking at the suspend/resume stuff. It looks like most of
> it just comes for free thanks to libata, yay ! :-)

 .../...

Oh, another question... where do we spin the disk down & park it on
suspend ? I'm missed at least that part :-)

Cheers,
Ben

