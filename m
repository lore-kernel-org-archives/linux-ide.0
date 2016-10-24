From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/5] ahci: nvme remap support
Date: Mon, 24 Oct 2016 14:01:11 -0700
Message-ID: <CAPcyv4hHqkFirpaGTjs+iNKB9sr_thYOKN=N58vkLDYcXErOcQ@mail.gmail.com>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de> <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de> <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de> <20161024144628.GC8633@localhost.localdomain>
 <20161024151657.GA7080@lst.de> <CAPcyv4jSx5c3DzEsbfUph5Akk-XyxQ2sXAgmLZfhvGEOUtBqdQ@mail.gmail.com>
 <20161024175527.GA11088@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35968 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965639AbcJXVBM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Oct 2016 17:01:12 -0400
Received: by mail-oi0-f47.google.com with SMTP id m72so59148269oik.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2016 14:01:12 -0700 (PDT)
In-Reply-To: <20161024175527.GA11088@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>, Tejun Heo <tj@kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-nvme@lists.infradead.org

On Mon, Oct 24, 2016 at 10:55 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Oct 24, 2016 at 10:46:29AM -0700, Dan Williams wrote:
>> On Mon, Oct 24, 2016 at 8:16 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > On Mon, Oct 24, 2016 at 10:46:29AM -0400, Keith Busch wrote:
>> >> Amber is aware of this and was supportive in having Intel open the
>> >> specs to enable this hardware.
>> >
>> > Ok, let's get the spec out first.
>>
>> The patch contents are it.
>
> Well. that's simply not acceptable.  We will need a theory of
> operation for this device to support it, because the patch as-is
> simply doesn't make sense.

The presence of ahci bar remapping is documented here:

http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datashee=
t-vol-2.html

The PCI memory space is remapped, the configuration space of the
remapped device is not available, and interrupts are shared.

> We'll also need to know where such device might show up, and why
> Linux support for it matters.

This is a capability of the "Intel=C2=AE 100 Series Chipset Family".  These
patches matter because this chipset in this configuration appears in
laptops that you can buy today and Linux is unable to access the NVMe
device.

>> > Do we expect to be able to use the
>> > AHCI interface and the NVMe interface at the same time?
>>
>> Yes, simultaneous access.
>
> Yikes.  I'm really tempted to say this is not acceptable - Intel
> really must know better.
>

Linux users are unable to access storage without these patches.

>> That said, the driver seems to already comprehend instances where the
>> device does not support nvme_reset_subsystem() requests. I don't know
>> how often those resets need to be issued in practice.
>
> It's not about how often reset are needed (and there are controller
> resets in addition to function level resets), but how they are
> defined to work.  What state is a controller in after a host initiated
> reset, after a PCIe hotplug or even warm plug.  What state is the
> PCI device in when the controller is in a failed state?

Talking with Keith, subsystem-resets are a feature of enterprise-class
NVMe devices.  I think those features are out of scope for the class
of devices that will find themselves in a platform with this
configuration, same for hot-plug.

>> > If it's the latter let's keep AHCI entirely out
>> > of the game - add the affected PCI IDs to the NVMe driver itself, add
>> > a quirk for them and implement the enable sequence inside the NVMe
>> > driver.
>>
>> The PCI ID of the AHCI device is not uniquely identifiable when in this =
mode.
>>
>> We could flip the arrangement and have the ahci device as the platform
>> device, but I'm not sure this makes the nvme reset problem much
>> better.  If we allow subsystem resets at all they would still need to
>> be coordinated across 2 devices/drivers to reinitialize pci registers.
>
> I think the simple answer is to not support this device.  It's not like
> Intel doesn't know the AHCI and NVMe specs and had any reaoson to come
> up with a piece of junk like this.

Whatever answer we, in the Linux kernel community, come up with,
leaving storage inaccessible is not an acceptable answer.
