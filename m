From: Tejun Heo <tj@kernel.org>
Subject: Re: Can you please test the attached patch for nv hardreset problem?
Date: Tue, 14 Oct 2008 10:18:32 +0900
Message-ID: <48F3F368.2090901@kernel.org>
References: <48E80F11.3060101@kernel.org>	 <64630f150810111634gbe4cfdfjccafc9f6f781edcc@mail.gmail.com>	 <48F30678.7020807@kernel.org> <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60491 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbYJNBUY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 21:20:24 -0400
In-Reply-To: <64630f150810131213m64d8fc72j38debf71a692db16@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gettinther <gettinther@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, lists@ku-gbr.de, linux@sun7.cn, Robert Hancock <hancockr@shaw.ca>

gettinther wrote:
> On Mon, Oct 13, 2008 at 9:27 AM, Tejun Heo <tj@kernel.org> wrote:
>> gettinther wrote:
>>> OK, patching the 2.6.26 based on your patch doesn't work properly.  It
>>> works for sata devices but not sata emulated devices (but these do
>>> work with the 2.6.27).
>> Eh... what do you mean it doesn't work on 2.6.26?  The same change
>> doesn't work on 2.6.26 but it does on 2.6.27?  How did you apply the
>> change to 2.6.26?  Can you post the diff?
>>
>> Thanks.
>>
>> --
>> tejun
>>
> 
> Sorry, replied on the wrong thread
> 
> Here's the patch I applied

Hmm... that should work for 2.6.26 for MCP55.  Can you post the failing log?

-- 
tejun
