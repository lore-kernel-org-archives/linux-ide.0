From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ata: Remove inline attribute from ata_sff_host_intr()
Date: Sun, 23 Nov 2008 23:42:10 -0600
Message-ID: <492A3EB2.8070504@shaw.ca>
References: <49260327.8050408@caviumnetworks.com> <492A39A7.4080703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35385 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbYKXFmZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 00:42:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L4UDG-0001N1-K7
	for linux-ide@vger.kernel.org; Mon, 24 Nov 2008 05:42:22 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2008 05:42:22 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 24 Nov 2008 05:42:22 +0000
In-Reply-To: <492A39A7.4080703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: David Daney <ddaney@caviumnetworks.com>

Tejun Heo wrote:
> David Daney wrote:
>> ata: Remove inline attribute from ata_sff_host_intr()
>>
>> ata_sff_host_intr is a public function, it should not be declared inline.
> 
> Why not?
> 

Well, it's a bit unusual to have a non-static inline (an exported symbol 
no less) in a C file.. how could any callers outside the file ever 
actually inline it? Aside from that it seems a bit big for inlining..

