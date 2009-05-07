From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 7 May 2009 14:53:15 +0100
Message-ID: <20090507145315.3e85b2a8@lxorguk.ukuu.org.uk>
References: <49CCD7C4.8000207@inov.pt>
	<49CFDD8F.1030306@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com>
	<49D0CAE4.9090306@inov.pt>
	<49D0E687.4040101@ru.mvista.com>
	<49FED069.9080501@inov.pt>
	<4A002B56.1000802@ru.mvista.com>
	<4A019BE4.9020903@inov.pt>
	<4A01C376.8000803@ru.mvista.com>
	<4A02AB9C.4050107@inov.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56070 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760790AbZEGNxU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 May 2009 09:53:20 -0400
In-Reply-To: <4A02AB9C.4050107@inov.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-14?B?Sm/jbw==?= Ramos <joao.ramos@inov.pt>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

> So you're saying I should support all PIO modes? If so, I would have to 
> make conditional code, checking perhaps a module param to sort which PIO 
> mode to use.

If you advertise PIO0-PIO4 as supported the core IDE code will do all the
work on figuring which modes are supported by the attached devices. You
just need to be able to set them.

Alan
