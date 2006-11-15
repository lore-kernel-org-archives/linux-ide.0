From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
Date: Wed, 15 Nov 2006 11:17:29 -0500
Message-ID: <455B3D99.8040705@cfl.rr.com>
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>	 <4558BE57.4020700@cfl.rr.com>	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>	 <1163446372.15249.190.camel@laptopd505.fenrus.org>	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>	 <455 <455B3A78.7010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030642AbWKOQRF@vger.kernel.org>
In-Reply-To: <455B3A78.7010503@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mathieu Fluhr <mfluhr@nero.com>, Arjan van de Ven <arjan@infradead.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
>> The patch _seems_ to solve my problem. I am just really astonished when
>> I read the diff file :D. Can I expect that it will be merged to the
>> official kernel sources ?
> 
> It seems that some devices choke when the bytes after CDB contain 
> garbage.  I seem to recall that I read somewhere ATAPI device require 
> left command bytes cleared to zero but I can't find it anywhere now. 
> Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.
> 

The original patch memsets the entire buffer only to copy over most of 
it right after.  Could you amend the patch so that it memcpys first, 
then memsets only the remainder of the buffer?  No sense wasting cpu 
cycles.
