From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH v2] pata_it8213: fix register naming used in it8213_set_piomode()
Date: Thu, 13 Oct 2011 18:10:01 +0200
Message-ID: <201110131810.02228.bzolnier@gmail.com>
References: <201110131744.23090.bzolnier@gmail.com> <20111013165405.3d4d93b8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111013165405.3d4d93b8@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:

> On Thu, 13 Oct 2011 17:44:22 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH v2] pata_it8213: fix register naming used in it8213_set_piomode()
> > 
> > Rename 'idetm_port' and 'idetm_data' variables to 'master_port'
> > and 'master_data' respectively to match register naming used in
> > it8213_set_dmamode() and in ata_piix.c.
> 
> I do question this renaming. Surely we should reflect the names on the
> data sheets if anything ?

Please lets have some consistency in the driver first (same names used
in ->set_piomode and ->set_dmamode)..  we can always do global rename
later if needed.
 
