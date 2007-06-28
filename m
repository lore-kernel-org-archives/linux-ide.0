From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH 2.6.22-rc6] sata_inic162x: add big fat warning about broken LBA48 support
Date: Thu, 28 Jun 2007 12:59:07 -0400
Message-ID: <87f94c370706280959p65df91d6xc74a4a6b9aed6c1f@mail.gmail.com>
References: <4683DCD3.1040303@gmail.com>
	 <87f94c370706280914v7b52a7d7k31d323b9d88da19b@mail.gmail.com>
	 <4683E171.1090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:48182 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758944AbXF1Q7J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Jun 2007 12:59:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so623556ugf
        for <linux-ide@vger.kernel.org>; Thu, 28 Jun 2007 09:59:08 -0700 (PDT)
In-Reply-To: <4683E171.1090306@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 6/28/07, Tejun Heo <htejun@gmail.com> wrote:
> Greg Freemyer wrote:
> > Does it simply fail?  Or does it corrupt?
> >
> > In my Windows experience, if you try to write data past ~128GiB and
> > you don't have LBA48 support you get a wraparound effect that causes
> > corruption of the data below ~128GiB.  I've seen it happen several
> > times under Win2K in particular.
>
> It will probably wrap and corrupt data.  The driver is already marked
> HIGHLY EXPERIMENTAL.  Do you think we need bigger hammer?
>
> --
> tejun
>
At a minimum the error msg should be much stronger than "won't work".
Something like "will be horribly corrupted and all your valuable data
will be lost."

Even better from my perspective would be to simply cause a > 128GiB
drive to be ignored and totally unaccessible.  Obviously it should
have a message to that effect.

ie. Assume you have a partition that spans the 128 GiB barrier.  If
you allow access to the first half of the partition and not the last,
you have another major corruption possibility even though you don't
have any wrap-around affects.

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
