From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] ARM: always select HAVE_IDE
Date: Sat, 19 Apr 2008 12:33:56 +0100
Message-ID: <20080419113356.GA6974@flint.arm.linux.org.uk>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080415221002.GL1677@cs181133002.pp.htv.fi> <20080415223928.GH5676@flint.arm.linux.org.uk> <200804160126.11116.bzolnier@gmail.com> <20080417093753.GF1677@cs181133002.pp.htv.fi> <20080417095916.GD1449@flint.arm.linux.org.uk> <20080417104836.GH1677@cs181133002.pp.htv.fi> <20080417110005.GE1449@flint.arm.linux.org.uk> <20080417132507.GA9314@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42242 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbYDSLed (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Apr 2008 07:34:33 -0400
Content-Disposition: inline
In-Reply-To: <20080417132507.GA9314@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Thu, Apr 17, 2008 at 04:25:07PM +0300, Adrian Bunk wrote:
> You have a point that one might argue that avr32 should also select 
> HAVE_IDE and get an asm/ide.h .
> 
> The main difference between avr32 and arm is that on arm there are a 
> bunch of platforms that actually want to use drivers/ide/ at the moment, 
> and the fine-grained select's we have at the moment don't bring any real 
> gain.
> 
> I do actually not care much how this gets resolved (we could even 
> ditch HAVE_IDE and provide asm/ide.h on all architectures) if there's 
> general agreement that this is the way to go.

That is probably a more correct approach.

Consider that if you do have PCMCIA, then you can plug a CF card in and,
therefore, you have an IDE interface in the system.  So, selecting
HAVE_IDE if PCMCIA is enabled is entirely reasonable.  What isn't so
reasonable is not providing asm/ide.h if your architecture has the
possibility of supporting PCMCIA.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
