From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH -mm] sata_vsc gcc 4.1 warning fix
Date: Wed, 10 May 2006 13:45:27 +0900
Message-ID: <44616FE7.1080306@gmail.com>
References: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>	 <44616A1C.20800@gmail.com> <1147235880.21536.53.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:38164 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964810AbWEJEpe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 May 2006 00:45:34 -0400
Received: by wr-out-0506.google.com with SMTP id i34so1391010wra
        for <linux-ide@vger.kernel.org>; Tue, 09 May 2006 21:45:33 -0700 (PDT)
In-Reply-To: <1147235880.21536.53.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, jeremy@sgi.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Wed, 2006-05-10 at 13:20 +0900, Tejun Heo wrote:
>> Daniel Walker wrote:
>>> Fixes the following warning,
>>>
>>> drivers/scsi/sata_vsc.c:152: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:153: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:154: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:155: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:156: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:158: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:159: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:160: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:161: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:162: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:166: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c: In function 'vsc_sata_tf_read':
>>> drivers/scsi/sata_vsc.c:178: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:179: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:180: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:181: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:182: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:183: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c: In function 'vsc_sata_setup_port':
>>> drivers/scsi/sata_vsc.c:320: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
>>> drivers/scsi/sata_vsc.c:321: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
>>>
>>> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
>>>
>> Hello, Daniel.
>>
>> This fix comes up every so often and I have submitted almost identical 
>> patch several months ago.  Unfortunately, it's not the proper fix and 
>> won't be accepted.  All those read/writeX()'s and in/outX()'s are 
>> scheduled (for a looooong time) to be converted to new unified 
>> ioread/writeX()'s.  Things are in progress (well, or halt) in the #iomap 
>> branch of libata-dev devel tree.  libata needs some updates in host 
>> initialization part for this conversion to complete.
> 
> I guess subconsciously I knew as much, but I've seen warning like these
> during compiles for a very very very long time .. Considering how
> trivial it is to silence them I don't see why it shouldn't be accepted .
> The "right" fix should have arrived by now ..
> 

Well, it was Jeff's (the maintainer) call.  The warning messages bug me
too but I sort of understand Jeff's decision as the bugging actually
reminds me of the problem every time I build libata.  Well, let's hope
iomap gets completed in not too distant future

Thanks.

-- 
tejun
