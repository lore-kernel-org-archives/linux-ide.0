From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC 0/2] libata: support SATA devices on SAS HBAs
Date: Tue, 4 Oct 2005 12:22:35 +0200
Message-ID: <58cb370e0510040322q1cb7a13bjfc6c7875140d20a9@mail.gmail.com>
References: <4341A91A.3020000@us.ibm.com> <434251E0.9060000@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.206]:59694 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932176AbVJDKWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Oct 2005 06:22:37 -0400
Received: by nproxy.gmail.com with SMTP id x37so218899nfc
        for <linux-ide@vger.kernel.org>; Tue, 04 Oct 2005 03:22:35 -0700 (PDT)
In-Reply-To: <434251E0.9060000@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: brking@us.ibm.com, linux-ide@vger.kernel.org

On 10/4/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Brian King wrote:
> > The following patches enhance libata to allow SAS device drivers
> > to utilize libata to talk to SATA devices. It introduces some
> > new APIs which allow libata to be used without allocating a
> > virtual scsi host. This is just a snapshot of what I've
> > come up with at this point and I figured I would post it to
> > see if I was heading in a reasonable direction or not, so
> > don't expect the code below to do anything useful at this point
> > as it is untested.
>
> hmmmm, neat.  My gut feeling feeling says a slightly better direction
> might be warranted, but I'll have to think a bit to put that feeling
> towords.
>
> * One thought is the desire to allocate a single ata_host_set for the
> HBA, rather than avoiding ata_host_set.

For SAS we should definitely avoid ata_host_set.

> * Another thought is the locking scheme -- Christoph once poked me about
> libata's use of scsi_assign_lock(), which I rather like but he didn't :)
>   So by the transitive(?) property, if libata's locking is useful, then
> your solution is probably OK.  And vice versa.

host_set->lock is not useful for SAS et all and libata can
be easily fixed to not require it for SAS (I'll make a patch later).

> * I also wonder if there isn't any severe leakage or oops somewhere,
> because you don't really use ata_host_set, just ata_port.
>
> But note again, these are 6am thoughts, not in-depth analysis.

:)

Bartlomiej
