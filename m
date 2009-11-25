From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 48/86] pata_legacy: add pointers to QDI65x0 documentation
Date: Wed, 25 Nov 2009 19:21:53 +0100
Message-ID: <200911251921.53754.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200911251844.59772.bzolnier@gmail.com> <20091125181253.14159347@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759319AbZKYSXo@vger.kernel.org>
In-Reply-To: <20091125181253.14159347@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wednesday 25 November 2009 07:12:53 pm Alan Cox wrote:
> On Wed, 25 Nov 2009 18:44:59 +0100
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Wednesday 25 November 2009 06:38:52 pm Alan Cox wrote:
> > > > + *	QDI65x0 probe code based on drivers/ide/legacy/qd65xx.c
> > > > + *	Rewritten from the work of Colten Edwards <pje120@cs.usask.ca> by
> > > > + *	Samuel Thibault <samuel.thibault@ens-lyon.org>
> > > 
> > > It's not drivers/ide/legacy/qd65xx.c - because you moved it back in the
> > > old IDE code.
> > 
> > It was the correct path/driver when the aforementioned code was added.
> 
> Sure but the path has changed so its more helpful for anyone looking back
> to have the right path.

I disagree.  The code from back then is not the same code as today and we
have git log --follow for this.

--
Bartlomiej Zolnierkiewicz
