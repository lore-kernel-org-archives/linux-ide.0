From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: Best way to segments/requests
Date: Fri, 14 Dec 2007 15:22:21 +0000
Message-ID: <8b67d60712140722s7f579f30t978a8a8b926587f5@mail.gmail.com>
References: <8b67d60712131459q35c3ef0dpe1347028112343fd@mail.gmail.com>
	 <47629B9F.90108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:18858 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbXLNPWY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 10:22:24 -0500
Received: by nz-out-0506.google.com with SMTP id s18so617976nze.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 07:22:22 -0800 (PST)
In-Reply-To: <47629B9F.90108@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On 14/12/2007, Tejun Heo <htejun@gmail.com> wrote:
> Hello,

>
> There just isn't much room for maneuver w/ just one segment.  Large
> contiguous memory region isn't too common these days.  That said, there
> was a bug recently spotted by Mark Lord which made contiguous memory
> regions even rarer.  Which kernel version are you using?
>

Bang up to date latest git, ie -rc5-gitX


> > Is that right? What is the best way to go here?
>
> If you can spare some memory and cpu cycles, preparing a contiguous
> buffer and staging data there might help.  It will eat up some cpu
> cycles but it won't be too much compared to PIO cycles.
>

OK, I'll try it
