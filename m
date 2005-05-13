From: "Grahame Jordan" <gbj@theforce.com.au>
Subject: Re: ide-tape oops
Date: Fri, 13 May 2005 23:04:27 +1000 (EST)
Message-ID: <34290.203.18.20.1.1115989467.squirrel@webmail.theforce.com.au>
References: <7619.202.12.233.21.1110421544.squirrel@webmail.theforce.com.au>
      <422FD9D5.5010509@osdl.org>
    <38831.203.20.16.2.1110536569.squirrel@webmail.theforce.com.au>
    <42338142.3000202@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050513230427_49247"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yoda.netcore.com.au ([203.18.21.12]:63941 "EHLO
	ob1.theforce.com.au") by vger.kernel.org with ESMTP id S262355AbVEMNEr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 May 2005 09:04:47 -0400
In-Reply-To: <42338142.3000202@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-ide@vger.kernel.org

------=_20050513230427_49247
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Randy,

I have finally revisited this.

The problem was happening because ide-generic was not loaded. I guess that
some symbol should be exported to make this load anyway.

Anyway to stop the oops I have provided a little patch.


Thanks for your help

Grahame Jordan




> Grahame Jordan wrote:
>> Randy,
>>
>> Applied patch and get:
>>
>> Mar 11 21:02:37 hanlay -- MARK --
>> Mar 11 21:08:45 hanlay kernel: ide-tape-open-test: using minor = 0, i =
>> 0,
>> drive = 0x00000000
>> Mar 11 21:08:45 hanlay kernel: f8917470
>> Mar 11 21:08:45 hanlay kernel: PREEMPT SMP
>> ...
>>
>> Does not look like it is getting attached.
>
> Right, I have no idea why.  Don't really know anything about this
> driver.  However, if you want to find out why, here's a small
> patch that should tell us more...
>
>
>> Should this module taint the kernel?
>> Mar 11 15:22:41 hanlay kernel: ide_tape: no version for "struct_module"
>> found: kernel tainted.
>
> It appears that your kernel .config file contains
> CONFIG_MODVERSIONS=y
> but this module does not contain any versioning data.
>
> Was this module built at the same time as the rest of the
> kernel?  and with the same config options?
>
>
>> Cheers
>>
>> Grahame Jordan
>>
>>
>>>Grahame Jordan wrote:
>>>
>>>>Hi,
>>>>
>>>>I have a machine on which when I run something like mt -f /dev/ht0
>>>>status
>>>>it seg faults. However I have another machine same spec that works OK?
>>>>
>>>>Any help would be appreciated
>>>>
>>>
>>><drive> is null in idetape_chrdev_open.
>>>Please apply and test with the attached patch, just to try to
>>>find out what is going one.
>>>
>>>
>>>>Debian testing
>>>>Linux hanlay 2.6.8-2-686-smp #1 SMP Mon Jan 24 02:32:52 EST 2005 i686
>>>>GNU/Linux
>>>>P4 3.2GHz
>>>>1GB RAM
>>>>
>>>> <6>i2c /dev entries driver
>>>>Unable to handle kernel NULL pointer dereference at virtual address
>>>>00000020
>>>> printing eip:
>>>>f891744e
>>>>*pde = 00000000
>>>>Oops: 0000 [#3]
>>>>PREEMPT SMP
>>>>Modules linked in: i2c_dev i2c_i801 i2c_core tsdev mousedev psmouse
>>>> ipv6
>>>>snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport
>>>>snd_mpu401_uart snd_rawmidi snd_seq_device snd hw_random shpchp pciehp
>>>>pci_hotplug intel_agp intel_mch_agp agpgart evdev ehci_hcd eth1394
>>>>uhci_hcd usbcore i810_audio ac97_codec soundcore piix sk98lin ohci1394
>>>>capability commoncap ide_tape sbp2 ieee1394 ide_cd ide_core genrtc ext2
>>>>ext3 jbd mbcache sr_mod cdrom sd_mod sata_promise ata_piix libata
>>>>scsi_mod
>>>>unix font vesafb cfbcopyarea cfbimgblt cfbfillrect
>>>>CPU:    0
>>>>EIP:    0060:[<f891744e>]    Not tainted
>>>>EFLAGS: 00010297   (2.6.8-2-686-smp)
>>>>EIP is at idetape_chrdev_open+0x3e/0x190 [ide_tape]
>>>>eax: 00000000   ebx: 00000000   ecx: f738d440   edx: fffffffa
>>>>esi: 00000000   edi: cb534000   ebp: f7642380   esp: cb535dac
>>>>ds: 007b   es: 007b   ss: 0068
>>>>Process mt (pid: 7038, threadinfo=cb534000 task=f7005210)
>>>>Stack: f738b51c f7642380 0000000f 00000001 00000286 00000000 00000132
>>>>f7b2ac00
>>>>       f756cd9c 422faee6 24eb6ec0 f756cdd8 cb457400 cb457404 40165000
>>>>c1000000
>>>>       c014de6b c1169f40 422faee6 24eb6ec0 00000000 c02de380 00000282
>>>>00000246
>>>>Call Trace:
>>>> [<c014de6b>] zap_pte_range+0x3b/0x2d0
>>>> [<c0142a56>] buffered_rmqueue+0x116/0x230
>>>> [<c0142e80>] __alloc_pages+0x310/0x370
>>>> [<c013e2bb>] find_get_page+0x3b/0x70
>>>> [<c013f5b9>] filemap_nopage+0x229/0x3c0
>>>> [<c0179cf1>] dput+0x31/0x270
>>>> [<c016fe4e>] link_path_walk+0xc2e/0x1020
>>>> [<c014d9ee>] pte_alloc_map+0xae/0x100
>>>> [<c016ebf7>] permission+0x67/0x80
>>>> [<c016a453>] cdev_get+0x53/0xb0
>>>> [<c016a0a5>] chrdev_open+0x125/0x290
>>>> [<c0160931>] get_empty_filp+0x71/0x110
>>>> [<c015ec2a>] dentry_open+0x16a/0x260
>>>> [<c015eab8>] filp_open+0x68/0x70
>>>> [<c015ed69>] get_unused_fd+0x49/0x100
>>>> [<c015ef9b>] sys_open+0x5b/0x90
>>>> [<c01061fb>] syscall_call+0x7/0xb
>>>>Code: 8b 5e 20 89 b5 80 00 00 00 f0 0f ba ab fc 18 00 00 02 19 c0
>
>
> --
> ~Randy
>

------=_20050513230427_49247
Content-Type: application/octet-stream; name="ide-tape_catch_nul_dev.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-tape_catch_nul_dev.patch"

CmlkZS10YXBlOiBjYXRjaCBudWxsIGRldmljZQoKU2lnbmVkLW9mZi1ieTogR3JhaGFtZSBKb3Jk
YW4gPGdiakB0aGVmb3JjZS5jb20uYXU+CgotLS0gZHJpdmVycy9pZGUvaWRlLXRhcGUuYwkyMDA1
LTA1LTEzIDIyOjMxOjUwLjAwMjY1MjQ4MCArMTAwMAorKysgZHJpdmVycy9pZGUvaWRlLXRhcGUu
Yy1jYXRjaF9udWxsX2RldgkyMDA1LTA1LTEzIDIyOjI5OjE5LjU4MDUyMDEyMCArMTAwMApAQCAt
NDE4Niw2ICs0MTg2LDExIEBAIHN0YXRpYyBpbnQgaWRldGFwZV9jaHJkZXZfb3BlbiAoc3RydWN0
IGkKIAlpZiAoaSA+PSBNQVhfSFdJRlMgKiBNQVhfRFJJVkVTKQogCQlyZXR1cm4gLUVOWElPOwog
CWRyaXZlID0gaWRldGFwZV9jaHJkZXZzW2ldLmRyaXZlOworCWlmKGRyaXZlID09IE5VTEwpCisJ
eworCQlwcmludGsoS0VSTl9FUlIgImlkZS10YXBlOiBkcml2ZSA9PSBOVUxMXG4iKTsKKwkJcmV0
dXJuIC1FTlhJTzsKKwl9CiAJdGFwZSA9IGRyaXZlLT5kcml2ZXJfZGF0YTsKIAlmaWxwLT5wcml2
YXRlX2RhdGEgPSBkcml2ZTsKIAo=
------=_20050513230427_49247--


