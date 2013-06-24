From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Mon, 24 Jun 2013 15:08:07 +0200
Message-ID: <201306241508.07377.linux@rainbow-software.org>
References: <20130623101940.GA4448@amd.pavel.ucw.cz> <51C84038.6090507@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C84038.6090507@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zdenek Kaspar <zkaspar82@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 24 June 2013, Zdenek Kaspar wrote:
> On 06/23/2013 12:19 PM, Pavel Machek wrote:
> > Hi!
> >
> > This may very well be hw problem, but...
> >
> > I have error on sda4. I tried to make hdd reallocate it by writing
> > zeros there, but it will not. Is there special kind of write that
> > needs to be done to force reallocation?
>
> Hi Pavel, maybe smartctl -t long /dev/sda will do the trick reliable for
> your drive..

It's a read-only test that ends with an error on the first bad sector.

-- 
Ondrej Zary
