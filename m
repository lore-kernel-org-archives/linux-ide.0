From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Wed, 13 Aug 2008 13:50:52 -0400
Message-ID: <87f94c370808131050w767623f7s51f0c667a06dcb0a@mail.gmail.com>
References: <489C19CE.6030708@ngs.ru> <48A2BBDC.2090201@ngs.ru>
	 <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>
	 <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru>
	 <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru>
	 <87f94c370808130957g5aa7ac0ax881de81af8e8f926@mail.gmail.com>
	 <48A31A0E.4010703@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:29861 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYHMRux (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 13:50:53 -0400
Received: by wr-out-0506.google.com with SMTP id 69so87867wri.5
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 10:50:52 -0700 (PDT)
In-Reply-To: <48A31A0E.4010703@ngs.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bokhan Artem <APTEM@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, Aug 13, 2008 at 1:29 PM, Bokhan Artem <APTEM@ngs.ru> wrote:
> I have particular fast, simple and cheap controller(s) (MV88SX6081 8-port
> SATA II PCI-X) with a bunch of disks w/o sw/hw raid.
> I need to return an error to application ASAP if media error detected.
>

My thought was that if speed is more important than reliability in
your case, then you could buy a "Enterprise" version hard drive and
eliminate the time it takes the drive to internally do retries.

ie. The concept for which Enterprise drives exist is raid, but that
does not mean you have to use them that way.

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
