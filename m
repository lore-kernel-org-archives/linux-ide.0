From: "Caspar Smit" <c.smit@truebit.nl>
Subject: Re: sata_mv driver support for Marvell Hercules II controller in
     newer kernels
Date: Wed, 17 Feb 2010 08:35:40 +0100 (CET)
Message-ID: <2996.77.248.79.78.1266392140.squirrel@ketsers.dhs.org>
References: <549084.45576.qm@web45206.mail.sp1.yahoo.com>
    <4B7B9241.9070101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-69-81-65.colo.transip.net ([80.69.81.65]:39153 "EHLO
	ns1.emsolutions.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934010Ab0BQHfm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Feb 2010 02:35:42 -0500
Received: from ns1.emsolutions.nl (www-data@localhost.localdomain [127.0.0.1])
	by ns1.emsolutions.nl (8.13.8/8.13.8/Debian-3) with ESMTP id o1H7Zect007925
	for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2010 08:35:40 +0100
In-Reply-To: <4B7B9241.9070101@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE mailing list <linux-ide@vger.kernel.org>

Which kernel do you mean by 'newer'

I'm using the same card(s) with Debian Linux 5.0 using the 2.6.30
backports kernel and it is detected fine by the sata_mv driver.

Caspar

 > On 02/16/2010 10:44 PM, The Government wrote:
>> Hey guys,
>>
>> I'm using a Supermicro aoc-sat2-mv8, which is supposedly supported by
>> the Linux kernel by "sata_mv" driver. Unfortunately, I've been unable to
>> troubleshoot why newer distros (and thus kernels) are not
>> detecting/using sata_mv for this card. I tried an (older) Slackware 12.1
>> install disk, that for some reason works by use of sata_mv (12.1 was
>> released may 2008, when I think sata_mv was still beta). Anyhow, I've
>> tried many newest releases from Slackware, Arch, etc - and it seems
>> newer kernels do not properly recognize this card. I'm not sure what to
>> make of the newer kernels saying "adaptec aacraid driver" is being used
>> (an incorrectly detected driver?). Anyway, I was told this chipset had
>> great linux support - does it still? Thanks a lot.
>>
>> (please CC me for replies, thanks a lot)
>
> (cc linux-ide added)
>
> We need a lot more hard detail, such as lspci and dmesg output.
>
> 	Jeff
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

