From: Jeremy Higdon <jeremy@sgi.com>
Subject: purpose of resetproc() in struct hwif_s
Date: Sat, 6 Dec 2003 23:42:41 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031207074241.GA188106@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtvcafw.SGI.COM ([192.48.171.6]:52193 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263861AbTLGHmn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2003 02:42:43 -0500
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by zok.sgi.com (8.12.9/8.12.9/linux-outbound_gateway-1.1) with ESMTP id hB77ggJt020707
	for <linux-ide@vger.kernel.org>; Sat, 6 Dec 2003 23:42:42 -0800
Received: from classic.engr.sgi.com (classic.engr.sgi.com [163.154.5.111])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id hB77gfGs17222599
	for <linux-ide@vger.kernel.org>; Sat, 6 Dec 2003 23:42:41 -0800 (PST)
Received: from classic.engr.sgi.com (localhost [127.0.0.1])
	by classic.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id hB77gfqa189736
	for <linux-ide@vger.kernel.org>; Sat, 6 Dec 2003 23:42:41 -0800 (PST)
Received: (from jeremy@localhost)
	by classic.engr.sgi.com (SGI-8.12.5/8.12.5/Submit) id hB77gf5i189757
	for linux-ide@vger.kernel.org; Sat, 6 Dec 2003 23:42:41 -0800 (PST)
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a question about the resetproc function pointer in
the ide_hwif_t structure.

Several PCI controllers don't fill in this pointer, and thus,
the controllers will not be reset in do_reset1().

The comment in do_reset1() is a little puzzling:

        /*                                                                                  
         * Some weird controller like resetting themselves to a strange
         * state when the disks are reset this way. At least, the Winbond
         * 553 documentation says that
         */
        if (hwif->resetproc != NULL) {
                hwif->resetproc(drive);
        }

Then there's this in the definition for ide_hwif_t:

        /* routine to reset controller after a disk reset */
        void    (*resetproc)(ide_drive_t *);


I'm wondering what to do with this in the driver I'm supporting
(sgiioc4, as well as a Vitesse VSC7174 driver).  Currently, they
both just disable DMA and clear any pending interrupts for the
drive in question.

My question is, what should it be doing?  Is turning shutting off
DMA and clearing interrupts sufficient if we don't think we need
to reset the controller?  Could it be harmful?


thanks

jeremy
