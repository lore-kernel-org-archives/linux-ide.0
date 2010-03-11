From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ata2: lost interrupt with kernel 2.6.34-rc1
Date: Thu, 11 Mar 2010 18:41:37 -0500
Message-ID: <4B997FB1.3000404@garzik.org>
References: <4B992110.2090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:29846 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0CKXlk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Mar 2010 18:41:40 -0500
In-Reply-To: <4B992110.2090300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Benton <b3nton@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/11/2010 11:57 AM, Andrew Benton wrote:
> Hello,
> I'm not subscribed to this list, sorry if it's the wrong place to send
> this.
> I've been having problems with 2.6.34-rc1, when the system tries to
> access a
> lot of files (eg, if I recompile the kernel) it freezes for about 10
> seconds
> or so and then I get a message like this in the sys.log:

Does 2.6.33 also have this behavior?

	Jeff



