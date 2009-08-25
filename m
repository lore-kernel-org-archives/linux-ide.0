From: Grant Grundler <grundler@google.com>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
	working
Date: Tue, 25 Aug 2009 15:28:17 -0700
Message-ID: <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>
	 <4A8242C5.3060605@gmail.com>
	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>
	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>
	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>
	 <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>
	 <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd14bf6d741d50471fed906
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:46571 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbZHYW2U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Aug 2009 18:28:20 -0400
Received: from spaceape23.eur.corp.google.com (spaceape23.eur.corp.google.com [172.28.16.75])
	by smtp-out.google.com with ESMTP id n7PMSLw8026933
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2009 23:28:21 +0100
Received: from pzk13 (pzk13.prod.google.com [10.243.19.141])
	by spaceape23.eur.corp.google.com with ESMTP id n7PMSEJx001057
	for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2009 15:28:18 -0700
Received: by pzk13 with SMTP id 13so257195pzk.25
        for <linux-ide@vger.kernel.org>; Tue, 25 Aug 2009 15:28:18 -0700 (PDT)
In-Reply-To: <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris K <kayex@rogers.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

--000e0cd14bf6d741d50471fed906
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Chris,
Sorry for the long delay.

On Tue, Aug 18, 2009 at 2:54 PM, Chris K<kayex@rogers.com> wrote:
...
>> Can you confirm the OS is seeing as a 3726?

The later output you posted confirmed this.

>> Add a printk to dump SATA_PMP_GSCR_PROD_ID to the console
>> similar to how it's done in sata_pmp_revalidate_quick(). =C2=A0Or if dev=
->gscr[]
>> is already valid, printk dev->gscr[SATA_PMP_GSCR_PROD_ID]. This
>> assumesyou know how to build/install a kernel from a source tree.
>> Tell me if that's a bad assumption. :)
>
> How about generous assumption ;-) =C2=A0Could you elaborate on the steps
> for this? I should be able to figure it out with a bit more info on
> the process.

The kernel build process is in general steps very simple:
o download the latest stable kernel source from www.kernel.org
o unpacked the source (e.g. tar xzf linux-2.6.*.tar.bz2)
o cd linux-2.6.*
o cp /boot/
o make
o sudo make modules_install
o sudo make install

and check the boot loader (grub likely) knows vmlinuz (not vmlinux) is
installed.
Also need to look if an initrd is also needed. "man mkinitramfs" should hel=
p
build the initrd if "make install" isn't automagically doing that.


Then to "dump SATA_PMP_GSCR_PROD_ID", one needs to add a printk to
the libata layer. I've attached a patch to libata_pmp.c as a simple example=
.
Apply the patch with "patch -p1 < patchname". See
Documentation/SubmittingPatches
on how to a submit/apply patches.

>>
>> ISTR some very early 3726 devices reported themselves as 4726 or
>> something like that.
>> This can affect which sata_pmp_quirks() are applied.
>
> I noticed this line in the dmesg, does this confirm if it's reporting
> the right model properly?
> "ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9"

Yes.

>
>>
>> BTW, the full dmesg output attached to the original mail never made it
>> to linux-ide mailing list...can you attach or post it someplace public?
>
> Yes, you can find my dmesg @ http://pastebin.com/f50585886

Thanks!

>
> Not sure if you saw this part before too - This is the output I get on
> the screen during boot:
>
> [59719.989422] ata7: irq_stat 0x01100010, PHY RDY changed
> [59719.989477] ata7: SError: { 10B8B }
> [59722.781043] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe fr=
ozen
> [59722.781112] ata7: irq_stat 0x00b40090, PHY RDY changed
> [59791.300259] ata7.15: failed to write PMP_FEAT_EN (Emask=3D0x40)
> [59791.300324] ata7: failed to recover PMP after 5 tries, giving up
> [59791.300323] ata7: exception Emask 0x3 SAct 0x0 SErr 0x0 action 0x6 fro=
zen t4
> [59791.300483] ata7: irq_stat 0x00060002, device error via D2H FIS

The "6 ports" is the clue I was looking for.

[    7.080266] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6
ports, feat 0x1/0x9
[    7.080531] ata7.00: hard resetting link
[    7.430307] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    7.430311] ata7.01: hard resetting link
[    7.780305] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    7.780309] ata7.02: hard resetting link
[    8.130305] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.130310] ata7.03: hard resetting link
[    8.480305] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    8.480310] ata7.04: hard resetting link
[    8.830317] ata7.04: SATA link down (SStatus 0 SControl 320)
[    8.830321] ata7.05: hard resetting link
[    9.180232] ata7.05: failed to read SCR 1 (Emask=3D0x1)
[    9.180233] ata7.05: failed to read SCR 0 (Emask=3D0x40)

I don't believe port ata7.05 exists. AFAIK,  sil3736 only has 5 ports (0 to=
 4).
One of the quirks isn't applying or needs to be added to the kernel.
I don't recall what the psuedo port is for but Tejun or "Sans Digital
TRM4-B" vendor might know.

I think this comment in libata-pmp.c might be relevant:
     /* port 5 is for SEMB device and it doesn't like SRST */

But it looks like port 5 isn't responding at all. You might add a hack to c=
hange
"6" to "5" inside the "sil3726 quirks" code chunk.

I would expect the "SEMB" device to respond but perhaps it needs more time
or some other magic that linux doesn't know in order to initialize.

...
> LED 1 takes about 2-3 seconds.. the other LEDs are lit very quickly
> one after another.
>
>> If CONFIG_PRINTK_TIME=3Dy, the dmesg output should let me figure this ou=
t.
>>
>
> This seems to be enabled already with my current kernel.

Yup - it is.

>> Can you add debug code to dump how many ports the PMP claims to have?
>> I'm wondering if a "ghost port" (magic "port" which doesn't have a SATA =
link but
>> some magic registers instead) is discovered/reported.
>>
>
> I can sure try! What should I do to enable this?

The console output about "6 ports" already tells us this. But the
patch below will tell us again. :)

hth,
grant

--000e0cd14bf6d741d50471fed906
Content-Type: application/octet-stream;
	name="diff-2.6.30.4-libata_pmp_printk-01"
Content-Disposition: attachment;
	filename="diff-2.6.30.4-libata_pmp_printk-01"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyt69bl50

LS0tIGxpbnV4LTIuNi4zMC40L2RyaXZlcnMvYXRhL2xpYmF0YS1wbXAuYy1PUklHCTIwMDktMDgt
MjUgMTQ6NTA6MjIuMDAwMDAwMDAwIC0wNzAwCisrKyBsaW51eC0yLjYuMzAuNC9kcml2ZXJzL2F0
YS9saWJhdGEtcG1wLmMJMjAwOS0wOC0yNSAxNDo0OTowNC4wMDAwMDAwMDAgLTA3MDAKQEAgLTIz
OCw2ICsyMzgsMTAgQEAKIAogCW5yX3BvcnRzID0gc2F0YV9wbXBfZ3Njcl9wb3J0cyhnc2NyKTsK
IAorcHJpbnRrKCJsaWJhdGEtcG1wOiBQUk9ESUQgMHgleCAgUG9ydHMgJWRcbiIsCisJCWdzY3Jb
U0FUQV9QTVBfR1NDUl9QUk9EX0lEXSwKKwkJbnJfcG9ydHMpOworCQogCWlmIChucl9wb3J0cyA8
PSAwIHx8IG5yX3BvcnRzID4gU0FUQV9QTVBfTUFYX1BPUlRTKSB7CiAJCXJjID0gLUVJTlZBTDsK
IAkJcmVhc29uID0gImludmFsaWQgbnJfcG9ydHMiOwo=
--000e0cd14bf6d741d50471fed906--
