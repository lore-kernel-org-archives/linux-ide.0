From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression: commit "ide: constify struct ide_port_info" causes
 breakage
Date: Fri, 26 Oct 2007 09:30:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710260929290.30120@woody.linux-foundation.org>
References: <20071026155648.GB4321@flint.arm.linux.org.uk>
 <47221164.10200@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764071AbXJZQc0@vger.kernel.org>
In-Reply-To: <47221164.10200@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org



On Fri, 26 Oct 2007, Sergei Shtylyov wrote:
> 
>    We can just convert cariables declared as 'struct hpt_info' to const too -- 
> they are read-only templates.

Generally "__devinitdata" is better than "const", since it means that the 
data may be thrown away.

So if you drop one over the other, it's generally the "const" that should 
be dropped ;/

		Linus
