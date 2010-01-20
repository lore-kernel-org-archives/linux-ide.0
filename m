From: Tejun Heo <htejun@gmail.com>
Subject: Re: HSM violations from ATA PACKET cmd ABRT errors in initial comms
 with   LG GH22 SATA DVDRW
Date: Wed, 20 Jan 2010 17:51:49 +0900
Message-ID: <4B56C425.2030203@gmail.com>
References: <4B37C58D.2090200@gmail.com>	<4B37D50F.4010804@gmail.com>	<19257.17141.825766.63548@pilspetsen.it.uu.se> <19265.3552.13209.914969@pilspetsen.it.uu.se> <4B5671DA.7000904@gmail.com> <4B56B76E.9030304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:41302 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0ATIpq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 03:45:46 -0500
Received: by pxi12 with SMTP id 12so5410635pxi.33
        for <linux-ide@vger.kernel.org>; Wed, 20 Jan 2010 00:45:45 -0800 (PST)
In-Reply-To: <4B56B76E.9030304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thomas.schorpp@gmail.com
Cc: thomas schorpp <thomas.schorpp@googlemail.com>, Mikael Pettersson <mikpe@it.uu.se>, Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

Hello,

On 01/20/2010 04:57 PM, thomas schorpp wrote:
>> I think AC_ERR_OTHER can still be too much.  AC_ERR_* bits should only
>> be set when the command failed for that reason.  Here, underrun is
> 
> Overruns from my port status log, not underruns?
> port_status 0x20280000, 0x2020, (Data Transfer Overrun Error & Target
> Device Fault)?

Well, it depends on which way you look from.  It's data underrun from
the device and overrun from the sglist.  Apparently sata_promise likes
to see it from the sglist.  :-)

>> expected, so not really an error condition.  But, for example, under
>> or overrun for an ATA R/W command should trigger HSM failure.  I think
>> the above error detection logic needs to be improved a bit.
> 
> Well I generally don't feel comfortable with any unknown state output
> EHs, too, but if ata spec conformant, we're fine, aren't we?

Yeap, I was just saying that the condition here wasn't really an error
condition and as such shouldn't set AC_ERR_* bit.

Thanks.

-- 
tejun
