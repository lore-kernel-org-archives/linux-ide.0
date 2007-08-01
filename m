From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [patch 2/4] Expose Power Management Policy option to users
Date: Wed, 01 Aug 2007 12:06:21 -0500
Message-ID: <1185987981.3468.91.camel@localhost.localdomain>
References: <20070705194909.337398431@intel.com>
	 <20070705130518.135e4e3c.kristen.c.accardi@intel.com>
	 <46AE12B6.6090408@garzik.org> <46AED656.8070407@gmail.com>
	 <1185891488.3468.2.camel@localhost.localdomain>
	 <20070801165352.GB21219@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20070801165352.GB21219@parisc-linux.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-scsi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, edwintorok@gmail.com, axboe@kernel.dk
List-Id: linux-ide@vger.kernel.org

On Wed, 2007-08-01 at 10:53 -0600, Matthew Wilcox wrote:
> On Tue, Jul 31, 2007 at 09:18:08AM -0500, James Bottomley wrote:
> > The other comment is that power saving seems to be a property of the
> > transport rather than the host.  If you do it in the transport classes,
> > then you can expose all the knobs the actual transport possesses (which
> > is, unfortunately, none for quite a few SCSI transports).
> 
> Would it save any power to negotiate down to, say, FAST-20 for the SPI
> transport?  Or to negotiate narrow instead of wide, so fewer cables have
> to be powered?

Mechanically, I don't believe so.  I'm not sure I can find any reports
on it; however, I believe the power wastage SPI comes from the
transcievers and terminators.  There's the passive power from simply
powering the resistive bus and then the RMS power from sending commands
over an impedance circuit.  simple physics on a 5v bus tells me that the
former is likely to be far greater than the latter.  Finally, if you
think about what the bus is doing during signalling, the power drain is
independent of the frequency so I think the faster you squirt your data,
the lower the energy drain (hence high speed busses are actually lower
energy than low speed ones if the number of bits you have to transfer
remains constant).

James


