From: Andreas Werner <andreas.werner@men.de>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Thu, 3 Dec 2015 10:33:55 +0100
Message-ID: <20151203093355.GF10207@awelinux>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
 <20151201190410.GA21252@mtj.duckdns.org>
 <20151202093310.GE10207@awelinux>
 <20151202164753.GA19878@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151202164753.GA19878@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 02, 2015 at 11:47:53AM -0500, Tejun Heo wrote:
> Hello, Andreas.
> 
> On Wed, Dec 02, 2015 at 10:33:10AM +0100, Andreas Werner wrote:
> > Blacklisting the controller would be a solution yes, but I just
> > wanna wait the answer from the FAE to be sure we really have a
> > problem.
> > 
> > What kind of identifier can I use for blacklisting? The driver name
> > from the host driver? (fsl-sata) I did not find any register
> > in the sata controller to read out an ID.
> 
> Whatever matches the affected controllers.  If all sata_fsl
> controllers are affected, the driver init code can set the flag
> unconditionally.
> 
> Thanks.
> 
> -- 
> tejun

Ok, setting the flag in the controller driver would be good.
(still wating for the FAE for more info).

As I can see the horkage field is only defind in "struct ata_dev"
would it be time to add a horkage field to "struct ata_host"?

All the other "flag" fields in the structs are used and/or reserved
and it seems to be no good place for such flags.

What I am thinking about is.

1. Add new flag e.g. ATA_HORKAGE_NOLOG_PAGE_RD
2. Add horkage field to ata_host struct
2. Set this flag in ata_host struct in the sata_fsl driver (init)
3. Copy the controller horkage flags over to struct ata_device in
   the ata_dev_configure function in libata

   At the end all flags set by the controller are applied to
   the ata device horkage flags, and can be used for blacklisting
   in libata.


May be there are better solution, or i am missing something.

What do you think about it?

Regards
Andy	
