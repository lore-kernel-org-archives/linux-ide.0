From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Remove inline attribute from ata_sff_host_intr()
Date: Mon, 24 Nov 2008 14:49:01 +0900
Message-ID: <492A404D.1010107@kernel.org>
References: <49260327.8050408@caviumnetworks.com> <492A39A7.4080703@kernel.org> <492A3EB2.8070504@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55309 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYKXFtI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:49:08 -0500
In-Reply-To: <492A3EB2.8070504@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: David Daney <ddaney@caviumnetworks.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Robert Hancock wrote:
> Tejun Heo wrote:
>> David Daney wrote:
>>> ata: Remove inline attribute from ata_sff_host_intr()
>>>
>>> ata_sff_host_intr is a public function, it should not be declared
>>> inline.
>>
>> Why not?
>>
> 
> Well, it's a bit unusual to have a non-static inline (an exported symbol
> no less) in a C file.. how could any callers outside the file ever
> actually inline it? Aside from that it seems a bit big for inlining..

The goal there is to inline ata_sff_host_intr() into ata_sff_interrupt()
and then export a separate copy to other users as ata_sff_interrupt() is
very hot.  Looking at the disassembly, gcc is doing what it's told to
do, so the inline actually is doing something useful there.

Thanks.

-- 
tejun
