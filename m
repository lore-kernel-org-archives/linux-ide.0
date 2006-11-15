From: Tejun Heo <htejun@gmail.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Thu, 16 Nov 2006 01:04:08 +0900
Message-ID: <455B3A78.7010503@gmail.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>	 <4558BE57.4020700@cfl.rr.com>	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>	 <1163446372.15249.190.camel@laptopd505.fenrus.org>	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>	 <4559FBCF.9050203@gmail.com> <1163603958.3029.3.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:17571 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030623AbWKOQET (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 11:04:19 -0500
Received: by ug-out-1314.google.com with SMTP id m3so174658ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 08:04:17 -0800 (PST)
In-Reply-To: <1163603958.3029.3.camel@de-c-l-110.nero-de.internal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Phillip Susi <psusi@cfl.rr.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mathieu Fluhr wrote:
> On Wed, 2006-11-15 at 02:24 +0900, Tejun Heo wrote:
>>> ... and the problem is not in accessing the device itself (this is
>>> working like a charm) but understanding why a SCSI READ(10) cmd
>>> sometimes fails as a ATA-padded READ(10) cmd - as discribed in the
>> Annex
>>> A of the MMC-5 spec - ALWAYS works.
>>> -> I would suspect somehow a synchronisation problem somehow in the
>>> translation of SCSI to ATA command...
>> Can you try the attached patch and see if anything changes?
>>
> 
> The patch _seems_ to solve my problem. I am just really astonished when
> I read the diff file :D. Can I expect that it will be merged to the
> official kernel sources ?

It seems that some devices choke when the bytes after CDB contain 
garbage.  I seem to recall that I read somewhere ATAPI device require 
left command bytes cleared to zero but I can't find it anywhere now. 
Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.

-- 
tejun
