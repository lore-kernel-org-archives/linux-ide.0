From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
 - it works
Date: Mon, 23 Feb 2009 13:17:32 +0100
Message-ID: <49A293DC.9030005@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk>	<18725.17831.755158.999770@harpo.it.uu.se>	<49263F80.2060607@kernel.org>	<492C358C.7030403@garzik.org>	<18737.47407.218634.726384@harpo.it.uu.se>	<499102E5.6000603@garzik.org> <18833.47451.931683.294891@harpo.it.uu.se> <4991EDFC.4010109@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:50480 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbZBWMRi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Feb 2009 07:17:38 -0500
In-Reply-To: <4991EDFC.4010109@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Mikael Pettersson <mikpe@it.uu.se>

Jeff Garzik wrote:
> Mikael Pettersson wrote:
>> Not really. I've kept the patch up to date for newer kernels, but
>> there's been no testing by others that I know of. Do you want to
>> include it in a testing branch?
> 
> I can at least make sure it is in #ALL and #NEXT, two meta-branches in 
> libata-dev.git that are forwarded to akpm's -mm tree and linux-next, 
> respectively, for wider public testing.
> 
> We can give it more-public testing and hopefully get a bit more feedback.

I have tested this patch:

http://user.it.uu.se/~mikpe/linux/patches/2.6/OLD/2.6.28/patch-sata_promise-reset-updates-v1-2.6.28

On a vanilla 2.6.28.6 kernel.

It works without any problems.

Unfortunately I had to replace a faulty power supply - which may have 
been the cause for my system failing earlier (as reported in previous 
postings to this list).

Hardware:

AMD Barton 2500 on Nforce2 motherboard with

Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)

4 Seagate 500GB ES drives:
   Model Number:       ST3500630NS
   Firmware Revision:  3.AEE
   (with 1.5/3.0Gbps jumper removed = 3.0Gbps)


Best regards

Peter
