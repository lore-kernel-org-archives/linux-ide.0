From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE
	driver
Date: Sun, 28 Sep 2008 00:51:39 +0100
Message-ID: <20080927235138.GA6802@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Wed, Sep 24, 2008 at 02:52:07PM +0100, Maciej W. Rozycki wrote:

> >    Platform device in the driver itself? Interesting... :-)
> 
>  Better than nothing for platforms which did not have platform
> initialisation at all.  Some driver subsystems do not support
> non-driver-model devices at all or anymore.

Historically registration of the device file in the driver itself wasn't
uncommon before it turned out to be not such a great idea.  I hope this
was the last of the affected MIPS-specific drivers.

  Ralf
