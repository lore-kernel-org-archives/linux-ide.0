From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: VIA VT8251 on Asus A8V-MV
Date: Tue, 22 Nov 2005 00:55:16 +0100
Message-ID: <20051121235516.GA8515@midnight.suse.cz>
References: <43808DAC.9030806@mgmservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:64728 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750777AbVKUXzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Nov 2005 18:55:24 -0500
Content-Disposition: inline
In-Reply-To: <43808DAC.9030806@mgmservers.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cribbins <jason.cribbins@mgmservers.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Sun, Nov 20, 2005 at 09:52:28AM -0500, Jason Cribbins wrote:

> I was wondering if its possible to find someone to create a driver 
> support for the Via VT8251 South Bridge chipset which appears to have 
> been around for about a year now.  I am unable to get any form of Linux 
> to see my HDs connected to that on board controller.  Although I have 
> successfully used it in non-raid mode on FreeBSD.  I need this for 
> fedora if possible.
> 
> Is something like this possible?  And if so would it cost anything?
 
The vt8251 is supported for quite some time by the IDE driver and its
vt82cxxx.c chipset driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
