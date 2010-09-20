From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci rmmodable and shouldn't
Date: Mon, 20 Sep 2010 11:31:03 +0200
Message-ID: <4C9729D7.70500@gmail.com>
References: <201009162256.04765.pedrogfrancisco@gmail.com> <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net> <4C933A8F.2080305@gmail.com> <1284892106.2650.4.camel@sundae-v2> <4C9602E4.4090007@gmail.com> <1284974726.11757.9.camel@sundae-v2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59429 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab0ITJbJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Sep 2010 05:31:09 -0400
In-Reply-To: <1284974726.11757.9.camel@sundae-v2>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Francisco <pedrogfrancisco@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 09/20/2010 11:25 AM, Pedro Francisco wrote:
> Discomfort? Not really, sorry if my stubbornness felt like it. No, I'm
> fine with it.

:-)

> I just thought it was weird the change of behaviour from 2.6.32, plus
> felt that the "Used by" field by lsmod was incorrectly set at 0 since
> the module is, in fact, being used (e)

Hmmm... I don't recall the behavior changing from 2.6.32.  Maybe I've
been just speaking bullshit this whole time.  Can you please post the
output of lsmod?  Maybe the difference is caused by the split between
libahci and ahci?

Thanks.

-- 
tejun
