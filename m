From: Larry Baker <baker@usgs.gov>
Subject: Re: [PATCH #upstream] libata: implement dump_id force param
Date: Tue, 1 Jul 2014 14:07:49 -0700
Message-ID: <64F274F8-55D2-4D18-B60E-CB14ACBBAB85@usgs.gov>
References: <4BF90A7F.80309@kernel.org> <4BFC6059.3080505@garzik.org> <C734FD3F-7CAB-40C4-A3AB-916A30E173DE@usgs.gov> <56B984A8-0CA0-4FED-A3D2-6CDE82AA5FE4@usgs.gov> <20140701205106.GD12459@htj.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from SMTP1.doi.gov ([137.227.82.11]:46864 "EHLO smtp1.doi.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbaGAVIB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jul 2014 17:08:01 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so10671404pdi.41
        for <linux-ide@vger.kernel.org>; Tue, 01 Jul 2014 14:07:51 -0700 (PDT)
In-Reply-To: <20140701205106.GD12459@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun,

I understand.  We have moved buildings since 2010 and I do not know whether I can find the CF cards that had the problem.  I have a deadline in 3 weeks that I must work on.  I will follow up with you after that.

Thank you,

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov



On 1 Jul 2014, at 1:51 PM, Tejun Heo wrote:

> Hello, Larry.
> 
> On Tue, Jul 01, 2014 at 11:51:54AM -0700, Larry Baker wrote:
>> I see what happened.  Tejun sent me two sets of patches: one to
>> implement the driver dump_id kernel parameter and the other to fix
>> the problem with the buggy CF card.  (It lies that it supports ATA
>> MULTI -- which is actually required by the standard!)  Jeff only saw
>> the first set, which is what he applied.  They are in the current
>> Linux source tree.  What are missing are the patches to recover from
>> multi-block transfer failures by falling back to use single-block
>> transfers.  Here's Tejun's e-mail to me with those patches (ready to
>> go?).
> 
> I dug out the original patch.  It looks like I was waiting for
> Tested-by.  Has anyone tested the patch at the time?
> 
> Thanks.
> 
> -- 
> tejun

