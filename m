From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: timeout problems on onboard SATA 6.0 controller on Asus P7H57D-V
 EVO
Date: Sun, 11 Jul 2010 08:47:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.1007110842150.23489@uplift.swm.pp.se>
References: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se> <4C3962C8.60000@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:45190 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab0GKGrd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 11 Jul 2010 02:47:33 -0400
In-Reply-To: <4C3962C8.60000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 11 Jul 2010, Robert Hancock wrote:

> Unfortunately that's a pretty generic timeout error that could be caused 
> by quite a few things, like a hardware issue, bad cable, etc. as well as 
> possible driver problem..

Oki, in my case I saw it with multiple drives (all WD though) and multiple 
cables, but with just a single motherboard. The other people in the 
threads I quoted seem to have worked around it by disabling NCQ. I saw it 
on both channels on my motherboard as well, but I guess that could be 
hardware issue. I don't really have any way of fault finding this further 
as I have no lab machine, but it was fairly easy to reproduce (letting 
mdadm hammer the drive with an array check made it happen every time).

mdadm never kicked the drive, so whatever was going on was handled 
gracefully, but of course any file access was stopped for 10+ seconds.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
