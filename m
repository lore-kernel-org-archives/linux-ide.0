From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/3] 2.6.22-rc3: known regressions with patches v2
Date: Fri, 01 Jun 2007 14:21:54 +0200
Message-ID: <46600F62.5070005@googlemail.com>
References: <46600D36.7060405@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.231]:15135 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761148AbXFAMW1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jun 2007 08:22:27 -0400
Received: by nz-out-0506.google.com with SMTP id n1so496432nzf
        for <linux-ide@vger.kernel.org>; Fri, 01 Jun 2007 05:22:27 -0700 (PDT)
In-Reply-To: <46600D36.7060405@googlemail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>, Andrea Righi <righiandr@users.sourceforge.net>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>, "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, Tom Long Nguyen <tom.l.nguyen@intel.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ian Kumlien <iank@bredband.net>, =?ISO-8859-2?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>

Hi all,

Here is a list of some known regressions in 2.6.22-rc3
with patches available.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Memory management

Subject    : bug in i386 MTRR initialization
References : http://lkml.org/lkml/2007/5/19/93
Submitter  : Andrea Righi <righiandr@users.sourceforge.net>
Status     : patch available



PCI

Subject    : Oops on 2.6.22-rc2 when unloading the cciss driver
References : http://lkml.org/lkml/2007/5/24/172
Submitter  : Mike Miller (OS Dev) <mikem@beardog.cca.cpqcorp.net>
Patch      : http://lkml.org/lkml/2007/5/31/387
Status     : patch available



SATA/PATA

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Patch      : http://lkml.org/lkml/2007/5/19/161
Status     : patch available



Timers

Subject    : timer statistics oops
References : http://lkml.org/lkml/2007/5/29/399
Submitter  : Ian Kumlien <iank@bredband.net>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
             Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
Patch      : http://lkml.org/lkml/2007/5/31/394
Status     : patch was suggested



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"

