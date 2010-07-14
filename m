From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 15 Jul 2010 01:36:36 +0200
Message-ID: <4C3E4A04.5030000@kernel.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>    <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>    <4C3DACFF.2060504@kernel.org> <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56701 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757478Ab0GNXgl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jul 2010 19:36:41 -0400
In-Reply-To: <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

Hello,

On 07/14/2010 07:58 PM, Paul Check wrote:
> I applied your patch to the 2.6.34 kernel, and on my very first reboot had
> a drive missing. What information do you want? Just /var/log/messages?

The kernel boot log should suffice.  ie. dmesg output after boot.

> I don't want to keep rebooting forever. Was this patch supposed to fix the
> problem, or just give you information to debug? Is the problem even known?

It should give more information but seems to actually make the other
reporter's problem go away.  It looks like SIDPR SCR access can be
flaky depending on timing but I'm still trying to determine how to
work around it.

Thanks.

-- 
tejun
