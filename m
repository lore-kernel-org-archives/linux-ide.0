From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATA] Failed to set xfermode on LITE-ON LTR-48246S
Date: Fri, 09 Mar 2007 21:50:07 +0900
Message-ID: <45F157FF.50801@gmail.com>
References: <Pine.LNX.4.64.0702041057090.8424@woody.linux-foundation.org> <20070227135838.GA4328@titan.lahn.de> <45EB9822.40300@gmail.com> <20070305103840.GA4381@titan.lahn.de> <45EC3B3F.7020509@gmail.com> <20070306092339.GA3803@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:5114 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767228AbXCIMuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 07:50:09 -0500
Received: by nz-out-0506.google.com with SMTP id s1so760363nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 04:50:08 -0800 (PST)
In-Reply-To: <20070306092339.GA3803@titan.lahn.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Philipp Matthias Hahn wrote:
> Hello Tejun!
> 
> On Tue, Mar 06, 2007 at 12:46:07AM +0900, Tejun Heo wrote:
>> Philipp Matthias Hahn wrote:
>>> On Mon, Mar 05, 2007 at 01:10:10PM +0900, Tejun Heo wrote:
>>>> * Does applying the attached patch over unpatched 2.6.20.1 fix the problem?
>>> Yes, it seems to fix it. (testes on top of the first patch mentioned
>>> above, but witheout the second one.).
>>> If I should test it as the sole patche, just mail me again please.
>> Yeap, please test it on top of vanilla kernel to verify that the patch
>> proper fixes the problem.
> 
> Yes, applying only this patch does fix the problem.
> Thank you for your support.

Okay, it seems we'll have to default to polling SETXFER.  I'll forward
it upstream soon.  Thanks.

-- 
tejun
