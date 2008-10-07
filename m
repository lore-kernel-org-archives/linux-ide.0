From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata dvdroms fails to be recognized by MCP55 controller with
 the 2.6.26.5 kernel
Date: Tue, 07 Oct 2008 10:10:51 +0900
Message-ID: <48EAB71B.1050002@gmail.com>
References: <64630f150809291601w3511febdyc769b8871db75602@mail.gmail.com>	 <20080930170849.52c00228.akpm@linux-foundation.org>	 <48E2E8A1.8090204@gmail.com>	 <64630f150810010131g18c1a00m91b3f68ea29a1067@mail.gmail.com>	 <64630f150810011601y4e729decq24c614f0b7994f3f@mail.gmail.com>	 <48E71ACE.4000505@gmail.com> <48E71AEC.8020701@gmail.com> <64630f150810060208q22b61900xd7487500eac4e145@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:30798 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYJGBMZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Oct 2008 21:12:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1629383tic.23
        for <linux-ide@vger.kernel.org>; Mon, 06 Oct 2008 18:12:23 -0700 (PDT)
In-Reply-To: <64630f150810060208q22b61900xd7487500eac4e145@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gettinther <gettinther@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

gettinther wrote:
> I have tested the patch you sent me and it solves the issue with the
> sata dvdrom detection with the 2.6.27.rc8.  The issue is still present
> on the 2.6.26.5 kernel.  Are you backporting the solution to that
> kernel?

It seems nf2/3 still have issues.  Once nf2/3 are cleared, I'll
forward the patch to -stable.

Thanks.

-- 
tejun
