From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: Slow disks.
Date: Sat, 25 Dec 2010 13:19:05 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012251317420.27193@uplift.swm.pp.se>
References: <20101220141553.GA6088@bitwizard.nl> <20101220190630.66084e1d@neptune.home> <AANLkTi=VAJbVSzX_DH9_==a3RonLJmawYu3MzF-uqGXC@mail.gmail.com> <20101222104306.GB30941@bitwizard.nl> <m3aajvz5na.fsf@intrepid.localdomain> <4D14BB36.1030304@msgid.tls.msk.ru>
 <20101225121407.GA2116@bitwizard.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:38020 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab0LYMdq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Dec 2010 07:33:46 -0500
In-Reply-To: <20101225121407.GA2116@bitwizard.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Krzysztof Halasa <khc@pm.waw.pl>, Greg Freemyer <greg.freemyer@gmail.com>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, 25 Dec 2010, Rogier Wolff wrote:

> If you'd use a RAID drive that DOES report error quickly, you'll be on
> your way maybe 113 seconds quicker, but still with a degraded array.

Read errors will use parity drive and be re-written by the md layer.

Write errors will cause the drive to be kicked.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
