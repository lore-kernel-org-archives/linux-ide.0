From: Mark Lord <liml@rtr.ca>
Subject: Re: libata NCQ implementation questions
Date: Tue, 13 May 2008 17:01:31 -0400
Message-ID: <482A01AB.1000706@rtr.ca>
References: <18471.32504.953679.399689@harpo.it.uu.se>	<48286938.1090301@rtr.ca> <18472.38839.647001.510236@alkaid.it.uu.se> <4829520F.6020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2618 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232AbYEMVBf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 May 2008 17:01:35 -0400
In-Reply-To: <4829520F.6020304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Mikael Pettersson wrote:
>> Mark Lord writes:
>>  > Mikael Pettersson wrote:
>>  > > I've started working on NCQ support for sata_promise,
>>  > > and I have a few questions regarding NCQ and libata:
>>  > >  > > 1. Can I rely not seeing any non-NCQ commands while there
>>  > >    are uncompleted NCQ commands on a port?
>>  > ..
>>  >  > No, you cannot.  So you'll have to code a .qc_defer() method
>>  > to hold them off in that case.  For a *really* good example,
>>  > see my recently deployed mv_qc_defer() function in sata_mv.c
>>  > as of linux-2.6.26-rc2.
>>
>> Hmm, so I misinterpreted ata_std_qc_defer()? Ok, I'll look
>> at sata_mv's version.
> 
> ata_std_qc_defer() which is inherited from sata_port_ops does guarantee 
> that NCQ and non-NCQ commands don't mix on a single device.  Mark, 
> you're talking about PMP, right?
..

Ahh.. probably, yes.  I just saw it mixing PIO with NCQ and then
turfed it in favour of a more comprehensive mv_qc_defer().

But that was with a PM connected at the time, and I don't remember if
I also saw it without a PM.

Cheers
