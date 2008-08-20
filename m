From: "Matthieu Helder" <matthieu.helder@gmail.com>
Subject: Re: Initio 1623 driver question
Date: Wed, 20 Aug 2008 22:32:17 +0200
Message-ID: <8ce0925c0808201332u604ce2a6sf2274d4517edf95b@mail.gmail.com>
References: <48AB0F54.5080900@gmail.com> <48AB9B98.6000105@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:53676 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbYHTUcR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Aug 2008 16:32:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so758470wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 20 Aug 2008 13:32:17 -0700 (PDT)
In-Reply-To: <48AB9B98.6000105@novell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@novell.com>
Cc: linux-ide@vger.kernel.org

The calls to ata_link_print() didn't contain the warning level. I've
added KERN_WARNING.

Could you please provide me with a way to build just the needed
modules? From a.o. the Linux Kernel Module Programming Guide I don't
succeed in building just the two kernel modules. The system builds all
configured modules, which takes rather a long time.

As soon as I have the requested log, I'll mail it to you. I assume I
have to look in /var/log/messages for it?

Kind regards,
Matthieu

On Wed, Aug 20, 2008 at 6:20 AM, Tejun Heo <teheo@novell.com> wrote:
>
> Matthieu Helder wrote:
> > I've compiled and installed the 2.6.26.2 kernel.
>
> Can you please apply the attached patch and report the resulting
> detection log?
>
> Thanks.
>
> --
> tejun
