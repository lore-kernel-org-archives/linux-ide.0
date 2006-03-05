From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: implement and use ata_dev_revalidate(), take #3
Date: Mon, 6 Mar 2006 01:33:45 +0900
Message-ID: <20060305163345.GB1156@htj.dyndns.org>
References: <11415489584127-git-send-email-htejun@gmail.com> <440B0D90.2080005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:39527 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932206AbWCEQdt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 11:33:49 -0500
Received: by zproxy.gmail.com with SMTP id 13so1059279nzn
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 08:33:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <440B0D90.2080005@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Sun, Mar 05, 2006 at 11:10:56AM -0500, Jeff Garzik wrote:
> Tejun Heo wrote:
> >Hello, Jeff.
> >
> >This is the third take of implement-and-use-ata_dev_revalidate
> >patchset.  In the last take[1], out of four patches, %1, %2 and %4 got
> >ACK'ed while %3 had some minor issues.
> >
> >Changes from the last take are...
> >
> >* in #3, ata_dev_same_device() tags mismatch messages with KERN_INFO
> >  instead of KERN_WARNING.
> >
> >* in #3, ata_dev_revalidate() returns -ENODEV instead of 0 if device
> >  isn't present
> 
> I thought this was take #4?  Anyway...
> 

The first take was on Feb 15, the second on Mar 1, and this one.
Although the first take wan't really first (it was chopped off part of
previously posted larger patchset), it's the third take, technically.

Thanks.  :-)

-- 
tejun
