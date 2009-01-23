From: Yan Seiner <yan@seiner.com>
Subject: Re: [PATCH] sata_nv: sgpio for nvidia mcp55 -v2
Date: Thu, 22 Jan 2009 17:44:53 -0800
Message-ID: <49792115.1070803@seiner.com>
References: <20061031104055.GA8898@infradead.org>    <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>    <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com>    <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com>    <4972F4E5.3030203@kernel.org> <49768355.4040301@kernel.org>    <49773189.6050009@seiner.com> <49776DFB.8090506@kernel.org>    <4977FA12.6050103@seiner.com> <4977FF09.50808@kernel.org> <a20f505b0186b360ea9eecefba08aceb.squirrel@www.datavault.us> <4978AC29.8080308@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:34931 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753595AbZAWBo4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 20:44:56 -0500
In-Reply-To: <4978AC29.8080308@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>, linux-ide@vger.kernel.org

Yinghai Lu wrote:
> Yan Seiner wrote:
>   
>> On Wed, January 21, 2009 9:07 pm, Yinghai Lu wrote:
>>     
>>> please try -v3 and boot with debug in command line, then post bootlog.
>>>       
>> Dumb question:
>>
>> Where does the debug parameter go?  Kernel command line?
>>     
>
> in your /boot/grub/grub.conf
> every boot entry will have append line to let you add some boot parameter. add "debug" in those line, and remove quiet etc.
>
> YH
>
> !DSPAM:4978ac48230791804284693!
>
>   
To recap, I've applied the latest patch (-v3) that's supposed to make 
the SGPIO work.  I am using a LIB-700 backplane from Norco:

http://www.ipcdirect.net/servlet/Detail?no=75
http://www.norco.net.cn/UpLoadFile/Datasheet/DS-600S-EN.pdf

The disk activity LEDs stay lit all the time.

I am running a vanilla kernel, not a debian kernel,. although it was 
built using debian's kbuild.

title           Debian GNU/Linux, kernel 2.6.28.1
root            (hd0,1)
kernel          /vmlinuz-2.6.28.1 root=/dev/md0 ro debug
initrd          /initrd.img-2.6.28.1

log files are at

http://seiner.com/sata_nv/syslog
http://seiner.com/sata_nv/dmesg.log

--Yan
