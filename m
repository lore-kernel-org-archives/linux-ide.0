From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: tighten ATA kconfig dependancies
Date: Sat, 15 Jul 2006 12:56:43 +0200
Message-ID: <1152961003.3114.15.camel@laptopd505.fenrus.org>
References: <20060715053418.GA5557@redhat.com>
	 <1152942548.3114.4.camel@laptopd505.fenrus.org>
	 <20060715063827.GA24579@mars.ravnborg.org>
	 <1152945956.3114.6.camel@laptopd505.fenrus.org>
	 <20060715102825.GR3633@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946020AbWGOK4t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 06:56:49 -0400
In-Reply-To: <20060715102825.GR3633@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>


> > the point is that it doesn't fall out naturally, and thus things get
> > needlessly missed.
> 
> It seems the main question is:
> Is the kernel configuration mainly designed for users or for developers?
> 
> For users, showing drivers for hardware that is not present on their 
> platform only causes confusion.

well Aunt Tilly gets confused by all hardware that is not present on her
machine; she has no idea what a platform is. By that reasoning, we
should make kconfig hide all non-present hardware.

Also I think there is no difference in confusion between showing 10 or
15 IDE chipsets. Either the user knows what he has (and then it doesn't
matter) or those 10 are too much already.


