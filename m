From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: which version/patch to test?
Date: Sat, 12 May 2007 22:20:32 +0200
Message-ID: <46462190.6070005@how.dk>
References: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:56949 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637AbXELUU6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 May 2007 16:20:58 -0400
In-Reply-To: <200705121504.l4CF4u83028056@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

I have now tested with 2.6.21-git16 with the same result: sda and sdd 
froze after copying 1.7GB and 2.7GB respectively.

Here is dmesg output:
[   59.070670] sata_promise 0000:01:08.0: version 2.07
<stuff deleted>
[  402.136295] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[  402.136309] ata1.00: cmd c8/00:00:00:24:32/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 131072 in
[  402.136311]          res 40/00:28:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  402.448197] ata1: device not ready (errno=-19), forcing hardreset
[  402.448205] ata1: hard resetting port
[  402.923916] ata1: COMRESET failed (errno=-19)
[  402.923924] ata1: reset failed (errno=-19), retrying in 10 secs
[  412.444021] ata1: hard resetting port
[  412.919420] ata1: COMRESET failed (errno=-19)
[  412.919428] ata1: reset failed (errno=-19), retrying in 10 secs
[  422.439142] ata1: hard resetting port
[  422.914928] ata1: COMRESET failed (errno=-19)
[  422.914937] ata1: reset failed (errno=-19), retrying in 35 secs
[  437.712320] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
action 0x2 frozen
[  437.712334] ata4.00: cmd c8/00:00:00:51:51/00:00:00:00:00/e0 tag 0 
cdb 0x0 data 131072 in
[  437.712337]          res 40/00:28:00:00:00/00:00:00:00:00/00 Emask 
0x4 (timeout)
[  438.024173] ata4: device not ready (errno=-19), forcing hardreset
[  438.024182] ata4: hard resetting port
[  438.499939] ata4: COMRESET failed (errno=-19)
[  438.499948] ata4: reset failed (errno=-19), retrying in 10 secs
[  448.019661] ata4: hard resetting port
[  448.495452] ata4: COMRESET failed (errno=-19)
[  448.495461] ata4: reset failed (errno=-19), retrying in 10 secs
[  457.423447] ata1: hard resetting port
[  457.899232] ata1: COMRESET failed (errno=-19)
[  457.899240] ata1: reset failed, giving up
[  457.899243] ata1.00: disabled
[  457.899256] ata1: EH complete
[  457.899541] sd 1:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  457.899548] end_request: I/O error, dev sda, sector 3286016
[  457.899553] Buffer I/O error on device sda, logical block 410752
[  457.899558] Buffer I/O error on device sda, logical block 410753
[  457.899561] Buffer I/O error on device sda, logical block 410754
[  457.899564] Buffer I/O error on device sda, logical block 410755
[  457.899567] Buffer I/O error on device sda, logical block 410756
[  457.899570] Buffer I/O error on device sda, logical block 410757
[  457.899574] Buffer I/O error on device sda, logical block 410758
[  457.899577] Buffer I/O error on device sda, logical block 410759
[  457.899580] Buffer I/O error on device sda, logical block 410760
[  457.899583] Buffer I/O error on device sda, logical block 410761
[  457.899652] sd 1:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  457.899656] end_request: I/O error, dev sda, sector 3286272
[  457.901641] sd 1:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  457.901650] end_request: I/O error, dev sda, sector 3286016
[  457.903095] sd 1:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
[  457.903106] end_request: I/O error, dev sda, sector 3286016
[  458.015257] ata4: hard resetting port
[  458.490969] ata4: COMRESET failed (errno=-19)
[  458.490978] ata4: reset failed (errno=-19), retrying in 35 secs
[  492.999475] ata4: hard resetting port
[  493.475271] ata4: COMRESET failed (errno=-19)
[  493.475278] ata4: reset failed, giving up
[  493.475281] ata4.00: disabled
[  493.475295] ata4: EH complete
[  493.475752] sd 4:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  493.475758] end_request: I/O error, dev sdd, sector 5329152
[  493.475762] printk: 56 messages suppressed.
[  493.475766] Buffer I/O error on device sdd, logical block 666144
[  493.475771] Buffer I/O error on device sdd, logical block 666145
[  493.475775] Buffer I/O error on device sdd, logical block 666146
[  493.475778] Buffer I/O error on device sdd, logical block 666147
[  493.475781] Buffer I/O error on device sdd, logical block 666148
[  493.475785] Buffer I/O error on device sdd, logical block 666149
[  493.475788] Buffer I/O error on device sdd, logical block 666150
[  493.475863] sd 4:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  493.475867] end_request: I/O error, dev sdd, sector 5329408
[  493.476664] sd 4:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  493.476669] end_request: I/O error, dev sdd, sector 5329152
[  493.477841] sd 4:0:0:0: [sdd] Result: hostbyte=0x04 driverbyte=0x00
[  493.477845] end_request: I/O error, dev sdd, sector 5329152

Next I'll try with the 1.5Gbps patch...

BR Peter

Mikael Pettersson wrote:
> On Thu, 10 May 2007 21:41:32 +0200, Peter Favrholdt wrote:
>> I would like to help by testing the most recent version of the 
>> sata_promise driver on my
>>
>> Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
>>
>> with 4 Seagate 500GB ES drives:
>>         Model Number:       ST3500630NS
>>         Firmware Revision:  3.AEE
>>         (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
>>
>> This setup experienced a problem a while ago which was fixed using 
>> 2.6.21-rc2 + Mikael Petterssons "force 1.5Gbps patch".
>>
>> Could someone provide a hint on what sources/patches I should get?
>>
>> E.g. vanilla 2.6.21.1 + ?
> 
> For a SATA 300 TX4 you should test version 2.07 of sata_promise.c.
> You can get it in 2.6.21-git16, or 2.6.21-mm2 plus the following
> two patches:
> 
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-error_intr-abort_port-2.6.21-mm2
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-sataii-tx4-port-numbering-fix-2.6.21-mm2
> 
> or 2.6.21 plus the following three patches:
> 
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-1-separate-sata-pata-ops-2.6.21
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-2-error_intr-2.6.21
> http://user.it.uu.se/~mikpe/linux/patches/2.6/patch-sata_promise-3-sataii-tx4-port-numbering-fix-2.6.21
> 
> Note that this corrects the longstanding mis-enumeration
> of ports on SATAII TX4 cards, so you may need to adjust
> your /etc/fstab and boot-time root= parameter if you're
> using hard-coded partition names.
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
