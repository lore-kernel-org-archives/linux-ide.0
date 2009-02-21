From: Wes Shull <wes.shull@gmail.com>
Subject: Re: sata_nv frees DMA memory with different size (possibly a generic
	libata bug)
Date: Sat, 21 Feb 2009 02:57:36 -0700
Message-ID: <d676b7a80902210157l47344e77yb5b36c67e3750ad7@mail.gmail.com>
References: <20090219220901R.fujita.tomonori@lab.ntt.co.jp>
	 <499E1C5B.1050207@gmail.com>
	 <d676b7a80902200320n791d627bt7d9797265629920f@mail.gmail.com>
	 <20090221155724W.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:8550 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZBUJ5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Feb 2009 04:57:38 -0500
Received: by ey-out-2122.google.com with SMTP id 25so211841eya.37
        for <linux-ide@vger.kernel.org>; Sat, 21 Feb 2009 01:57:36 -0800 (PST)
In-Reply-To: <20090221155724W.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: hancockrwd@gmail.com, cebbert@redhat.com, linux-ide@vger.kernel.org

On Fri, Feb 20, 2009 at 11:57 PM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Fri, 20 Feb 2009 04:20:29 -0700
> Wes Shull <wes.shull@gmail.com> wrote:
>
>> On Thu, Feb 19, 2009 at 7:58 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
>> > FUJITA Tomonori wrote:
>> >>
>> >> On Wed, 18 Feb 2009 17:05:44 -0500
>> >> Chuck Ebbert <cebbert@redhat.com> wrote:
>> >>
>> >>> On Wed, 18 Feb 2009 15:25:16 -0500
>> >>> Chuck Ebbert <cebbert@redhat.com> wrote:
>> >>>
>> >>>> On Tue, 17 Feb 2009 20:22:05 +0900
>> >>>> FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
>> >>>>
>> >>>>
>> >>>>>>>>>
>> >>>>>>>>> sata_nv 0000:00:0d.0: DMA-API: device driver frees DMA memory with
>> >>>>>>>>> different
>> >>>>>>>>> size [device address=0x00000000da031000] [map size=4096 bytes]
>> >>>>>>>>> [unmap
>> >>>>>>>>
>> >>>>>>>> That's rather curious. It seems to be saying that the sg length is
>> >>>>>>>> different between the map and unmap, but it doesn't look like sata_nv mucks
>> >>>>>>>> with that anywhere, and neither does libata core..
>> >>>>>>>
>> >>>>>>> Could the SCSI code have merged two requests?
>> >>>>>>
>> >>>>>> I wouldn't think so.. and if it did it seems like it would have to
>> >>>>>> have changed the list after libata got the request somehow..
>> >>>>>
>> >>>>> Does this box uses GART IOMMU?
>> >>>>
>> >>>> I don't think so, but I've asked for the dmesg.
>> >>>
>> >>> Okay, it _is_ using GART IOMMU:
>> >>>
>> >>> DMA-API: preallocated 8192 debug entries
>> >>> DMA-API: debugging enabled by kernel config
>> >>> PCI-DMA: Disabling AGP.
>> >>> PCI-DMA: aperture base @ 20000000 size 65536 KB
>> >>> PCI-DMA: using GART IOMMU.
>> >>> PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
>> >>
>> >> Thanks, that makes sense.
>> >>
>> >> I think that the following patch could fix this:
>> >>
>> >> http://marc.info/?l=linux-ide&m=123484533504307&w=2
>> >
>> > The patch looks reasonable to me. I'm CCing the reporter of the bug. Wes,
>> > would you be able to test out Fujita's patch linked above?
>>
>> I grabbed the srpm for the fedoraized 2.6.29-0.137.rc5.git4 from koji,
>> applied the patch, and tested--no joy, I'm still getting the warning.
>> Would there be any value to me trying this with a vanilla+dma-debug
>> kernel build?
>>
>> Tomorrow I'm going to bump up the show_num_errors (currently at 1) in
>> the dma debug patch to see if maybe that produces anything else
>> interesting;
>
> I think that probably it's not interesting much. Once you get a
> dma-debug error, the later errors are not reliable.
>
> For example, dma-debug finds a dma-debug error about a NIC, you could
> get false dma-debug errors about even good device drivers.
>
>
>> I've already got another bug that races with nv_sata to
>> get that first warning (in forcedeth, so you probably don't care, but
>> if so see https://bugzilla.redhat.com/show_bug.cgi?id=484494 ).
>
> As I explained above, you can't have other dma-debug error source. Can
> you test only nv_sata with my patch again?

Ok, I blocked forcedeth from loading, rebooted (still running the
kernel I built with your patch--despite these warning messages, it's
100% stable in all my testing), verified that forcedeth hadn't
loaded...  but I still got the nv_sata warning.  So that's not it
either :(
