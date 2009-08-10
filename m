From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Mon, 10 Aug 2009 18:10:10 -0400
Message-ID: <4A809AC2.70206@duda.tzo.com>
References: <h5kn9c$51r$1@ger.gmane.org> <20090809072823.GA2130@liondog.tnic> <4A7F85DB.40604@duda.tzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:40882 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754021AbZHJWKV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Aug 2009 18:10:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Mad4O-0007RM-Ns
	for linux-ide@vger.kernel.org; Mon, 10 Aug 2009 22:10:21 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 22:10:20 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 10 Aug 2009 22:10:20 +0000
In-Reply-To: <4A7F85DB.40604@duda.tzo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org

On 08/09/2009 10:28 PM, Jim Duda wrote:
> On 08/09/2009 03:28 AM, Borislav Petkov wrote:
>>
>> If you'd like to test patches you can get Dave's linux-next git repo at
>> http://git.kernel.org/?p=linux/kernel/git/davem/ide-next-2.6.git;a=summary
>>
>>

I attempted a tape back up last night with git/davem/ide-next-2.6.git.

The behavior is the same, the 20G byte Travan tape filled up before expected.

Jim

