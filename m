From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/4] libata: Implement disk shock protection support
Date: Mon, 1 Sep 2008 10:37:56 +0100
Message-ID: <20080901093756.GA13080@srcf.ucam.org>
References: <87wshzplvk.fsf@denkblock.local> <87ej45mlp3.fsf@denkblock.local> <48BA969C.4060207@gmail.com> <200808311632.04584.bzolnier@gmail.com> <87wshxkt9c.fsf@denkblock.local> <20080901020821.GA12532@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758125AbYIAJjK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080901020821.GA12532@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Elias Oltmanns <eo@nebensachen.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Aug 31, 2008 at 11:08:21PM -0300, Henrique de Moraes Holschuh wrote:
> On Sun, 31 Aug 2008, Elias Oltmanns wrote:
> > Admittedly, I don't know very much about it myself but I seem to
> > remember that there are other vendors now shipping similar technology.
> 
> Apple, HP.

HP typically put the CD drive and hard drive on the same channel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
