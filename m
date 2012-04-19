From: Mark Lord <kernel@teksavvy.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Wed, 18 Apr 2012 23:13:48 -0400
Message-ID: <4F8F82EC.1060708@teksavvy.com>
References: <4F8F7533.6020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:27855 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2DSDNu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2012 23:13:50 -0400
In-Reply-To: <4F8F7533.6020300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Ceklosky <jfceklosky@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12-04-18 10:15 PM, Joe Ceklosky wrote:
> All,
> 
> Has anyone reported slowness using SSD's on kernel 3.3.X compiled
> as 32-bit PAE with 16 Gigs of memory (I know I need to update to 64-bit
> already, will do with Fedora 17)?
> 
> I am see terrible r/w to an SSD using 3.3.2.  When I boot the same machine
> and SSD back in 3.2.15 all is fine.


Double check which IO-scheduler the kernel is choosing.
For SSDs, it is normally "noop", but I noticed "cfq"
being chosen instead for some reason.

   find /sys -name scheduler|grep '/sd[a-z]/'|xargs cat

-ml
