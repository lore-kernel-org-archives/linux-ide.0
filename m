From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/86] pata_artop: add 32-bit PIO support
Date: Wed, 25 Nov 2009 18:18:18 +0100
Message-ID: <200911251818.18521.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125170239.5446.26287.sendpatchset@localhost> <20091125171242.70b8019f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933459AbZKYRUR@vger.kernel.org>
In-Reply-To: <20091125171242.70b8019f@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 25 November 2009 06:12:42 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:02:39 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] pata_artop: add 32-bit PIO support
> > 
> > There shouldn't be any problems with it as IDE aec62xx host driver
> > has been allowing 32-bit PIO operations for years.
> 
> Allowing or defaulting too ?

For aec62xx: allowing, for some other drivers: defaulting ('using'
in the patch description instead of 'allowing').  However some
popular distributions have been defaulting to always enabling it
if was supported by the driver.

--
Bartlomiej Zolnierkiewicz
