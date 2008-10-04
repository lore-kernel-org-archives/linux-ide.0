From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with
 the 2.6.26.5 kernel
Date: Sat, 04 Oct 2008 16:27:40 +0900
Message-ID: <48E71AEC.8020701@gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com>	 <20080930170849.52c00228.akpm@linux-foundation.org>	 <48E2E8A1.8090204@gmail.com>	 <64630f150810010131g18c1a00m91b3f68ea29a1067@mail.gmail.com> <64630f150810011601y4e729decq24c614f0b7994f3f@mail.gmail.com> <48E71ACE.4000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:33341 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYJDH3H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 03:29:07 -0400
Received: by ti-out-0910.google.com with SMTP id b6so910763tic.23
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 00:29:05 -0700 (PDT)
In-Reply-To: <48E71ACE.4000505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gettinther <gettinther@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

(restoring lkml and linux-ide.  please don't drop cc list)

Tejun Heo wrote:
> Hello,
> 
> gettinther wrote:
>> 00:05.2 IDE interface: GeForce 8800 GT 512 MCP55 SATA Controller (rev
>> a2) (prog-if 85 [Master SecO PriO])
> 
> Ah.. okay.  MCP55.  I've missed that part in the first message.
> sata_nv is a bit messed up for 2.6.26.  What happened was...
> 
> * During 2.6.26-rc, libata switched to prefer hardreset over softreset
>   for various reasons.
> 
> * After 2.6.26 release, sata_nv generic flavors (MCP55/66) were
>   reported to have problems probing devices with hardreset.  Hardreset
>   simply doesn't work.
> 
> * Patch posted to disable hardreset for generic but it accidentally
>   disabled hardreset for all flavors (generic/nf2/3/ck804).
> 
> * Which broke ck804.
> 
> * Another patch posted to reinstate hardreset for nf2/3 and ck804.
> 
> * It somehow mysteriously broke nf2/3.  This is still being
>   investigated.
> 
> Sorry about the mess but I am puzzled too.  I'll report back when I
> know more.
> 
> Thanks.
> 


-- 
tejun
