From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: linux-next: Tree for October 24 - powerpc - build failure with !CONFIG_BLK_DEV_IDEDMA_PMAC
Date: Sat, 25 Oct 2008 21:35:15 +0200
Message-ID: <200810252135.16056.bzolnier@gmail.com>
References: <20081024171932.1e8131d0.sfr@canb.auug.org.au> <200810251519.57543.bzolnier@gmail.com> <49036C17.1060604@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <49036C17.1060604@ru.mvista.com>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: benh@kernel.crashing.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 25 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>    Hm, looks like this configuration was never buildable -- #ifdef's are missing and wrongly placed. CCing Ben Herrenschmidt...   
> >>>>>           
> >>>> What configuration ?
> >>>>   
> >>>>         
> >>>    See the subject.
> >>>       
> >> Ah ok. We should probably just remove the option...
> >>     
> >
> > Fine with me.  Anybody want an easy +1 patch-point? :)
> >   
> 
>    BTW, why this option selects BLK_DEV_IDEDMA_PCI?

Leftover from the dark-ages...  needs fixing.
