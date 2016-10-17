From: Emmanuel Benisty <benisty.e@gmail.com>
Subject: Re: use pci_alloc_irq_vectors issues
Date: Mon, 17 Oct 2016 13:12:09 +0200
Message-ID: <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
 <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com>
 <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com>
 <20161017103442.GA12240@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20161017103442.GA12240@lst.de>
Sender: linux-pci-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 17, 2016 at 12:34 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Oct 17, 2016 at 11:33:03AM +0200, Emmanuel Benisty wrote:
>> Hi Christoph,
>>
>> On Mon, Oct 17, 2016 at 11:26 AM, Christoph Hellwig <hch@lst.de> wrote:
>> > can you run the lspci -vv command as again, but this time as root
>> > user?
>>
>> Please find attached the new file.
>>
>> > Also just to make sure I interpret your report correctly:
>> > The ata3 devices that's creating the problems is the SK-Hynix device,
>> > probably a SSD that shows up as ahci controller?
>>
>> Yep, it's the only drive on this machine, which is indeed a SSD drive.
>
> Thanks.  Still can't make sense of the issue, can you apply the debug
> patch below, and try to caputure the screen output when the ata
> device is beeing probed?

Part 1: http://i.imgur.com/Prq86vT.jpg
Part 2: http://i.imgur.com/EBxV25r.jpg
Part 3: http://i.imgur.com/eBDVVXc.jpg

Thanks
