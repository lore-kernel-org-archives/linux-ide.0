From: "Trevor Hemsley" <trevor.hemsley@ntlworld.com>
Subject: Re: Netcell SyncRaid problem post 2.6.27
Date: Fri, 29 May 2009 00:01:33 +0100 (BST)
Message-ID: <20090528230317.RVVK21638.aamtaout02-winn.ispmail.ntl.com@trevor2.dsl.pipex.com>
References: <200905281410.16060.bzolnier@gmail.com>
Reply-To: "Trevor Hemsley" <trevor.hemsley@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:61707 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbZE1XSd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 May 2009 19:18:33 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090528230317.GMZS6611.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <linux-ide@vger.kernel.org>; Fri, 29 May 2009 00:03:17 +0100
Received: from trevor2.dsl.pipex.com ([81.111.103.146])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090528230317.RVVK21638.aamtaout02-winn.ispmail.ntl.com@trevor2.dsl.pipex.com>
          for <linux-ide@vger.kernel.org>; Fri, 29 May 2009 00:03:17 +0100
In-Reply-To: <200905281410.16060.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 28 May 2009 14:10:15 +0200, Bartlomiej Zolnierkiewicz wrote:

>
>On Thursday 28 May 2009 01:56:21 Trevor Hemsley wrote:
>> Hi
>> 
>> Apologies if you are not the kernel maintainer that I should be writing
>> to.
>> 
>> I have a Netcell SyncRAID SR5000 controller in my machine here and in
>> kernels post 2.6.27 it is no longer working correctly. I've had a quick
>> look at the code but before I dig too deeply, I thought I'd ask to see
>> if this is something that's already been fixed.
>
>Checks for LBA48 support were fixed at this time and since this is a kind
>of unusual controller (hardware ATA RAID) it could be that we may need to
>add some special tweaks for it (or it could be just a bug somewhere).
>
>Please send me output of 'hdparm --Istdout /dev/hde' command, also please
>use linux-ide@vger.kernel.org mailing list for communication if possible.

Since I am unsure about the etiquette of posting attachments to this
list I have put copies of hdparm --Istdout /dev/hde and dmesg output
from both kernel 2.6.27.2 and 2.6.29.4 in
http://www.os2warp.org/sysbench/netcell.tar.gz

Both kernels are self-compiled but based on the original Centos 5.3
.config file. The 2.6.29.4 is created by copying the 2.6.27.2 .config
and then running `make oldconfig` and taking all defaults for those
items that are new.


-- 
Trevor Hemsley, Brighton, UK
Trevor dot Hemsley at ntlworld dot com

