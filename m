From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Thu, 20 Oct 2005 09:45:21 -0700
Message-ID: <200510200945.22022.jbarnes@virtuousgeek.org>
References: <20051017044606.GA1266@havoc.gtf.org> <200510171006.39206.jbarnes@virtuousgeek.org> <1129817684.15200.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:13986 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932451AbVJTQp3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Oct 2005 12:45:29 -0400
In-Reply-To: <1129817684.15200.11.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com

On Thursday, October 20, 2005 7:14 am, Alan Cox wrote:
> Now that libata is beginning to behave well I'd vote for that option,
> however in kernel libata lacks several essential items for PATA
> feature parity (HPA, ATAPI, suspend/resume, correct tuning). It's
> getting there and I've got some more stuff waiting for Jeff, but it
> isn't there yet

Yeah, that seems like the best thing to do in the long run.  Of course it 
has to wait until libata at least has ATAPI support I'd imagine.  Jeff 
also mentioned that it would require changes to the legacy IDE driver to 
prevent it from binding to certain PCI devices (and given that it just 
uses I/O ports that might get hackish).

Jesse
