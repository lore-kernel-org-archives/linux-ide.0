From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_sis: Remove bogus cable match
Date: Sat, 6 Dec 2008 00:27:05 +0000
Message-ID: <20081206002705.46052575@lxorguk.ukuu.org.uk>
References: <20081205194117.17036.74479.stgit@localhost.localdomain>
	<49398FAC.2060301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52568 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752523AbYLFA05 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 19:26:57 -0500
In-Reply-To: <49398FAC.2060301@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: kai@kaishome.de, linux-ide@vger.kernel.org

On Fri, 05 Dec 2008 15:31:40 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Alan Cox wrote:
> > From: Alan Cox <alan@redhat.com>
> > 
> > Some systems report SIS 5513 as both vendor/id and subvendor/id string. In
> > that case we can't distinguish the system by the id svid/sdid and in fact
> > the entry here breaks some boxes. At some point we need to find another way
> > to detect the Targa Visionary 1000, until then this a hang for some users with
> > lower performance for others.
> > 
> > Closes: #12092
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Should that last sentence be "this SOLVES a hang"?
> 
> As it is currently worded, it is unclear what we are trading off with 
> this patch...

I missed out the word "trades" ...

