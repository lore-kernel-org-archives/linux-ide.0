From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET] prep for PMP support, take 3
Date: Tue, 31 Oct 2006 21:22:03 -0500
Message-ID: <454804CB.9030805@pobox.com>
References: <11609542672061-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:32470 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946023AbWKACWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 21:22:09 -0500
In-Reply-To: <11609542672061-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, all.
> 
> This is the third take of libata-pmp-prep patchset.  This patchset
> contains 5 patches and implements various stuff needed for PMP.
> 
> Changes from the last take[L] are.
> 
> * rebased
> * sata_link_hardreset() separation is done earlier by vt8251-ahci
>   patchset and thus dropped from this patchset.
> 
> This patchset is against
> 
>   upstream (da54f5fe54c7d75e2db7d17961fb36a8c28a8501)
>   + [1] hp-poll patchset, take #5
>   + [2] vt8251-ahci patchset, take #2
>   + [3] libata-link patchset, take #3
> 
> Git tree can be accessed at
> 
>   http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp-prep
>   git://htj.dyndns.org/libata-tj pmp-prep
> 
> Jeff, I couldn't merge ->qc_defer() into ->qc_prep() or ->qc_issue().
> The problem is that ->qc_prep() is done after sg mapping is done which
> is a bit costly to throw away if the qc has to be deferred.
> ->qc_defer() is called right after qc is allocated and translated but
> before any resource for qc execution is acuquired.
> 
> Another way would be to let ->qc_issue() determine whether deferring
> is needed and cache prepared qc while deferred.  This has the
> following problems.
> 
> * qc and related resources are held by deferred command.  Currently,
>   qc directly maps to hardware command slots and w/ PMP this can get
>   messy.
> 
> * Separate requeueing/restarting mechanism must be implemented.  ATM,
>   libata depends on SCSI for retrying deferred commands with
>   reasonable fairness.  To hold prepared qc, libata needs to implement
>   its own mechanism and I don't think the added benefits justify the
>   complexity.
> 
> So, I think it's better to keep ->qc_defer().

Weak ACK for the patchset:

SET FEATURES - XFER MODE also needs to use the defer capability.  And we 
also have such a need for simplex devices.  It would be useful to have 
all of this stuff collected into an "ATA command scheduling / 
sequencing" area, rather than just a new hook confined to a single area. 
  I think the problem space is more complex than that.

	Jeff
