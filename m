From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] drivers/ata: print trim features at device
 initialization
Date: Sun, 09 Jun 2019 14:37:21 -0700
Message-ID: <1560116241.3324.19.camel@HansenPartnership.com>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
         <yq1wohxib7t.fsf@oracle.com>
         <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
         <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
List-Id: linux-ide@vger.kernel.org

On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
> > On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019
> > at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
> >  >
> >  > Do we really need to spam dmesg with even more ATA crap?  What
> > about
> >  > a sysfs file that can be read on demand instead?
> >  >
> > 
> > Makes sense.
> > 
> > Trim state is exposed for ata_device:
> > /sys/class/ata_device/devX.Y/trim
> > but there is no link from scsi device to ata device so they hard to
> > match.
> > 
> > I'll think about it.
> 
> Nope. There is no obvious way to link scsi device with ata_device.
> ata_device is built on top of "transport_class" and
> "attribute_container".
> This some extremely over engineered sysfs framework used only in
> ata/scsi. I don't want to touch this.

You don't need to know any of that.  The problem is actually when the
ata transport classes were first created, the devices weren't properly
parented.  What should have happened, like every other transport class,
is that the devices should have descended down to the scsi device as
the leaf in an integrated fashion.  Instead, what we seem to have is
three completely separate trees.

So if you look at a SAS device, you see from the pci device:

host2/port-2:0/end_device-2:0/target2:0:0/2:0:0:0/block/sdb/sdb1

But if you look at a SATA device, you see three separate paths:

ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
ata3/link3/dev3.0/ata_device/dev3.0
ata3/ata_port/ata3

Instead of an integrated tree

Unfortunately, this whole thing is unfixable now.  If I integrate the
tree properly, the separate port and link directories will get subsumed
and we won't be able to recover them with judicious linking so scripts
relying on them will break.  The best we can probably do is add
additional links with what we have.

To follow the way we usually do it, there should be a link from the ata
device to the scsi target, but that wouldn't help you find the "trim"
files, so it sounds like you want a link from the scsi device to the ata device, which would?

James
