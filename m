From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Bug 42679] New: DMA Read on Marvell 88SE9128 fails when	Intel's
	IOMMU is on
Date: Mon, 30 Jan 2012 16:41:32 -0500
Message-ID: <4F270E8C.2000406@redhat.com>
References: <bug-42679-27@https.bugzilla.kernel.org/>
	<20120130125934.7971c815.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120130125934.7971c815.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, pawel.zaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 01/30/2012 03:59 PM, Andrew Morton wrote:
>
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> On Sat, 28 Jan 2012 17:55:38 GMT
> bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:
>
>> https://bugzilla.kernel.org/show_bug.cgi?id=42679
>
> I don't know if this is a SATA issue or intel-iommu.  Could you guys
> please take a look?
>
>>             Summary: DMA Read on Marvell 88SE9128 fails when Intel's IOMMU
>>                      is on
>>             Product: Memory Management
>>             Version: 2.5
>>            Platform: All
>>          OS/Version: Linux
>>                Tree: Mainline
>>              Status: NEW
>>            Severity: normal
>>            Priority: P1
>>           Component: Other
>>          AssignedTo: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
>>          ReportedBy: pawel.zaq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>>          Regression: No
>>
>>
>> Created an attachment (id=72217)
>>   -->  (https://bugzilla.kernel.org/attachment.cgi?id=72217)
>> Output of `dmesg' command
>>
>> I have a MSI Z68A-GD80 B3 motherboard and when I try to enable Intel's IOMMU
>> (kernel booted with intel_iommu=on), integrated Marvell 88SE9128 SATA
>> controller doesn't work.
>>
>> To reproduce:
>> 1. Compile and prepare kernel with Intel IOMMU support enabled
>> (CONFIG_INTEL_IOMMU=y).
>> 2. Reboot the computer.
>> 3. Enter BIOS and enable VT-d.
>> 4. Boot the kernel with intel_iommu=on parameter.
>>
>> Right after boot, kernel reports the following errors (SATA controller is at
>> 0b:00.0):
>>
>> [    2.639774] DRHD: handling fault status reg 3
>> [    2.639782] DMAR:[DMA Read] Request device [0b:00.1] fault addr fff00000
>> [    2.639783] DMAR:[fault reason 02] Present bit in context entry is clear
>>
>> After a while these entries appear:
>>
>> [    7.625837] ata14.00: qc timeout (cmd 0xa1)
>> [    7.628341] ata14.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [    7.935483] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [   17.908407] ata14.00: qc timeout (cmd 0xa1)
>> [   17.910935] ata14.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [   17.912276] ata14: limiting SATA link speed to 1.5 Gbps
>> [   18.219077] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>> [   48.134607] ata14.00: qc timeout (cmd 0xa1)
>> [   48.137508] ata14.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> [   48.444646] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>>
>> When there is a disk connected to the controller it does not work. When there
>> are none, computer starts normally, apart from the huge lag caused by,
>> presumably, probing the device.
>>
>> Since this is the secondary controller on these motherboards, to eliminate
>> those symptoms you can just plug disk in one of available ports of the built-in
>> Intel SATA controller and disable Marvell's one using BIOS. The other
>> work-around, if you need to use eSATA capabilities of the latter, is to disable
>> VT-d techonology also using BIOS.
>
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Well, the lspci dump in the bugzilla report doesn't show a device w/BDF=0b:00.1;
so, if the SATA device (which is 0b:00.0) is spitting out 0b:00.1 as the source
of any of its DMA packets, the IOMMU will fault on it, since 0b:00.1 didn't
request DMA mappings (0b:00.0 did).
I semi-recall someone else reporting this 'feature' on this list.
Wonder if pci-quirk has to filter this case (0b:00.0 on this system means
map for 0b:00.0 & 0b:00.1 -- ick!)

do another lspci -vvv to ensure that 0b:00.1 wasn't excluded in the list.
if it doesn't exist, then the problem is the SATA device using an unknown/unrecognized
BDF of 0b:00.1
