From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/1] libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING
 LLDDs
Date: Wed, 15 Mar 2006 11:12:10 -0500
Message-ID: <44183CDA.5010407@rtr.ca>
References: <441525DB.40905@tw.ibm.com> <441528BD.8070708@pobox.com> <44164C25.10106@tw.ibm.com> <441838B6.8060900@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040401070903070708070808"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:22429 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750944AbWCOQMP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Mar 2006 11:12:15 -0500
In-Reply-To: <441838B6.8060900@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE Linux <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------040401070903070708070808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:
> Jeff Garzik wrote:
> 
>> Applied, though I think its an open question what happens with
>> CDB-interrupt ATAPI devices want to do DMA.  Perhaps we just get an
>> interrupt event that we clear, then life proceeds as normal.
> 
> Not sure. I have no such device at hand for test; currently relying
> on the SFF-8020i spec (http://www.bswd.com/sff8020i.pdf) as reference.
> According to p.31, we have to send out the CDB after receiving
> the CDB interrupt. So, just clearing the irq looks not enough.
> 
>> Does anybody actually have such a device anywhere?  :)

Yup, I have two such drives here.

One of them has a grease-pencil "NFG" marking on it,
and other other one doesn't.  They both powered up and
worked just now, and their identify blobs are attached
(you can interpret them with "hdparm --Istdin <blob").

I'm late paying attention on this thread, so what is it
that we wanted done with them?

Or even better, who wants one of them?  Albert, Jeff, or Tejun?

Cheers

--------------040401070903070708070808
Content-Type: text/plain;
 name="aopen_936e_aku.identify"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aopen_936e_aku.identify"


/dev/hdd:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
85a0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5531
3049 2020 2020 4344 2d52 4f4d 2033 3658
2f41 4b55 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0107
0003 0078 0096 00e3 0078 0000 0000 0000
0000 0002 0009 3030 3120 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0107 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

--------------040401070903070708070808
Content-Type: text/plain;
 name="aopen_940e_aku.identify"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aopen_940e_aku.identify"


/dev/hdc:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
85a0 0000 0000 0000 0000 0000 0000 0000
0000 0000 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 0000 0000 0000 5533
3120 2020 2020 4344 2d52 4f4d 2034 3058
2f41 4b55 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0107
0003 0078 0096 00e3 0078 0000 0000 0000
0000 0002 0009 3030 3330 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0107 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0041
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

--------------040401070903070708070808--
