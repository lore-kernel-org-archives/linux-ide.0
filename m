From: Timothy Bisson <timbisson@sbcglobal.net>
Subject: Re: NV Cache Feature Support in libata
Date: Fri, 9 Feb 2007 11:21:41 -0800
Message-ID: <36AD3019-C75F-4E3C-AD48-7C51831EC818@sbcglobal.net>
References: <8202f4270702091025k77c3171fr6bb3b5b6088df85b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from services.cse.ucsc.edu ([128.114.48.10]:36148 "EHLO
	services.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992768AbXBITVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Feb 2007 14:21:47 -0500
Received: from [10.34.18.69] (nat-198-95-226-231.netapp.com [198.95.226.231])
	(authenticated bits=0)
	by services.cse.ucsc.edu (8.13.6/8.13.1) with ESMTP id l19JLkMX004733
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 9 Feb 2007 11:21:46 -0800 (PST)
In-Reply-To: <8202f4270702091025k77c3171fr6bb3b5b6088df85b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


On Feb 9, 2007, at 10:25 AM, Fajun Chen wrote:

> I'm not aware of any NV cache (vista feature documented in
> ata-atapi-8) support in libata. Is this supported or any plan to
> support it in the future?

It is already supported through the HDIO_DRIVE_CMD ioctl - pass 0xb6  
as the command register value.

I think the interesting question is, how can we leverage the NV Cache  
in the block and file system layers to improve power and performance.  
One probably obvious option is to enter NV Cache Power Mode when  
laptop mode is enabled.

Tim
