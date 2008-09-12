From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Laptop shock detection and harddisk protection
Date: Fri, 12 Sep 2008 15:28:49 +0200
Message-ID: <E1Ke8hd-0001TE-TN@be1.7eggert.dyndns.org>
References: <baBmH-48R-17@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:55770 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751676AbYILNUb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Sep 2008 09:20:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, multinymous@gmail.com, Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/

Tejun Heo <tj@kernel.org> wrote:

> 1. How should the shock interface look like?  As we're gonna need
>    userland daemon one way or the other, we can use the userland
>    daemon to glue all the interfaces but it would be much better to
>    have a unified interface.  Although there seem to be several
>    different variants, they don't differ all that much and creating a
>    new interface every time is painful.  I think we can get by with a
>    sysfs interface with notification.

It should provide a connection to the corresponding device. Imagine an USB
case having a sensor, being connected to a desktop system. You would want
to exactly protect the enclosed USB device, and possibly non-protected USB
devices, too, but not halt the internal disks.

