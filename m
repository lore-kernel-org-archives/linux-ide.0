From: Tejun Heo <htejun@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Wed, 26 Sep 2007 17:41:50 +0900
Message-ID: <46FA1B4E.8090103@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com> <46F9BF3E.5050708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.229]:57242 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbXIZNvF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 09:51:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1458353nze
        for <linux-ide@vger.kernel.org>; Wed, 26 Sep 2007 06:51:03 -0700 (PDT)
In-Reply-To: <46F9BF3E.5050708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
[--snip--]
> There, even the concept of "port" is fluid, and the libata EH model of
> freezing and thawing a port (with the desired irq-off result) just
> doesn't fit the hardware.

Well, the current model was developed while struggling with the first
generation PMP hardware which had a lot of quirks.  More focus was on
making the system run and keeping it that way.  Anyways, now that the
quirks are better understood, I think we can make PMP register access
irq-driven safely.

[--snip--]
> As such, polling is simply an outmoded concept.  It does not make sense
> on new hardware, and forcing design decisions down that path only lead
> to a cascade of similar design decisions -- pmp_read polling being just
> one example of such a result.

For pmp read/write, I agree that IRQ driven access would be better but
even for fairly advanced controllers like ahci or sil24, I think
resetting-by-polling is a good idea.

> Just like the Linux kernel MM platform API presents 3 levels of page
> table entries, even when the hardware may only have 2, libata high level
> API _must_ be implemented as 100% asynchronous event driven API.

Or allow both?

> If the default implementation chooses to use polling -- i.e. all SFF
> controllers -- that's fine.  But in the new SAS/SATA world its clear
> that we have far too many polling-related assumptions as it is.
> 
> Polling just flat out doesn't make sense on modern SAS/SATA -- and even
> a couple modern SATA controllers.  On such controllers, we are notified
> immediately via interrupt even in the event of errors.

For SAS, I don't have any strong opinion.  For SATA, I think we
definitely need to allow or even prefer polling for host port resets.

Is this NACK on the patchset or can we update PMP access later?

-- 
tejun

