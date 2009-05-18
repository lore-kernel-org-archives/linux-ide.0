From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: s2disk hangs with kernel >=2.6.29, SATA, Gigabyte EG45M-DS2H (bisected)
Date: Mon, 18 May 2009 16:29:33 +0200
Message-ID: <200905181629.33234.bzolnier@gmail.com>
References: <20090516225153.GA7883@arbonne.lan> <200905180117.28413.bzolnier@gmail.com> <20090518141646.GA6460@arbonne.lan>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754882AbZERO0E@vger.kernel.org>
In-Reply-To: <20090518141646.GA6460@arbonne.lan>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Atterer <richard@2009.atterer.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Elias Oltmanns <eo@nebensachen.de>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 18 May 2009 16:16:46 Richard Atterer wrote:
> On Mon, May 18, 2009 at 01:17:27AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 17 May 2009 00:51:53 Richard Atterer wrote:
> > > The patch that causes the hang is 295f00042aaf6b553b5f37348f89bab463d4a469:
> > > ide: don't execute the next queued command from the hard-IRQ context (v2)
> > 
> > Hmm, this should have been fixed by:
> > 
> > commit 2ea5521022ac8f4f528dcbae02668e02a3501a5a
> > Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Date:   Wed Jan 14 19:19:04 2009 +0100
> > 
> >     ide: fix suspend regression
> 
> I just tried that revision (with a small patch to get pcf50633-core to 
> compile) and hibernating does not work. :-/

Ok, thanks for testing it, also just to make sure:

Does the one commit before 295f00042aaf6b553b5f37348f89bab463d4a469
(namely ebdab07dad3d3a008e519b0a028e1e1ad5ecaef0) work fine?

Thanks.
Bart
