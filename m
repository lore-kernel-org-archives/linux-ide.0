From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Date: Thu, 11 Jul 2002 11:54:03 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200207110954.LAA08806@cave.bitwizard.nl>
References: <20020709200711.GA13401@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20020709200711.GA13401@win.tue.nl> from Andries Brouwer at "Jul
 9, 2002 10:07:11 pm"
List-Id: linux-ide@vger.kernel.org
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Jul 09, 2002 at 12:22:49PM +0200, Jens Axboe wrote:
> 
> > I've forward ported the 2.4 IDE core to 2.5.25.
> 
> Very good!

Ehmm. We have had "old IDE support" in the kernel for "ages".  We have
two aic7xxx driver, two rtl8139 drivers, two, or more ncr53c8xx drivers. 

So why in the case of IDE has the "new IDE" driver not been forked and
implemented under a new "name" such that those working on other stuff
can chose to use the "old reliable" driver while others daring to test
the new advanced rewrite can do so?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
