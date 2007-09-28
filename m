From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 11:20:13 -0400
Message-ID: <46FD1BAD.8020506@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>	<46F9BF3E.5050708@garzik.org>	<46FA1B4E.8090103@gmail.com>	<46FD079F.3010007@garzik.org>	<46FD0D50.8030602@gmail.com> <20070928155703.490d7575@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57951 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbXI1PUT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 11:20:19 -0400
In-Reply-To: <20070928155703.490d7575@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Alan Cox wrote:
>> Aieee... Another merge delay.  I wish the review process proceeded a bit
>> swifter.   The patchset has been around literally for years now and
>> submitted for review six times if I have the take number right.  :-(
> 
> Agreed - thats one reason I stick everything in -mm. Its taking several
> months for a known fix to get from me to the outside. I'm not sure its
> entirely a Jeff problem however.

This doesn't affect Tejun or anyone else really, but going through -mm 
tends to gum up the works.  Your patches wind up not applying to 
libata#upstream, in which case they get dropped and I assume Andrew or 
someone will resend usable versions.

	Jeff



