From: Andrew Joyce <joyce@webcreations.ca>
Subject: Re: VIA VT8251 on Asus A8V-MV
Date: Tue, 22 Nov 2005 03:09:56 +0000 (UTC)
Message-ID: <loom.20051122T040228-399@post.gmane.org>
References: <43808DAC.9030806@mgmservers.com> <20051121235516.GA8515@midnight.suse.cz> <43827C76.3000703@mgmservers.com> <20051122021604.GA32312@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:17071 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750702AbVKVDX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Nov 2005 22:23:29 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EeOiB-0003Nl-6U
	for linux-ide@vger.kernel.org; Tue, 22 Nov 2005 04:20:51 +0100
Received: from d226-53-149.home.cgocable.net ([24.226.53.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 22 Nov 2005 04:20:51 +0100
Received: from joyce by d226-53-149.home.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 22 Nov 2005 04:20:51 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Jeff Garzik <jgarzik <at> pobox.com> writes:

> 
> On Mon, Nov 21, 2005 at 09:03:34PM -0500, Jason Cribbins wrote:
> > Can you explain the situation in the following URL?
> > http://forums.viaarena.com/messageview.aspx?catid=28&threadid=68455
> > 
> > Also as I try to install fedora it reports that it is unable to find any 
> > installed HDs.  I have found an OpenBSD patch that does get it to work 
> > there but nothing for Linux that works as of right now.
> > My BIOS has the controller set to SATA mode right now and its not 
> > visible.  Even if I set it to RAID mode or AHCI modes I get the same 
> > result using fedora core4 and what ever kernel comes bundled with their 
> > installer.
> 
> The AHCI driver certainly won't work without adding PCI IDs to it...
> 
> did you try that?
> 
> These threads seem to indicate that AHCI needs updating for VIA.
> 
> 	Jeff 

I hate to spoil the suspense but I imagine you will meet with the same results
others have.  There have been a few posts to this list regarding the chipset and
so far no concrete ideas about what may be going on.  The following will patch
your ahci.c file to provide the correct PCI ID and, if my experience holds, the
chip will be recognized but communicating with the drives will timeout.

--- ahci.c      2005-11-21 21:52:38.000000000 -0500
+++ ahci.c      2005-11-21 21:52:41.000000000 -0500
@@ -277,6 +277,8 @@
          board_ahci }, /* ESB2 */
        { PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_ahci }, /* ICH7-M DH */
+       { PCI_VENDOR_ID_VIA, 0x3349, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_ahci }, /* VT8251 */
        { }     /* terminate list */
 };

Best of luck and please post your results of adding this ID to the AHCI driver.

Andrew


