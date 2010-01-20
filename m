From: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
Subject: Unreferenced config in kernel (libata-sff.c) source (NO_ATA_LEGACY)
Date: Wed, 20 Jan 2010 15:29:43 +0100
Message-ID: <20100120142943.GE3580@faui49.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753144Ab0ATO30@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, htejun@gmail.com, linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: siccegge@stud.informatik.uni-erlangen.de, Reinhard.Tartler@informatik.uni-erlangen.de
List-Id: linux-ide@vger.kernel.org

Hi all!

	As part of the VAMOS[0] research project at the University of
Erlangen we're checking referential integrity between kernel KConfig
options and in-code Conditional blocks.

./drivers/ata/libata-sff.c:2948:#if defined(CONFIG_NO_ATA_LEGACY)

	That's the only place where it is checked for
NO_ATA_LEGACY. As this Item does appear nowhere in KConfig and
therefor is not selectable I'm wondering whether that small Code
fragment should be dropped or a new KConfig option should be added?

	Please keep me informed of this patch getting confirmed /
merged so we can keep track of it.

Regards

	Christoph Egger
