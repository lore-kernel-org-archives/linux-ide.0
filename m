From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sx8 driver
Date: Thu, 02 Mar 2006 09:44:41 -0500
Message-ID: <440704D9.5080502@pobox.com>
References: <5d96567b0603020622v5c846b0br6b634188bc14e68b@mail.gmail.com>	 <440702BB.2000707@pobox.com> <5d96567b0603020640w4a93a67bt7c5c8c3aaeb2c637@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:58299 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750729AbWCBOoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Mar 2006 09:44:44 -0500
In-Reply-To: <5d96567b0603020640w4a93a67bt7c5c8c3aaeb2c637@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Raz Ben-Jehuda(caro) wrote:
> it is in the promise we site. just google for it.
> http://www.promise.com/support/download/download2_eng.asp?productID=125&category=all&os=100

Well poke Promise to fix...  The kernel has a driver that isn't broken 
and works on all architectures.  One grep of the Promise driver for 
VIRT_TO_BUS() tells me they haven't fixed any of the bugs in there.

	Jeff



