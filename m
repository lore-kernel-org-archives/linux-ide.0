From: edwintorok@gmail.com
Subject: Re: [patch 3/4] Enable link power management for ata drivers
Date: Wed, 1 Aug 2007 12:45:33 +0300
Message-ID: <4354d3270708010245v5831610fw10ab2ff74d90ccae@mail.gmail.com>
References: <20070705194909.337398431@intel.com>
	 <20070705130530.5873afeb.kristen.c.accardi@intel.com>
	 <46B043FB.5090005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <46B043FB.5090005@gmail.com>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, jeff@garzik.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, James.Bottomley@steeleye.com, axboe@kernel.dk, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 8/1/07, Tejun Heo <htejun@gmail.com> wrote:
> >
> > +	if (ata_id_has_hipm(dev->id) || ata_id_has_dipm(dev->id))
> > +		dev->flags |= ATA_DFLAG_IPM;
>
> Is it safe to use ALPM on a device which only claims to support DIPM?

I have tested on a Dell Inspiron 6400, it has ICH7-M (82801GBM) chipset.
The harddisk claims to support only DIPM, and the ALPM patches work with it.
Kristen said either DIPM or HIPM will work with ALPM accord to the
spec, see this email:
http://www.bughost.org/pipermail/power/2007-June/000691.html

--Edwin
