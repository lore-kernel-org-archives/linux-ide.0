From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Date: Tue, 21 Jan 2014 09:54:38 +0800
Message-ID: <CAJtEV7b5MKn7JshUjhVH-fmiQcD-AZR6-YSCrdUhb+8-KMM0JA@mail.gmail.com>
References: <CAJtEV7ZsM2YHHETRGNwXnGi7uq0mJen73i-Yp3EXoDrnni=o=g@mail.gmail.com>
	<20140120233543.15159.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140120233543.15159.qmail-FT9nftu9LUyCkawlElnc8EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 21, 2014 at 7:35 AM, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org> wrote:
> I'm looking over the bug reports, and I'm trying to understand why you
> need two mechanisms.  You have one table (pci_dev_dma_source_map)
> that maps one devfn to a secondary one, and a second table
> (pci_dev_dma_multi_source_map) that gives a 2-bit bitmap of function
> numbers.
I haven't found a simple way to combine the two maps that still makes
the two distinct problems apparent.
pci_dev_dma_multi_source_map deals with devices that use multiple
functions, but the correct device number.
pci_dev_dma_source_map deals with devices that use a single incorrect
devfn that's mangled in both device and function numbers.

> But as I understand it, all the Marvell devices listed there always have
> a devfn of 00.0, so you could just move them to the first table with a
> mapping to 00.1.
>
> If they also have device/function 00.1 using a requester ID of 00.0
> you could add a second entry.
>
> The only time you'd need a bitmap would be if the device ended up on
> function 2 or higher and still used functions 0 and 1 in request IDs.

Sure, that sounds reasonable and certainly needs to be considered, but
since there's no complete record of what devices get this wrong and
how they get this wrong, I wanted to
* show all requester ids are used for each device in a concise entry,
* build up as much of a record of this problem as possible (hence the
comments and bug references),
* make it easy to see the general problem and have this discussion,
* not make assumptions about which functions would be visible and
which requester ids are actually used (like a device showing up at
00.0 that uses 00.1 and 00.2 only).

Who knows what will show up when iommu is turned on by default again.

> Now, unfortunately this does not cover the phantom functions case, but
> that could be done with separate code.
>
>
> The other question is when to do the lookup.  I don't know how often
> IOMMU mapping is done, and if linear search through a list of PCI devices
> would be a performance problem.  It would be nicer to have a standard
> PCI fixup done once which sets a flag in the pci_dev to either note the
> actual secondary devfn, or set a flag to trigger the secondary lookup
> only on the devices that need it.

Yes, I'd also like to hear what the gatekeepers think about this.

Thanks,

a.
