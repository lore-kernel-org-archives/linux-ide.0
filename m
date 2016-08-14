From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: Regression - SATA disks behind USB ones on v4.8-rc1, breaking
 boot. [Re: Who reordered my disks (probably v4.8-rc1 problem)]
Date: Sun, 14 Aug 2016 10:53:53 +0000
Message-ID: <CAGnHSEnwQ-sTMnKaZBGD-n2vu83B5nnWTugO9+44oq7dnVOztw@mail.gmail.com>
References: <20160813190340.GA29989@amd> <20160814092044.GA20392@amd>
 <CAGnHSEmtgGO5QjfamnN0VPOO2w-4GrZQvPnbkBVdtWBPTnLieA@mail.gmail.com>
 <20160814100102.GA31847@amd> <CAGnHSEm-Gww1-bmqZMz6guFDnByUuCFiCLhdrK_LETBH3qcb1Q@mail.gmail.com>
 <CAGnHSEnXo8VRm5Y6S6axpe-hG6an8ceujLajbZmxbGGDnCGh2w@mail.gmail.com> <alpine.DEB.2.02.1608140322400.9045@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1608140322400.9045@nftneq.ynat.uz>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lang <david@lang.hm>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, james harvey <jamespharvey20@gmail.com>, regressions@leemhuis.info, hdegoede@redhat.com, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-ide@vger.kernel.org

Btw, why hasn't this been CC'd to linux-scsi at the very least? The
SCSI disk (sd) driver is obviously the sociopath here. It should
really differentiate disks from libata and usb-storage/uas, and wait
for at least a minute to see if there's gonna be an ATA drive popping
up before enumerating disks from the latter. Sociopaths like me that
put the root filesystem on an UAS drive should really be ignored.
Wait, there's NVMe! Problem solved.

On 14 August 2016 at 10:26, David Lang <david@lang.hm> wrote:
> On Sun, 14 Aug 2016, Tom Yan wrote:
>
>> On 14 August 2016 at 18:07, Tom Yan <tom.ty89@gmail.com> wrote:
>>>
>>> On 14 August 2016 at 18:01, Pavel Machek <pavel@ucw.cz> wrote:
>>>>
>>>>
>>>> Since SATA support was merged, certainly since v2.4, and from way
>>>> before /dev/disk/by-id existed.
>>>
>>>
>>> I have no idea how "SATA before USB" had been done in the past (if it
>>> was ever a thing in the kernel), but that has not been the case since
>>> at least v3.0 AFAIR.
>>>
>>>>
>>>> People may not run udev, and you can't use /dev/disk/by-id on kernel
>>>> command line.
>>>>
>>>
>>> No, but you can always use root=PARTUUID=, that's built into the
>>> kernel. (root=UUID= requires udev or so though).
>>
>>
>> Silly me. root=UUID= has nothing to do with udev, but `blkid` in
>> util-linux. At least that's how it's done in Arch/mkinitcpio.
>>
>
> The rule is "don't break working systems", not "but we are allowed to break
> systems, see it says here not to depend on this"
>
> Drive ordering has been stable since the 0.1 kernel [1]
>
> It takes a lot longer to detect USB drives, why in the world would they be
> detected before hard-wired drives?
>
> I expect that Linus' response is going to be very quotable.
>
> David Lang
>
>
> [1] given stable hardware and no new drivers becoming involved
