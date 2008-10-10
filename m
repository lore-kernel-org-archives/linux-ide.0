From: gettinther <gettinther@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with the 2.6.26.5 kernel
Date: Fri, 10 Oct 2008 10:07:23 +0100
Message-ID: <64630f150810100207g312088ep67c00ca15929091d@mail.gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com>
	 <20080930170849.52c00228.akpm@linux-foundation.org>
	 <48E2E8A1.8090204@gmail.com>
	 <64630f150810010131g18c1a00m91b3f68ea29a1067@mail.gmail.com>
	 <64630f150810011601y4e729decq24c614f0b7994f3f@mail.gmail.com>
	 <48E71ACE.4000505@gmail.com> <48E71AEC.8020701@gmail.com>
	 <64630f150810060208q22b61900xd7487500eac4e145@mail.gmail.com>
	 <48EAB71B.1050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:39545 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbYJJJHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 05:07:24 -0400
Received: by an-out-0708.google.com with SMTP id d40so47136and.103
        for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 02:07:23 -0700 (PDT)
In-Reply-To: <48EAB71B.1050002@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Oct 7, 2008 at 2:10 AM, Tejun Heo <htejun@gmail.com> wrote:
> gettinther wrote:
>> I have tested the patch you sent me and it solves the issue with the
>> sata dvdrom detection with the 2.6.27.rc8.  The issue is still present
>> on the 2.6.26.5 kernel.  Are you backporting the solution to that
>> kernel?
>
> It seems nf2/3 still have issues.  Once nf2/3 are cleared, I'll
> forward the patch to -stable.
>
> Thanks.
>
> --
> tejun
>

Tejun,

I applied your patch to the 2.6.26 tree (slightly modified to suit)
and it also fixes the issue there.
I can post the patch this evening if you want to.

Thank you again,

Cyrille
