From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: [PATCHSET] libata: reimplement suspend/resume support and fix spindown on poweroff
Date: Sun, 6 May 2007 23:29:55 +0200
Message-ID: <b637ec0b0705061429s5dce900frb0eabc252a6ffb9@mail.gmail.com>
References: <463B88EC.1080304@gmail.com>
	 <b637ec0b0705061311v1f9997k1c1d9b959b87082d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:27506 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXEFV3z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2007 17:29:55 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1231101wxd
        for <linux-ide@vger.kernel.org>; Sun, 06 May 2007 14:29:55 -0700 (PDT)
In-Reply-To: <b637ec0b0705061311v1f9997k1c1d9b959b87082d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, a.p.zijlstra@chello.nl

OK, your instructions worked fine. I tested 4 combinations:

* libata.spindown_compat=1 (default): the "pop" remains with and
without the "-n"
  parameter added to the halt command;
* libata.spindown_compat=0: no "pop" with and without the "-n"
  parameter added to the halt command.

As I read somewhere (maybe on lkml, I don't remember) that the "-n"
parameter was necessary to silence the "pop", I tried the old IDE
layer without the "-n" and it works the same as libata.

The conclusion is that your patch works (if the parameter is set to 0).

Hope this helps. Regards,
Fabio




On 5/6/07, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> Doesn't apply to today Linus' git tree:
>
> [fcomolli@tycho linux-2.6]$ git pull  git://htj.dyndns.org/libata-tj spindown
> remote: Generating pack...
> remote: Done counting 14283 objects.
> remote: Result has 11254 objects.
> remote: Deltifying 11254 objects.
> remote:  100% (11254/11254) done
> Indexing 11254 objects.
> remote: Total 11254 (delta 9842), reused 11241 (delta 9832)
>  100% (11254/11254) done
> Resolving 9842 deltas.
>  100% (9842/9842) done
> 1948 objects were added to complete this thin pack.
>  100% (44114/44114) done
> Auto-merged Documentation/feature-removal-schedule.txt
> CONFLICT (content): Merge conflict in Documentation/feature-removal-schedule.txt
> Automatic merge failed; fix conflicts and then commit the result.
>
> I don't know git enough to identify the conflict. Can anyone help me?
>
> Thanks in advance.
> Fabio
>
>
>
> On 5/4/07, Tejun Heo <htejun@gmail.com> wrote:
> > Hello,
> >
> > This is another take at using sdev->manage_start_stop to reimplement
> > suspend/resume and fix spindown on poweroff.  As Robert pointed out in
> > the other thread[1], sadly, ATA spec does NOT require cache flush on
> > standby and some distros don't flush cache prior to put the drive into
> > standby mode during shutdown.  This means that we can't skip cache flush
> > in the kernel shutdown path because data loss is possible.  Also, we
> > just can't switch to new method because there are drives which spin up
> > if told to spin down while it's already spun down.
> >
> > So, that leaves us with migrating to new behavior (kernel side
> > sync/shutdown) while maintaining backward compatibility.  This patchset
> > tries to do that by supplying a scheduled-to-be-removed module parameter
> > libata.spindown_compat which defaults to 1.  When set, it makes libata
> > skip spindown during shutdown sequence thus maintaining the old behavior
> > of issuing only cache flush on shutdown.
> >
> > So, distros should update their shutdown(8) to do the followings.
> >
> >   * Check whether /sys/modules/libata/parameters/spindown_compat
> >     exists.  If it does, write 0 to it.
> >
> >   * For each libata harddisk {
> >         * Check whether /sys/class/scsi_disk/h:c:i:l/manage_start_stop
> >           exists.  Iff it doesn't, synchronize cache and spin the disk
> >           down as before.
> >   }
> >
> > If shutdown(8) does the above, nothing will change on older kernels
> > (some drives will spin up and have to do emergency unload but they
> > aren't too many) and everything should work properly on kernels with
> > spindown_compat or later ones which won't have it.  If shutdown(8) isn't
> > updated, the kernel will behave the same way as older kernels would.
> >
> > To accelerate userland update, if shutdown(8) isn't updated
> > (spindown_compat not cleared), libata will complain loudly about it,
> > point the user to http://linux-ata.org/shutdown.html (which should be
> > written) and pause for 5 seconds during shutdown.  Hopefully, this makes
> > the users bug distros sufficiently so that userland tools can be updated
> > quickly.  Note that the pausing happens only during shutdown not during
> > reboot or suspend, so it shouldn't be too much of annoyance.
> >
> > This change requires sdev->manage_start_stop updates from scsi-misc-2.6.
> >  The merged git tree can be found at...
> >
> >   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=spindown
> >   git://htj.dyndns.org/libata-tj spindown
> >
> > Thanks.
> >
> > --
> > tejun
> >
> > [1] http://thread.gmane.org/gmane.linux.ide/18167
> >
>
