From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] atapi request sense work
Date: Thu, 27 May 2004 17:38:46 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <FF2CC30D-B036-11D8-AA42-003065635034@ieee.org>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1
	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.ed
	u	 .	pl><1085162347.4791.24.camel@patibmrh9><1085170025.3083.91.camel@pat i
	 	bm	r h9> <40AE79E1.9020005@pobox.com><1085182749.3122.15.camel@patibmrh9
	> <	40AE9493.1040701@pobox.com><1085186021.4510.0.camel@patibmrh9>  <108518
	 8300	.3658.18.camel@patibmrh9><1085608170.4148.138.camel@patibmrh9> <10856
	9 9522.3853.1.camel@patibmrh9> <40B67A79.9000706@pobox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:5584 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265679AbUE0Xiy
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 May 2004 19:38:54 -0400
In-Reply-To: <40B67A79.9000706@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

>> +static u8 ata_check_bmdma(struct ata_port *ap)
>> ...
>
> As a first step, would you be willing to create a patch versus 
> mainline, that does nothing but add this function (and uses it)?

Will do now, except:

Sorry I do not know what "mainline" is.  I will guess 2.6.7-rc1-bk4 
unless I hear otherwise.

I will guess you want inline and attached and cc here unless I hear 
otherwise.

Pat LaVarre

