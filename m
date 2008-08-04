From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] libata: Implement disk shock protection support
Date: Mon, 04 Aug 2008 23:35:44 +0900
Message-ID: <489713C0.6060909@gmail.com>
References: <87prp1kvyy.fsf@denkblock.local> <20080726062142.29070.10413.stgit@denkblock.local> <4892B8FE.1070400@gmail.com> <20080804142831.GW8749@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:51266 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYHDOgX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Aug 2008 10:36:23 -0400
Received: by py-out-1112.google.com with SMTP id p76so1064375pyb.10
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 07:36:22 -0700 (PDT)
In-Reply-To: <20080804142831.GW8749@boogie.lpds.sztaki.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Elias Oltmanns <eo@nebensachen.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Gabor Gombas wrote:
> On Fri, Aug 01, 2008 at 04:19:26PM +0900, Tejun Heo wrote:
> 
>> However, SATA or not, there simply isn't a way to abort commands in ATA.
>>  Issuing random command while other commands are in progress simply is
>> state machine violation and there will be many interesting results
>> including complete system lockup (ATA controller dying while holding the
>> PCI bus).
> 
> A system lockup may be an acceptable compromise if that saves the
> hardware. Maybe the kernel should explicitely panic unless the
> controller/drive is known to be able to recover.

Such lockups usually would occur before the intervening command is
successfully issued.  HSM violation occurs when the driver asks the
controller to send another command while it's already processing another
command.  Heh... panicking on accelerometer would be fun tho.  We're
gonna get ourselves really flamewars on just about every linux news site.

-- 
tejun
