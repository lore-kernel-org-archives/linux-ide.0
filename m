From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 27 May 2004 19:41:59 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40B67CC7.6000008@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed 	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pat i	 	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9 	> <	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <108518	 8300	.3658.18.camel@patibmrh9><1085608170.4148.138.camel@patibmrh9> <10856	9 9522.3853.1.camel@patibmrh9> <40B67A79.9000706@pobox.com> <FF2CC30D-B036-11D8-AA42-003065635034@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22163 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265680AbUE0XmM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 19:42:12 -0400
In-Reply-To: <FF2CC30D-B036-11D8-AA42-003065635034@ieee.org>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
>>> +static u8 ata_check_bmdma(struct ata_port *ap)
>>> ...
>>
>>
>> As a first step, would you be willing to create a patch versus 
>> mainline, that does nothing but add this function (and uses it)?
> 
> 
> Will do now, except:
> 
> Sorry I do not know what "mainline" is.  I will guess 2.6.7-rc1-bk4 
> unless I hear otherwise.

That's fine, libata hasn't been updated since 2.6.7-rc1 IIRC.


> I will guess you want inline and attached and cc here unless I hear 
> otherwise.

Correct.  Though, inline _and_ attached is a bit of overkill, assuming 
that your MUA does not word-wrap or otherwise mangle inline patches. 
Inline-only is typically preferred.

	Jeff


