From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Nvidia IDE MCP78S not syncing: Fatal exception in interrupt
Date: Thu, 10 Sep 2009 11:25:27 +0200
Message-ID: <200909101125.27653.bzolnier@gmail.com>
References: <d6592cfc0909061317k2dd1989did35ec4d1d68e80f9@mail.gmail.com> <20090909221234.daea7525.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755321AbZIJJYs@vger.kernel.org>
In-Reply-To: <20090909221234.daea7525.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stevan Silva <tevost@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 10 September 2009 07:12:34 Andrew Morton wrote:
> (cc linux-ide)
> 
> null-pointer deref in ide_complete_rq().
> 
> On Sun, 6 Sep 2009 17:17:08 -0300 Stevan Silva <tevost@gmail.com> wrote:
> 
> > I recently bought an ASUS M4N78 PRO motherboard, that is based in the
> > nvidia's geforce 8300 chipset and updated my system kernel to 2.6.30
> > version.

We're at 2.6.30.6 / 2.6.31 now so it would be worth to try them first
(I remember similar problem being fixed some time ago).
