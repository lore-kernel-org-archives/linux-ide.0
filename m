From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE functionality
Date: Fri, 23 Sep 2005 17:40:42 +0200
Message-ID: <58cb370e05092308406d1b9dc1@mail.gmail.com>
References: <op.sxg2dxd5wc4mme@new.robertk.com>
	 <1127399297.18840.92.camel@localhost.localdomain>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751091AbVIWPkp@vger.kernel.org>
In-Reply-To: <1127399297.18840.92.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Kesterson <robertk@robertk.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 9/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-09-21 at 16:38 -0500, Robert Kesterson wrote:
> > This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> > (such as used on the Asus P4P800 Deluxe motherboard).
>
> Mathias Kretschmer posted a patch several months ago, and Daniel Drake
> reposted it on August 30th if you check the archive. Bartlomiej was

No, this patch is an earlier reincarnation
(it changes generic.c instead of via82cxxx.c).

> asked to respond to/merge it but if he responded I didn't see it so it
> was probably a private reply.

Bartlomiej responded the same day (cc:ing linux-kernel and linux-ide)
and asked Daniel to fix via82cxxx.c to support multiple controllers.

Daniel sent me patch 2 days later but I still need to go through it
(I've been away for 3 weeks).

Bartlomiej
