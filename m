From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with
	!CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Sat, 25 Oct 2008 10:10:18 +1100
Message-ID: <1224889818.7654.466.camel@pasglop>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au>
	 <20081024113856.GA4252@linux.vnet.ibm.com> <4901BC5E.7040607@ru.mvista.com>
	 <1224886062.7654.464.camel@pasglop>  <49024EA3.1080404@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758596AbYJXXPm@vger.kernel.org>
In-Reply-To: <49024EA3.1080404@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, bzolnier@gmail.com
List-Id: linux-ide@vger.kernel.org

On Sat, 2008-10-25 at 02:39 +0400, Sergei Shtylyov wrote:
> >>    Hm, looks like this configuration was never buildable --
> #ifdef's are 
> >> missing and wrongly placed. CCing Ben Herrenschmidt...
> >>     
> >
> > What configuration ?
> >   
> 
>    See the subject.

Ah ok. We should probably just remove the option...

Ben.
