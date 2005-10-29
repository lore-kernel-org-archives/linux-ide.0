From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sat, 29 Oct 2005 15:20:00 -0400
Message-ID: <4363CB60.2000201@pobox.com>
References: <20051029182228.GA14495@havoc.gtf.org> <20051029121454.5d27aecb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:1414 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932104AbVJ2TUD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 15:20:03 -0400
In-Reply-To: <20051029121454.5d27aecb.akpm@osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to obtain misc fixes and cleanups, and to merge
>> the ATA passthru (SMART support) feature.
> 
> 
> Are you sure this doesn't propagate Max Kellermann's "2.6.14-rc4-mm1 and
> later: second ata_piix controller is invisible" regression?
> 
> He did confirm that git-libata-all.patch caused it.

Highly doubtful.

Even so, it's easy, to I'll ask him to test 2.6.14, 2.6.14-git1, and 
(tonight's upcoming) 2.6.14-git2 (with my latest pull included) to see 
if anything breaks.

I think it's some of Alan's changes that aren't yet merged upstream, 
though I could be wrong.

	Jeff



