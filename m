From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [upstream-next] ahci start engine
Date: Wed, 26 Oct 2011 19:40:21 -0400
Message-ID: <4EA89A65.6010406@teksavvy.com>
References: <CAN8TOE8mTWrHOZd08RhZttARGsa74fGmB7f044GHScA87PJcyg@mail.gmail.com> <4EA1F44A.7020804@pobox.com> <CAN8TOE_m07dirv+ZJ4FuePEipyXWH3B8NJQ+1ag=E5iyJMUXaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:62759 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753336Ab1JZXkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Oct 2011 19:40:23 -0400
In-Reply-To: <CAN8TOE_m07dirv+ZJ4FuePEipyXWH3B8NJQ+1ag=E5iyJMUXaw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 11-10-24 07:43 PM, Brian Norris wrote:
> On Fri, Oct 21, 2011 at 3:38 PM, Jeff Garzik <jgarzik@pobox.com> wrote:
>> On 10/21/2011 06:27 PM, Brian Norris wrote:
>>> commit 936f82ad2254a6712175a36daee9517d6b7a4982
>>> Author: Tejun Heo<tj@kernel.org>
>>> Date:   Fri Jul 22 11:41:26 2011 +0200
>>>
>>>     ahci: start engine only during soft/hard resets
>>
>> hum, neither that branch nor the patch appears to exist locally;  I bet I
>> accidentally deleted #upstream-next during the move.
>>
>> Will resuscitate the branch w/ that patch, at github.
> 
> Thanks, that'd be great.

Ditto.  That bug bites me here all of the time now.
