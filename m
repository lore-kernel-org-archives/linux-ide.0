From: Yan Seiner <yan@seiner.com>
Subject: Re: [PATCH] sata_nv: sgpio for nvidia mcp55 -v2
Date: Thu, 22 Jan 2009 19:18:22 -0800
Message-ID: <497936FE.5040809@seiner.com>
References: <20061031104055.GA8898@infradead.org>    <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>    <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com>    <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com>    <4972F4E5.3030203@kernel.org> <49768355.4040301@kernel.org>    <49773189.6050009@seiner.com> <49776DFB.8090506@kernel.org>    <4977FA12.6050103@seiner.com> <4977FF09.50808@kernel.org> <a20f505b0186b360ea9eecefba08aceb.squirrel@www.datavault.us> <4978AC29.8080308@kernel.org> <49792115.1070803@seiner.com> <4979242D.2010309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:39252 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572AbZAWDSY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 22:18:24 -0500
In-Reply-To: <4979242D.2010309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>, linux-ide@vger.kernel.org

Yinghai Lu wrote:
> Yan Seiner wrote:
>   
>> To recap, I've applied the latest patch (-v3) that's supposed to make
>> the SGPIO work.  I am using a LIB-700 backplane from Norco:
>>
>> http://www.ipcdirect.net/servlet/Detail?no=75
>> http://www.norco.net.cn/UpLoadFile/Datasheet/DS-600S-EN.pdf
>>
>> The disk activity LEDs stay lit all the time.
>>
>> I am running a vanilla kernel, not a debian kernel,. although it was
>> built using debian's kbuild.
>>
>> title           Debian GNU/Linux, kernel 2.6.28.1
>> root            (hd0,1)
>> kernel          /vmlinuz-2.6.28.1 root=/dev/md0 ro debug
>> initrd          /initrd.img-2.6.28.1
>>
>> log files are at
>>
>> http://seiner.com/sata_nv/syslog
>> http://seiner.com/sata_nv/dmesg.log
>>     
>
> [   19.306367] sata_nv 0000:00:05.0: PCI INT A -> Link[APSI] -> GSI 23 (level, low) -> IRQ 23
> [   19.306472] sata_nv 0000:00:05.0: Using SWNCQ mode
> [   19.306895] sata_nv 0000:00:05.0: setting latency timer to 64
> [   19.311020] scsi5 : sata_nv
>
>
> it seems that your system HW is not using SGPIO...
> my setup has more print out...
>   
selene:/home/www/seiner/html/sata_nv# modinfo sata_nv
filename:       /lib/modules/2.6.28.1/kernel/drivers/ata/sata_nv.ko
version:        3.5
license:        GPL
description:    low-level driver for NVIDIA nForce SATA controller
author:         NVIDIA
srcversion:     4D85D19ABB1359D28F97C6E
alias:          pci:v000010DEd000003F7sv*sd*bc*sc*i*
...
depends:        libata
vermagic:       2.6.28.1 SMP mod_unload modversions
parm:           adma:Enable use of ADMA (Default: true) (bool)
parm:           swncq:Enable use of SWNCQ (Default: true) (bool)

Do I have the right version?  Should I be seeing a parameter for sgpio?

--Yan

