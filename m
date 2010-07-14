From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: timeout problems on onboard SATA 6.0 controller on Asus P7H57D-V
 EVO
Date: Wed, 14 Jul 2010 08:40:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.1007140839020.9875@uplift.swm.pp.se>
References: <alpine.DEB.1.10.1007101142440.23489@uplift.swm.pp.se> <4C3962C8.60000@gmail.com> <alpine.DEB.1.10.1007110842150.23489@uplift.swm.pp.se> <4C3D1684.3050107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:40308 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab0GNGku (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 02:40:50 -0400
In-Reply-To: <4C3D1684.3050107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, 13 Jul 2010, Robert Hancock wrote:

> In a lot of cases with people having trouble when running multiple hard 
> drives in a machine - especially with simultaneous access situations, 
> like a RAID check/rebuild - the problem has been a power issue. It seems 
> that some hard drives can cause power draw spikes that some PSUs can't 
> handle, especially if multiple drives are connected to the some cable 
> from the power supply.

I have a 550W common rail PSU and after moving the drive away from the 
SATA 6 port to a SiL controller port I haven't seen any more problems.

I saw the same timeouts when I first did some lab with the same 
motherboard, then I only had 1-2 drives in the machine. I doubt my 
perticular problem is power related.

It's a consistent problem, either it's a hw issue with my motherboard or 
it's a driver issue.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
