From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 17:12:24 +0000
Message-ID: <20081125171224.297931b2@lxorguk.ukuu.org.uk>
References: <492B56B0.9030409@caviumnetworks.com>
	<1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com>
	<492C2F23.8050105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35121 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbYKYRMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:12:37 -0500
In-Reply-To: <492C2F23.8050105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org

On Tue, 25 Nov 2008 12:00:19 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> David Daney wrote:
> > The forthcoming OCTEON SOC Compact Flash driver needs a few more
> > timing values than were available in the ata_timing table.  I add new
> > columns for write_hold, read_hold, and read_holdz times.  The values
> > were obtained from the Compact Flash specification Rev 4.1.
> > 
> > Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> > ---
> >  drivers/ata/libata-core.c |   76 ++++++++++++++++++++++++--------------------
> >  include/linux/libata.h    |   14 ++++++--
> >  2 files changed, 52 insertions(+), 38 deletions(-)
> 
> I would be happy to go ahead and apply this...  Alan, any last minute 
> objections?

Its close but I think Sergei is right about columns with all the same
value - they can be constants and just computed into the final timing
data in terms of clocks.

