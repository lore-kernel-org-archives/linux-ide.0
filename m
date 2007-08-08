From: Al Boldi <a1426z@gawab.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Wed, 8 Aug 2007 21:58:32 +0300
Message-ID: <200708082158.32806.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S938262AbXHHS6d@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo  wrote:
> Mark Lord wrote:
> > Heh.. I haven't instrumented it yet, but I did discover a bit more about
> > it:
> >
> > The Power-Off_Retract_Count incrmenents *only* when there's data in the
> > on-drive write-cache.  So if I haven't written anything significantly
> > large before suspending, then it often does NOT increment the retract
> > counter.
> >
> > But if I copy a couple of multi-MB files around and then suspend (to
> > RAM), the retract count gets incremented.
> >
> > So I've now just stuck "hdparm -F /dev/sda" into my suspend script,
> > and that cures the problem completely for me.  "-F" does a FLUSH_CACHE,
> > and requires a recent copy of hdparm.
> >
> > Perhaps libata should also do a FLUSH_CACHE before any STANDBYNOW
> > command, prior to entering STR, which is what my script is currently now
> > doing..
> >
> > I'll instrument libata and see what the current sequence is.
>
> Hmmmm.. libata should issue FLUSH CACHE on STR too.  sd_suspend() and
> sd_shutdown() are pretty similar after all.

IMHO, this is a mess because we are essentially trying to work around 
firmware bugs, which may only be solved by having the kernel load a 
user-supplied shutdown sequence, instead of hardcoding it into the kernel.


Thanks!

--
Al
