From: jon@alumni.caltech.edu
Subject: Re: Help diagnosing an SATA vs. Sil3112 error on NF7-S 2.0 +      
     FC5/2.6.17 ?
Date: Mon, 4 Sep 2006 13:51:48 -0700 (PDT)
Message-ID: <60991.66.92.14.158.1157403108.squirrel@mail.alumni.caltech.edu>
References: <60994.66.92.14.158.1157337980.squirrel@mail.alumni.caltech.edu>
    <44FB979E.2000404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from posteaux1.caltech.edu ([131.215.239.119]:9864 "EHLO
	mail.alumni.caltech.edu") by vger.kernel.org with ESMTP
	id S1751425AbWIDUvs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 16:51:48 -0400
In-Reply-To: <44FB979E.2000404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo writes:
> No, none is related to m15w.  It seems that your drive is failing some
> commands w/ ID not found error, which might be a media problem.
> Anyways, libata is having problem recovering from the error condition
> and retrying the command, thus the catastrophe.
>
>>     So far I've upgraded the BIOS to the latest from Abit, which
>> includes a more recent SATA BIOS from Silicon Image, and fiddled with
>> some of the BIOS settings - particularly changing Ext-P2P Discard from
>> 30us to 1ms, as suggested in a much older NVIDIA/Abit bug dialogue. I
>> don't know if any of this is actually helping yet, though.
>
> I'm skeptical.
>
> Can you try 2.6.18-rc5?  Latest libata has much improved error handling.
>   If the error your drive is reporting are transient, new libata EH
> should be able to recover from most of them and, even if not, it will
> help diagnosing the problem.

    Unfortunately, Fedora hasn't packaged up the 2.6.18 kernels, and
this is not yet a bad enough problem yet to motivate me to build my own.
BIOS adjustments and updates may have worked around the problem - it
hasn't happened again since doing them. If not I'll just back off on
using this drive until I can get a 2.6.18 kernel. I was hoping this was
a well-known problem :-(
    Thanks!
    Jon

