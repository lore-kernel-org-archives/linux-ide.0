From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Thu, 30 Nov 2006 18:07:16 -0600
Message-ID: <456F7234.8010203@shaw.ca>
References: <DBFABB80F7FD3143A911F9E6CFD477B018E81719@hqemmail02.nvidia.com>
 <200611301746.27193.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:35931 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1031620AbWLAAJr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 19:09:47 -0500
In-reply-to: <200611301746.27193.prakash@punnoor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Allen Martin <AMartin@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, jeff@garzik.org

Prakash Punnoor wrote:
> Am Dienstag 10 Oktober 2006 08:44 schrieb Allen Martin:
> 
>> No, only CK804 and MCP04 support ADMA.  We'll be publishing some patches
>> for NCQ support for MCP55/MCP61 soon.
> 
> Just wondering whether I missed them? It is now 1,5 month later...

I don't think you missed them.. It would be nice to get this support in, 
those are the last NVIDIA chipsets which have NCQ support (apparently) 
that don't support it under Linux. Even just the hardware docs would be 
useful..

---
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
