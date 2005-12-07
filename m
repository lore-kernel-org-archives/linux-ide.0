From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Date: Wed, 7 Dec 2005 15:19:07 +0100
Message-ID: <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.195]:60023 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVLGOTK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Dec 2005 09:19:10 -0500
Received: by nproxy.gmail.com with SMTP id x29so115629nfb
        for <linux-ide@vger.kernel.org>; Wed, 07 Dec 2005 06:19:07 -0800 (PST)
In-Reply-To: <20051207131454.GA16558@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>

On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
>
> > Isn't ide-io.c:ide_{start,complete}_power_step() enough?
>
> No.

Why? :)
