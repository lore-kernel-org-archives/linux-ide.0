From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCHSET] libata: improve ATA ACPI support
Date: Tue, 24 Apr 2007 01:03:41 +0200
Message-ID: <200704240103.41497.bzolnier@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com> <462C690B.1090802@gmail.com> <462D2D8F.5030200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <462D2D8F.5030200@rtr.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Tuesday 24 April 2007, Mark Lord wrote:
> Tejun Heo wrote:
> > 
> > of the time.  I think HDIO_GET_IDENTITY's meaning is something like
> > "give me IDENTIFY page of the device as seen by the driver" and doesn't
> > really matter as long as it can be used to get general idea about the
> > device.
> 
> The correct/original meaning of that ioctl was "boot time IDENTIFY" data.
> As Alan said, it later got bastardized by various people at some point.

It got de-bastardized later :) and currently HDIO_GET_IDENTITY seems to be
returning "boot time IDENTIFY" with only two exceptions:

* if ID can't be read et all - fake geometry with user supplied values
  to make things work - this is OK (was added by Alan IIRC)

* id->dma_{1word,mword,ultra} (currently selected DMA transfer modes)
  are updated when the current transfer mode changes - this is of least
  importance than capacity/geometry data (since nowadays all speed tuning
  should be done by kernel anyway) and easy to fix once DMA rewrite patches
  from my tree get merged

Thanks,
Bart
