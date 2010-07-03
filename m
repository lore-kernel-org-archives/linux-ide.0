From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2]ata:ahci.c Fix warning: comparison between 'enum <anonymous>'
 and 'enum <anonymous>'
Date: Sat, 03 Jul 2010 11:57:49 +0200
Message-ID: <4C2F099D.1080806@kernel.org>
References: <1277879827-18233-1-git-send-email-justinmattock@gmail.com> <4C2AE8FE.3020409@kernel.org> <4C2AED03.7070103@gmail.com> <4C2AEE2A.8060405@kernel.org> <4C2AF088.2080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49283 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab0GCJ6t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 05:58:49 -0400
In-Reply-To: <4C2AF088.2080609@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello,

On 06/30/2010 09:21 AM, Justin P. Mattock wrote:
>> What does the extra warning buy us?  There are several places which
>> use anonymous enums for constants and I can't see what the benefit of
>> this warning would be.
>
> I don't think it buys us anything..think it's just saying "hey
> you have two #defines with the same value" or something in that
> area(if Im reading the warning correctly) funny thing is, is
> gcc should of done the same with the original patch that I
> sent, as well as the second..  (but could be wrong).

Okay, just tested and it's warning that the code is comparing two
enums which are from two different enum blocks.  I'm kind of
doubtful about its usefulness but then again I don't think there
will be many occassions of this to be problematic either.  For
now, can you please submit a patch to cast just ATA_MAX_QUEUE
to (int) before comparing and short comment explanining why it's
necessary?

Thanks.

-- 
tejun

