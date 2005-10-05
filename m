From: Brett Russ <russb@emc.com>
Subject: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
Date: Wed,  5 Oct 2005 17:06:10 -0400 (EDT)
Message-ID: <20051005210610.EC31826369@lns1058.lss.emc.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964974AbVJEVG4@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>, Michael Madore <Michael.Madore@aslab.com>, Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, "Mr. Berkley Shands" <bshands@exegy.com>, Jim Edwards <jim@networkdesigning.com>, scott olson <scotto701@yahoo.com>, Lars Magne Ingebrigtsen <larsi@gnus.org>, Evgeny Rodichev <er@sai.msu.su>
List-Id: linux-ide@vger.kernel.org

This patch series should fix up lockups that people were seeing due to
improper spinlock placement (nested==bad).  Additionally, there are
other changes to simplify things (complex=bad).  The second patch adds
comment headers to functions that need it.

Thanks,
BR
