From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Date: Wed, 07 Sep 2005 18:09:10 +0100
Message-ID: <1126112950.8928.18.camel@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751258AbVIGQob@vger.kernel.org>
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>
List-Id: linux-ide@vger.kernel.org

On Maw, 2005-09-06 at 16:33 -0700, Ravikiran G Thirumalai wrote:
> 2. Change the core ide code to use hwgroup->lock instead of ide_lock.
> Deprecate ide_lock (patch 2)

hwgroups and IDE locking requirements are frequently completely
unrelated. Its clear from the changes proposed you've not tested on real
hardware for each case and you have not studied the documented errata
even for the controllers that are publically specified. This is peoples
data you are endangering, not just risking the odd crash.

> patches -- this is done now for piix controller only.  Eventually, 
> we can change all controllers to remove ide_lock

You could start by fixing the real locking bugs. Or at least trying to
get known fixes past the maintainer and going from there.

Alan
