From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
Date: Wed, 24 Sep 2008 14:52:07 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0809241448480.811@cliff.in.clinika.pl>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <48DA1F9D.6000501@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-ide@vger.kernel.org

On Wed, 24 Sep 2008, Sergei Shtylyov wrote:

>    Platform device in the driver itself? Interesting... :-)

 Better than nothing for platforms which did not have platform
initialisation at all.  Some driver subsystems do not support
non-driver-model devices at all or anymore.

  Maciej
