From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Quirk for buggy dma source tags with Intel IOMMU.
Date: Tue, 21 Jan 2014 10:52:03 +0800
Message-ID: <CAJtEV7YBr69iHHFZ7PNzZH_Hhu5HuM0ifOnzhr+GyzGqgErT4g@mail.gmail.com>
References: <CAJtEV7bkfB=REaJkf+jb33_2h=_5YoZogQNw4SKmmWwZcF8NZA@mail.gmail.com>
	<20140121020042.29941.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140121020042.29941.qmail-FT9nftu9LUyCkawlElnc8EEOCMrvLtNR@public.gmane.org>
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

On Tue, Jan 21, 2014 at 10:00 AM, George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org> wrote:
> New recipient: Alex Williamson, who added the pci_get_dma_source()
> quirk that resembles this one.
>
> Alex, Andrew is working on a patch to fix some more buggy
> PCIe devices like the Ricoh ones that you added a quirk for.
>
> His current patch can be found at
>
> https://bugzilla.kernel.org/show_bug.cgi?id=42679#c22
>
> Ir only works on Intel IOMMUs, and sort of duplicates the functionality
> of your quirk.
>
> Obviously, I hate the duplication and would like to fold them together,
> but there are a few fundamental differences.

Hang on! The existing quirk only worked for vfio groups last time I
checked and didn't actually solve the problem for using the device on
the host.

Alex had done a bunch of work to support requester id quirks (see
http://marc.info/?l=linux-pci&m=137357663626523&w=3), but that seems
blocked.

> Most notably, Andrew's patch enables the incorrect requester ID
> *in addition to* the correct one.  I'm not sure if this is necessary,
> but it seems like a nice defensive feature in case the vendor fixes
> the problem in a minor rev, and the ability is also needed by PCIe
> phantom function support,
>
> The other thing is that pci_get_dma_source returns a pci_dev, but
> Andrew's patch deals with devices which use requester IDs which
> don't correspond to existing PCI devices at all:
>
> - Marvell SATA controllers which exist only as devid 00.0, but generate
>   request devids of 00.1.  (The latter function might be PATA support
>   on chips which support that.)

No, I can prove that both .0 and .1 are used on the 9172 controller,
depending on which of the two SATA port(s) is(are) in use. If you have
the same hardware, I suggest you verify this.

> - Mellanox 26428 Infiniband controllers which also only provide one
>   function, but use a source devid of 00.6
> - An LSI MegaRAID SAS 2078 PCI-X controller that is device 0e.0, but
>   generates request devids of 08.0
> - An Adaptec RAID controller ie 0e.0 that makes requests as 01.0.
>
> My thought for implementing Andrew's version was to add an 8-bit devfn_quirk
> field to struct pci_dev that contains the delta to the devfn that will
> appear in the source requester ID.
>
> (By using a delta rather than the target value, the default value of 0
> means "no quirk".)
>
> This would be initialized at boot time using a standard PCI quirk,
> avoiding the need for linearly searching potentially long device lists
> every time an IOMMU mapping is set up.
>
> (Even if I only use a single-bit flag, that would avoid the list
> searching for all the non-buggy devices.)
>
>
> But I'm not quite sure what the locking rules are on the whole swap_pci_ref
> business.  Or if the Ricoh devices have to be handled more carefully
> because multiple functions need to arbitrate over the IOMMU tables
> for function 0.

The Ricoh firewire function simply uses the wrong requester ID. The
other functions work correctly. Remapping only the firewire specific
function of the multifunction device (as in my patch) fixes the
problem.

a.
