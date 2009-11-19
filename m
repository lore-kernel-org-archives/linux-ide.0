From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 23:42:01 +0000
Message-ID: <20091119234201.2e1c6f01@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<200911182056.16517.bzolnier@gmail.com>
	<4B05BADF.1010205@garzik.org>
	<200911192249.16860.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51178 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758101AbZKSXkK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 18:40:10 -0500
In-Reply-To: <200911192249.16860.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> > Merging drivers is a big pain for distributions and end users, even with 
> > the new module_alias facility.
> 
> Could please explain in more detail 'a big pain' part?

It might confuse the Fedora intall a bit but it shouldn't cause much
confusion.

> > Absent stronger justification, libata remains with separate drivers, 
> > even if that means some code duplication.
> 
> I can always hold my own tree with such changes if needed.

My view is that they should be separate because of all the stuff like the
hpt3x2n clocking. I've got some updates to hpt3x2n pending which I'll
post as untested too.

If you are going to try merging them then the proof will be in what the
merge looks like. If you are going to do it anyway it's got to be worth
making that decision after the merge is done.

Alan

