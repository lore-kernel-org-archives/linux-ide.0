From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 17:57:08 +0200
Message-ID: <58cb370e050811085747380256@mail.gmail.com>
References: <200508071949.03782.inform@tiker.net>
	 <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain>
	 <42F8B41C.4040408@rtr.ca> <42FACCA8.6050408@pobox.com>
	 <1123753051.4226.22.camel@localhost.localdomain>
	 <58cb370e05081103031cb9ccdb@mail.gmail.com>
	 <1123755440.4226.28.camel@localhost.localdomain>
	 <58cb370e050811032658a2b61e@mail.gmail.com>
	 <1123774157.4422.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:6600 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbVHKP5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 11:57:11 -0400
Received: by nproxy.gmail.com with SMTP id l37so95420nfc
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2005 08:57:08 -0700 (PDT)
In-Reply-To: <1123774157.4422.3.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On 8/11/05, Erik Slagter <erik@slagter.name> wrote:
> On Thu, 2005-08-11 at 12:26 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > As ICH6M features both PATA and SATA connections, I don't see why they'd
> > > use a PATA bridge... The DVD drives use PATA anyway, btw.
> >
> > AFAIR ICH6M has only one PATA port and putting both HDD and DVD drive
> > on the same PATA port would sacrifice performance (because only one PATA
> > device can be used at a time).
> 
> That's duff. The PATA harddisk that is used in my laptop, also comes in
> a SATA version...

You didn't even tell the vendor/model of the HDD

hdparm -I /dev/hda
 
output (with your patch applied) would be useful.
