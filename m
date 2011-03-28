From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: Re: PATA_ARTOP oppes in 2.6.38
Date: Mon, 28 Mar 2011 08:34:10 +0100
Message-ID: <4D9039F2.4060407@danielpalmer.co.uk>
References: <4D8FD6D1.2020501@danielpalmer.co.uk> <19856.14311.395203.113370@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:39347 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab1C1HeT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2011 03:34:19 -0400
In-Reply-To: <19856.14311.395203.113370@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On 28/03/11 08:25, Mikael Pettersson wrote:
> pata_artop works fine with 2.6.38 on one of my older ARM boxes
> (a Synology DS101 NAS, arm/mach-ixp4xx/, BSP not in upstream kernel).
>
> I'd suspect an issue with your platform (sh?).  A kernel bisection
> should identify the offending commit.
>    

Thank you, I too suspected it was something in the arch specific code.. 
the code for the Landisk boards hasn't changed since ~2007 but some 
recent commits broke a lot of things. I did send the oops to the person 
that did the changes (linked in my original mail) and they said they 
think it's the driver.
If it works for you though that rules that out to a certain degree.

Thanks again!

Daniel


/me just noticed I spelled oops incorrectly in the subject. oops.
