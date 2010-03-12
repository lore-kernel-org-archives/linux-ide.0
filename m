From: Andrew Benton <b3nton@gmail.com>
Subject: Re: ata2: lost interrupt with kernel 2.6.34-rc1
Date: Fri, 12 Mar 2010 00:01:41 +0000
Message-ID: <4B998465.2080009@gmail.com>
References: <4B992110.2090300@gmail.com> <4B997FB1.3000404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:50684 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab0CLABq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 19:01:46 -0500
In-Reply-To: <4B997FB1.3000404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/03/10 23:41, Jeff Garzik wrote:
> On 03/11/2010 11:57 AM, Andrew Benton wrote:
>> Hello,
>> I'm not subscribed to this list, sorry if it's the wrong place to send
>> this.
>> I've been having problems with 2.6.34-rc1, when the system tries to
>> access a
>> lot of files (eg, if I recompile the kernel) it freezes for about 10
>> seconds
>> or so and then I get a message like this in the sys.log:
>
> Does 2.6.33 also have this behavior?
>

No, 2.6.33 works fine. This freezing, waiting for the disk to be reset is
new behavior in 2.6.34-rc1

Andy
