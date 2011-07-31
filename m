From: "F. P. Beekhof" <fpbeekhof@gmail.com>
Subject: Re: Machine check exception
Date: Sun, 31 Jul 2011 10:22:41 +0200
Message-ID: <4E3510D1.8010703@gmail.com>
References: <4E2FF0EC.2020704@gmail.com> <20110727130319.GA26923@gere.osrc.amd.com> <4E302F6C.3@gmail.com> <20110727170309.GB26923@gere.osrc.amd.com> <4E307AF3.40109@gmail.com> <4E308360.8080302@gmail.com> <20110728074719.GA16261@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44756 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1GaIWq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Jul 2011 04:22:46 -0400
Received: by wwe5 with SMTP id 5so4710649wwe.1
        for <linux-ide@vger.kernel.org>; Sun, 31 Jul 2011 01:22:44 -0700 (PDT)
In-Reply-To: <20110728074719.GA16261@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@amd64.org>, Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi,

On 07/28/2011 09:47 AM, Borislav Petkov wrote:
> On Wed, Jul 27, 2011 at 11:30:08PM +0200, F. P. Beekhof wrote:
>> Note: after a suspend/resume cycle, the register value is back at 8,
>> so I have to run the commands again to set it to 100008
>>
>> # rdmsr -x 0xc001001f
>> 100008
>> (suspend / resume)
>> # rdmsr -x 0xc001001f
>> 8
>
> Yeah, that's ok for now, just to test whether this fixes your issue. You
> can add the wrmsr call to some post-resume hooks on your system.
>

I've used the hooks to call a script, the value is 100008 after resume, 
and I'm booting the system by going onto 'recovery console', running the 
script to set msr 0xc001001f to 100008, then completing the normal boot 
procedure.

So far, it seems to have fixed the issue, in the sense that there have 
been no MCEs yet. There was some call trace after a suspend/resume (see 
below), but that's it.

I found that one can enable ECC on ram in the bios, which I did. As far 
as I know, this is non-ECC ram, so frankly I'm at a loss about

To provoke MCEs, I've added a firewire card, that I had pulled out 
before. Removing that thing had reduced the number of MCEs, but not 
eliminated them. With a regular boot sequence (no msr setting), the 
radeon driver complained of something and the system froze within 5 
minutes. I then rebooted and followed your instructions, so far the 
system is working perfectly fine.

I've also switched two eSATA on and off a few times, they are detected 
fine now with no crash, and let banshee run. That has frequently proven 
to be too much, but now it is fine.

All of this is no definite proof that all is well, but it certainly 
seems more stable.

Is there anything else I can do ?
Are there any conclusions that can be drawn from this experiment ?

Best,
Fokko


[18297.261773] WARNING: at 
/build/buildd/linux-2.6.38/kernel/power/suspend_test.c:53 
suspend_test_finish+0x86/0x90()
[18297.261775] Hardware name: System Product Name
[18297.261777] Component: resume devices, time: 17880
[18297.261778] Modules linked in: parport_pc ppdev binfmt_misc msr 
snd_via82xx snd_via82xx_modem gameport snd_ac97_codec ac97_bus snd_pcm 
snd_mpu401_uart snd_seq_midi radeon snd_rawmidi snd_seq_midi_event ttm 
drm_kms_helper snd_seq drm snd_timer amd64_edac_mod snd_seq_device 
edac_core i2c_algo_bit snd snd_page_alloc edac_mce_amd lp soundcore 
i2c_viapro k8temp parport shpchp reiserfs usb_storage uas usbhid hid 
firewire_ohci skge sata_via pata_via sata_promise firewire_core 
crc_itu_t raid10 raid456 async_pq async_xor xor async_memcpy 
async_raid6_recov raid6_pq async_tx raid1 raid0 multipath linear
[18297.261815] Pid: 16135, comm: pm-suspend Not tainted 
2.6.38-10-generic #46-Ubuntu
[18297.261817] Call Trace:
[18297.261824]  [<ffffffff81065cbf>] ? warn_slowpath_common+0x7f/0xc0
[18297.261828]  [<ffffffff81065db6>] ? warn_slowpath_fmt+0x46/0x50
[18297.261831]  [<ffffffff810a75d6>] ? suspend_test_finish+0x86/0x90
[18297.261834]  [<ffffffff810a72f7>] ? suspend_devices_and_enter+0xa7/0x160
[18297.261837]  [<ffffffff810a74d5>] ? enter_state+0x125/0x150
[18297.261840]  [<ffffffff810a6936>] ? state_store+0xc6/0x100
[18297.261845]  [<ffffffff812dcb67>] ? kobj_attr_store+0x17/0x20
[18297.261848]  [<ffffffff811d3d4e>] ? sysfs_write_file+0xde/0x160
[18297.261852]  [<ffffffff81164e16>] ? vfs_write+0xc6/0x180
[18297.261855]  [<ffffffff81165131>] ? sys_write+0x51/0x90
[18297.261859]  [<ffffffff8100c002>] ? system_call_fastpath+0x16/0x1b
[18297.261861] ---[ end trace d1b3663bc80e2f9e ]---
[18297.271611] PM: Finishing wakeup.
[18297.271613] Restarting tasks ... done.
