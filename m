From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken
 LBA48 support
Date: Fri, 29 Jun 2007 10:32:43 +0900
Message-ID: <4684613B.8080607@gmail.com>
References: <4683DCD3.1040303@gmail.com> <4683F4CD.2090106@rtr.ca> <4683F51C.3060404@garzik.org> <4683F5B1.7090507@gmail.com> <4683F626.9040401@garzik.org> <46845D2E.4050102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.237]:21183 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764132AbXF2Bcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 21:32:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so297599nze
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 18:32:49 -0700 (PDT)
In-Reply-To: <46845D2E.4050102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
> I wonder if PIO works for LBA48 on that chipset (very, *very* likely).

HOB register access doesn't work (even get native max address is broken).

> Maybe just fall back to PIO for an LBA48 drive.
> Or even better, fall back to PIO only for sectors beyond 128GB.
> 
> ???
> 
> Or wait for a more stable driver..

I don't really think the driver is useful in its current state.  Maybe
we should just mark it BROKEN.  I don't think I'm gonna work on it
without further information and initio is almost impossible to contact.

-- 
tejun
