From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata fixes
Date: Fri, 05 Jun 2009 17:15:28 -0400
Message-ID: <4A298AF0.3060106@garzik.org>
References: <20090605184608.GA29250@havoc.gtf.org> <20090605211647.2f118a5c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752832AbZFEVPn@vger.kernel.org>
In-Reply-To: <20090605211647.2f118a5c@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
> Missing
>     libata: Use IGN_SIMPLEX for ALi
> which you said you'd kick upstream and without which lots of ALi users
> now get no DMA on half their devices due to PM changes.

It was in linux-next -- promoted to upstream-fixes.


Linus, please pull from this NEW BRANCH

Please pull from 'upstream-linus2' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git 
upstream-linus2

which is upstream-linus + the following commit:

> commit a3cb900cc408977a11519bc7c760f3e499079589
> Author: Alan Cox <alan@linux.intel.com>
> Date:   Wed May 13 15:02:27 2009 +0100
> 
>     [libata] pata_ali: Use IGN_SIMPLEX
>     
>     Some ALi devices report simplex if they have been disabled and re-enabled, a
>     restoring the byte does not work. Ignore it - the needed supporting logic is
>     already present for the SATA ULi ports.
>     
>     Signed-off-by: Alan Cox <alan@linux.intel.com>
>     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
