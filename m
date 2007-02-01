From: Tejun Heo <htejun@gmail.com>
Subject: Re: VIA AHCI NCQ [was: Re: Recent AHCI drivers do not work with VIA
 VT8251 controllers (regression in 2.6.19 from 2.6.18)]
Date: Thu, 01 Feb 2007 10:20:59 +0900
Message-ID: <45C1407B.1000703@gmail.com>
References: <20070130155355.GB12475@reddwarf.farnz.org.uk> <200701312034.36499.simon@farnz.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:13768 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161197AbXBABVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 20:21:21 -0500
Received: by nz-out-0506.google.com with SMTP id s1so365639nze
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 17:21:21 -0800 (PST)
In-Reply-To: <200701312034.36499.simon@farnz.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Farnsworth <simon@farnz.org.uk>
Cc: linux-ide@vger.kernel.org

Simon Farnsworth wrote:
> On Tuesday 30 January 2007 15:53, Simon Farnsworth wrote:
>> Hello,
>>
>> I've got a VIA VT8251 AHCI controller, driving two Maxtor SATA disks.
>> Under Linux 2.6.18.5, it works; using 2.6.19.1, it fails to work (bug
>> report at http://bugzilla.kernel.org/show_bug.cgi?id=7589 - note that
>> pci=nomsi does not fix things for me, as I still get no interrupts).
>>
> I've been going through 2.6.20-rc releases this evening. 2.6.20-rc7 resolves 
> my AHCI fault (although not the MSI problem); it looks like Tejun Heo's fix 
> to ahci_thaw() in a718728f9e40ec79c0879ec6509a54fee214f5b2 fixes things for 
> my setup.

Yeah, that was my mistake spotted by Jeff.  IRQ pending was never
cleared properly so the controller couldn't raise it.

> Of course, I'm now curious as to why NCQ is disabled on VIA AHCI controllers. 
> Is there a known hardware bug I should be wary of, or is it just a case of 
> being cautious due to the other issues with the VT8251 (in which case I'll 
> try enabling it and reporting back)?

Yeap, there is a known NCQ problem with vt8251.  Can't find the original
bug report now tho.

commit 71f0737b2889b86f774a94afaf1342c2c0d61cb5
tree e983d3f4c3fccad0679aa8ae18a0c3ce91bfafe7
parent 8fa29b23d9e0ef976dc578aab98297d4f24f70da
author Tejun Heo <htejun@gmail.com> 1150899168 +0900
committer Jeff Garzik <jeff@garzik.org> 1151032959 -0400

[PATCH] ahci: disable NCQ support on vt8251

vt8251 chokes on NCQ commands.  Two different disks from different
vendors are showing the same symptom and it seems that the windows
driver from via doesn't support NCQ either.  Disable NCQ support on
this controller for the time being.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Aalderd Bouwman <boac@wanadoo.nl>
Cc: Bastiaan Jacques <b.jacques@planet.nl>
Signed-off-by: Jeff Garzik <jeff@garzik.org>

-- 
tejun
