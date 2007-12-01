From: Mark Lord <liml@rtr.ca>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 15:01:40 -0500
Message-ID: <4751BDA4.9080102@rtr.ca>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru> <20071130231705.51e056f4@the-village.bc.nu> <475110A8.5090709@clear.net.nz> <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com> <4751B3DA.6030508@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3948 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbXLAUBm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 15:01:42 -0500
In-Reply-To: <4751B3DA.6030508@clear.net.nz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: linux-ide@vger.kernel.org

Richard Scobie wrote:
> 
> 
> Greg Freemyer wrote:
> 
>> Also, if you have Port Multiplexers (PMPs) in use, that would be
>> interesting to know.  I don't even know if PMPs are supported via SAS
>> controllers in 2.6.24 or not.  ie. PMP support is new to 2.6.24 and
>> only a few Sata controllers will have PMP support in 2.6.24.
> 
> No, port multipliers are not in use here, the technology that SAS uses 
> is called port expansion. While I do not know much about the low level 
> operational differences, from a performance perspective, this is my 
> understanding.
> 
> Port multiplication only permits one drive to be accessed at once, 
> whereas port expansion allows multiple drives to be accessed 
> simultaneously.
..

SATA port multipliers (think, "hub") permit multiple drives
to be active simultaneously.

-ml
