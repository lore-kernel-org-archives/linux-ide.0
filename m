From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patch] libata resume fix
Date: Wed, 31 May 2006 08:34:09 +1000
Message-ID: <1149028449.9986.66.camel@localhost.localdomain>
References: <20060528203419.GA15087@havoc.gtf.org>
	 <1148938482.5959.27.camel@localhost.localdomain>  <447C4718.6090802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964784AbWE3Wf0@vger.kernel.org>
In-Reply-To: <447C4718.6090802@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 2006-05-30 at 09:22 -0400, Mark Lord wrote:
> Benjamin Herrenschmidt wrote:
> > On Sun, 2006-05-28 at 16:34 -0400, Jeff Garzik wrote:
> >> Please pull from 'upstream-fixes' branch of
> >> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> >>
> >> to receive the following updates:
> >>
> >>  drivers/scsi/libata-core.c |    1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> Mark Lord:
> >>       the latest consensus libata resume fix
> > 
> > If your devices are coming from poweron-reset then you will have to wait
> > up to 31 seconds :( And yes, I _did_ have such a device at one point.
> 
> Not in a suspend/resume capable notebook, though.

Maybe, but 2 seconds is just "abitrary". I know some ATAPI devices (in
notebooks) that will drive the bus (and thus pollute whatever you try to
do) for way more than 2 seconds if they are reset with a CD in the
drive.

> I don't know of *any* notebook drives that take longer
> than perhaps five seconds to spin-up and accept commands.
> Such a slow drive wouldn't really be tolerated by end-users,
> which is why they don't exist.

They do, especially ATAPI.

> But I suppose people will want to suspend/resume bigger machines
> too, in which case a 10000rpm Raptor might need 15 seconds or so.
> 
> We could bump up the existing timeout, I suppose.
> 
> Perhaps Jeff could comment on any potential harm in libata
> for going all the way to 3100000 with the timeout?
