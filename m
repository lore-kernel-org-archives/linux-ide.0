From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Wed, 13 Aug 2008 14:13:06 -0400
Message-ID: <87f94c370808131113w1d34b3f4ka5161e2e36d72518@mail.gmail.com>
References: <489C19CE.6030708@ngs.ru> <48A2C35C.7020400@ngs.ru>
	 <48A2C460.6040504@gmail.com> <48A2C770.2040200@ngs.ru>
	 <48A2CB1B.4000200@gmail.com> <48A2CE09.9090806@ngs.ru>
	 <87f94c370808130957g5aa7ac0ax881de81af8e8f926@mail.gmail.com>
	 <48A31A0E.4010703@ngs.ru>
	 <87f94c370808131050w767623f7s51f0c667a06dcb0a@mail.gmail.com>
	 <48A3221A.1050504@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:33834 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYHMSNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 14:13:08 -0400
Received: by wr-out-0506.google.com with SMTP id 69so96412wri.5
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 11:13:06 -0700 (PDT)
In-Reply-To: <48A3221A.1050504@ngs.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bokhan Artem <APTEM@ngs.ru>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Wed, Aug 13, 2008 at 2:04 PM, Bokhan Artem <APTEM@ngs.ru> wrote:
> But as I understand my problem, all retries and delays are made inside linux
> kernel, not inside hardware...
>

AIUI you have both.

And they multiply, so if the hardware is doing X retries per attempt
and the kernel is doing Y retries, then the total retries is close to
X*(Y+1).

To get the fastest possible failure mode you need to reduce both X and Y.

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
