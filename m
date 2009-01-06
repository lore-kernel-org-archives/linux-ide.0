From: <linux-ide@momail.e4ward.com>
Subject: Re: PIONEER DVD-RW DVRTD08 is disabled if there is no disc present
 at   boot time
Date: Tue, 06 Jan 2009 23:51:16 +0100
Message-ID: <1231282276.6376.13.camel@Thutmosis>
References: <1229894315.6931.17.camel@Thutmosis> <494EDDBE.3010306@shaw.ca>
	 <494F65C1.80602@kernel.org> <1229947998.6045.10.camel@Thutmosis>
	 <49505500.8080409@kernel.org> <1230126055.6430.17.camel@Thutmosis>
	 <495886E7.7050204@kernel.org>  <1230586376.11130.46.camel@Thutmosis>
Reply-To: linux--ide-momail.e4ward.com-linux--ide-vger.kernel.org-CDD-6w99-4@reply.e4ward.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4ward.com ([70.85.31.73]:56470 "EHLO e4ward.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102AbZAFXYi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Jan 2009 18:24:38 -0500
Received: from localhost ([127.0.0.1])
	by e4ward.com with smtp (Exim 4.63)
	id 1LKKlb-0007Lw-2r
	for linux-ide@vger.kernel.org; Tue, 06 Jan 2009 17:51:19 -0500
In-Reply-To: <1230586376.11130.46.camel@Thutmosis>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Am Montag, den 29.12.2008, 22:32 +0100 schrieb ein unbekannter Absender:
> 
> Am Montag, den 29.12.2008, 17:14 +0900 schrieb
> linux-ide@vger.kernel.org:
> 
> I have randomly tested a few CDs and DVDs since my last post, and there
> were none that didn't work (after an "empty boot"). 
>  But afterwards I plan to do some more
> systematic tests, and I will also attempt to burn a CD and a DVD. 
Hi, I have successfully burnt several Video-DVDs (with growisofs; on
DVD-R and DVD+RW media), an Audio-CD (brasero) and a Data-CD (brasero).
Also, I have not experienced any more problems reading CDs or DVDs. I
guess that the CDs that did not work after I applied the patch were
damaged.
Therefore, I tend to regard the problem as fixed by tejun's patch and I
would recommend to let it go into mainline.
Thank you once more for your valuable help.
Moritz
 


