From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] libata: HPA support
Date: Tue, 17 Apr 2007 15:30:57 -0400
Message-ID: <20070417193057.GB22688@redhat.com>
References: <20070411002313.29069ca5@the-village.bc.nu> <20070417184139.GB11211@redhat.com> <46251CCB.9040906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:43457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031155AbXDQTdB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Apr 2007 15:33:01 -0400
Content-Disposition: inline
In-Reply-To: <46251CCB.9040906@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jkeating@redhat.com

On Tue, Apr 17, 2007 at 03:15:23PM -0400, Jeff Garzik wrote:
 > Dave Jones wrote:
 > > On Wed, Apr 11, 2007 at 12:23:13AM +0100, Alan Cox wrote:
 > >  > Signed-off-by: Alan Cox <alan@redhat.com>
 > >  > 
 > >  > Add support for ignoring the BIOS HPA result (off by default) and setting
 > >  > the disk to the full available size unless already frozen.
 > >  > 
 > >  > Tested with various platforms/disks and confirmed to work with the
 > >  > Macintosh (which broke earlier) and ata_piix (breakage due to the LBA48
 > >  > readback that Tejun fixed).
 > >  > 
 > >  > For normal users this brings us, I believe, to feature parity with old IDE
 > >  > (and of course more featured in some areas too).
 > > 
 > > This is broken horribly on nvidia chipsets..
 > 
 > I think this is what Kyle reported?
 
Yeah sounds like it.  Kyle just pointed out the discussion that followed,
which for some reason linux-ide neglected to send me.  I seem to have
fallen off the list a few weeks back, as looking at the archives shows
a bunch of ata related mails I don't recall ever seeing before.

 > Try booting with sata_nv module 
 > parameter 'adma' set to zero, does that fix the problem?

jesse, wanna give that a shot? booting with the installer with
sata_nv.adma=0 should do the trick.

	Dave

-- 
http://www.codemonkey.org.uk
