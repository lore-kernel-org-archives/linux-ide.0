From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash
 interface.
Date: Fri, 21 Nov 2008 18:07:21 +0000
Message-ID: <20081121180721.357f4c99@lxorguk.ukuu.org.uk>
References: <49261BE5.2010406@caviumnetworks.com>
	<20081121102137.634616c5@lxorguk.ukuu.org.uk>
	<4926EA6A.7040704@caviumnetworks.com>
	<4926EF55.7080004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4926EF55.7080004@ru.mvista.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-ide@vger.kernel.org

> >> If you get a request for an odd length you should write an extra word
> >> containing the last byte and one other. See how the standard methods
> >> handle this.
> 
> > OK.
> 
>     I don't think you need to bother doing that with CF.

Look at it the other way around is the best thing to do given an odd
sized I/O (eg if a CF format ATAPI drive comes along) to crash the
machine.

> > Perhaps it would be better to fix the problem at the source.
> 
>     I don't think there's a problem there. The string versions of the 
> functions treat memory as a string of bytes.

Double checking the docs you are right. How dumb, but dumb or not that is
what it is specified to do.

> > Probably nothing.  I will try to sort it out.
> 
>     It's the need for the tasklet that seems doubtful to me...

I was wondering but assumed it was some kind of hardware feature where
the end of IRQ occurs too early to do some of the cleanup.
