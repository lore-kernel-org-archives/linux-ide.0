From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
Subject: =?iso-8859-1?B?UmWg?=
	=?iso-8859-1?Q?=3A?= siI3112 on A7N8X ASUS
Date: Wed, 9 Jul 2003 21:34:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030709193454.GA14457@tangerine>
References: <beffbo$o6s$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp7.wanadoo.fr ([193.252.22.29]:57845 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S268502AbTGITVT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jul 2003 15:21:19 -0400
Content-Disposition: inline
In-Reply-To: <beffbo$o6s$1@main.gmane.org>; from tea4two@tin.it on mer, jui 09, 2003 at 00:08:37 +0200
List-Id: linux-ide@vger.kernel.org
To: tea4two <tea4two@tin.it>
Cc: linux-ide@vger.kernel.org

Hi,

I'm running a 2.4.21 kernel with a Debian sid.

I've an WDC Caviar 40Gb ide hdd installed on my ASUS P5A motheboard.
The disk is not found by the motherboard due to the 32Gb limitation of 
the BIOS.
After setting the disk to 'none' in the BIOS. The system boots and the 
disk is found normally by linux.

It is detected as pio too.

After setting the parameters with hdparm -d1 -Xudma2 /dev/hdb, I get a 
throughput of about 14Mb/s.

If I look at the disk parameters with hparm -I /dev/hdb, I can see that 
it is still runing mdma2 instead of udma2.

The reply to the command to set the parameters was:

[root@tangerine] /home/jean-luc # hdparm -d1 -Xudma2 /dev/hdb

/dev/hdb:
  setting using_dma to 1 (on)
  setting xfermode to 66 (UltraDMA mode2)
  using_dma    =  1 (on)

But it was not in udma2.

In the second step, I tried to boot from a Knoppix 3.2 CD.
With it, when I set the parameters, it is set to udma2 and the 
throughput is about 25Mb/s. Not a bad improvement!

In the third step, I have recompiled a kernel with the same .config as 
the one used by Knoppix... No luck : I cannot set the udma2 parameter...


---
Regards
	Jean-Luc



On 09.07.2003 00:08, tea4two wrote:
> I'm using Redhat 9.0 on A7N8X Deluxe with MaxtorDiamondPlus 9 120 Gb
> SATA
> HD, the only way to obtain more disk performance is to run before
> install
> "hdparm -d1 -Xudma2 /tmp/hde" and after create in /etc/sysconfig the
> harddiskhde file with
> DMA = 1 and EXTRA PARAMETER = -Xudma2.
> 
> Using hdparm -t /dev/hde HD speed increase from 1.3 MB/sec to 50.50
> Mb/sec.
> installation go faster and PC are really usable.
> 
> It's the better way to tune HD performance or someone know a better
> once ?
> 
> When linux boot siI3112A controller fail DMA test and set SATA
> controller in
> pio mode, this is the reason for very poor performance.
> 
> Please write your experience.
> 
> Thanks in advance.
> 
> Pierluigi
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
