From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: SAS v SATA interface performance
Date: Sat, 1 Dec 2007 09:37:03 -0500
Message-ID: <87f94c370712010637o5efa9c4rd9a86ec5a3cba6ff@mail.gmail.com>
References: <47506237.3000406@clear.net.nz> <47507F9A.3080109@msgid.tls.msk.ru>
	 <20071130231705.51e056f4@the-village.bc.nu>
	 <475110A8.5090709@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:61463 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXLAOhE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Dec 2007 09:37:04 -0500
Received: by an-out-0708.google.com with SMTP id d31so536214and
        for <linux-ide@vger.kernel.org>; Sat, 01 Dec 2007 06:37:04 -0800 (PST)
In-Reply-To: <475110A8.5090709@clear.net.nz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Scobie <r.scobie@clear.net.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Dec 1, 2007 2:43 AM, Richard Scobie <r.scobie@clear.net.nz> wrote:
>
>
> Alan Cox wrote:
>
> > If you want really high performance use multiple drives, on multiple PCIE
> > controllers. Just make sure your backup planning of raid 1+0 setup is
> > done right as many drives means a lot more drive fails.
>
> Thanks again. For what it's worth, I shall be attempting this with SATA
> drives in a RAID 50 configuration - 2 x 8 drives, using md RAID and an 8
> lane PCIe SAS HBA.
>
I suspect many of us will be curious of the performance results.

Also, if you have Port Multiplexers (PMPs) in use, that would be
interesting to know.  I don't even know if PMPs are supported via SAS
controllers in 2.6.24 or not.  ie. PMP support is new to 2.6.24 and
only a few Sata controllers will have PMP support in 2.6.24.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
