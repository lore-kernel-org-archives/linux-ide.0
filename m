From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Wed, 30 Jun 2010 09:11:38 +0200
Message-ID: <4C2AEE2A.8060405@kernel.org>
References: <1277879827-18233-1-git-send-email-justinmattock@gmail.com> <4C2AE8FE.3020409@kernel.org> <4C2AED03.7070103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38275 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab0F3HMH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jun 2010 03:12:07 -0400
In-Reply-To: <4C2AED03.7070103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On 06/30/2010 09:06 AM, Justin P. Mattock wrote:
>> Hmm, is this something we wanna go around the kernel and updating
>> sources?  Or should we just flick a gcc option?
> 
> the flick a gcc option seems easier todo, but my guess its probably not
> the right way of dealing with the issue(even a warning).

What does the extra warning buy us?  There are several places which
use anonymous enums for constants and I can't see what the benefit of
this warning would be.

>> And, just do WARN_ON((int)ATA_MAX_QUEUE > (int)AHCI_MAX_CMDS)
> 
> that builds clean. keep in mind I just compile tested, no rebooting or
> anything. Should I just resend with what you posted, and call it that,
> or is this something that needs more?

I think it would be better to first decide what to do about the
new warnings.

Thanks.

-- 
tejun
