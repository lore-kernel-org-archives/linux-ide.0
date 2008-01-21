From: rgheck <rgheck@bobjweil.com>
Subject: Re: ATA, SATA Disk Problems
Date: Mon, 21 Jan 2008 10:48:10 -0500
Message-ID: <4794BEBA.7060104@bobjweil.com>
References: <478E24EE.2060409@brown.edu> <47945394.7090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:57144
	"EHLO QMTA09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754229AbYAUPzQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 10:55:16 -0500
In-Reply-To: <47945394.7090100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello,
>
> rgheck wrote:
>   
>> Hi, and sorry if this turns out to be a known issue. Actually, I'll be
>> thrilled if this turns out to be a known issue. But I've searched on it
>> forever, and although I've found some information, I've not found a
>> definite fix. Possibly my fault, but this is driving me nuts.
>>
>> System: Asus P5N32E MB, Intel Quad Core; on SATA: two HDs, SATA Pioneer
>> DVD-RW; on PATA: Plextor CDRW, one HD. (Can send more info of course.)
>> Kernel is 2.6.23.9 on Fedora 8.
>> [root@rghquad lyxsvn]# lsmod | grep ata
>> pata_amd               20293  2
>> pata_pdc2027x          17477  0
>> sata_nv                25157  6
>> ata_generic            14405  0
>> libata                114673  4 pata_amd,pata_pdc2027x,sata_nv,ata_generic
>> scsi_mod              145657  5 sr_mod,sg,usb_storage,libata,sd_mod
>>
>> The issue concerns locks ups and other errors that seem to be focused on
>> the optical drives. I'm getting this kind of error:
>> Jan 16 01:33:19 rghquad kernel: ata7.01: exception Emask 0x0 SAct 0x0
>> SErr 0x0 action 0x2 frozen
>> Jan 16 01:33:19 rghquad kernel: ata7.01: cmd
>> a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
>> Jan 16 01:33:19 rghquad kernel: ata7: soft resetting port
>> Jan 16 01:33:19 rghquad kernel: ata7.01: configured for MWDMA2
>> Jan 16 01:33:19 rghquad kernel: ata7: EH complete
>> repeatedly, sometimes with the Plextor, sometimes with the Pioneer. But
>> then things sometimes get worse:
>> Jan 16 01:36:22 rghquad kernel: sr1: CDROM (ioctl) error, command:
>> <6>ata7: EH complete
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_committed_data
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_frozen_data
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_committed_data
>> and it seems as if the whole ATA system locks up. The main drive gets
>> reset to read-only, and, well, things are not then good.
>>
>> The fact that this sometimes happens on SATA and sometimes on PATA
>> suggests its not a cable issue. (That particular case was the Plextor.)
>>
>> Is it worth trying a larger PS? I believe I have 450W in this system.
>>
>> Any help or suggestions more than welcome.
>>     
>
> * Please post full kernel log including boot messages and error messages.
>
> * If you have an extra power supply lying around, connecting some of
> SATA devices to a separate PSU (don't do it for PATA) and seeing whether
> the problem continues and on which devices is a great way to rule out
> power problem.  You can power up a PSU without connecting it to a system
> by...
>
>   http://modtown.co.uk/mt/article2.php?id=psumod
>
>   
Thanks for the reply. I'll try a few things---the PS, and the 2.6.24 
kernel---and post again if I continue to have problems. I'll also try 
the patch you posted to another person having optical drive issues.

Thanks for your work.

rh
   
