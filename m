From: Tejun Heo <tj@kernel.org>
Subject: Re: Intermittent SATA link down SStatus 0
Date: Thu, 15 Jul 2010 11:20:03 +0200
Message-ID: <4C3ED2C3.9050907@kernel.org>
References: <f4d0374cb498479438e76ac749465a7d.squirrel@thechecks.ca>    <4B5D26EF.4030709@kernel.org> <loom.20100205T041929-66@post.gmane.org>    <12193ff15b0deef3609ea93f54e5b485.squirrel@thechecks.ca>    <13096cdf5e0e6704e30364a746e60467.squirrel@thechecks.ca>    <8276efbfebcbfc3e58033ab8d5996d9d.squirrel@thechecks.ca>    <4C3DACFF.2060504@kernel.org>    <0d9ccbbb9ed0fb46dc9497888cd92c6e.squirrel@thechecks.ca>    <4C3E4A04.5030000@kernel.org> <6cb5020f769580a1f431ed5bb8709b6a.squirrel@thechecks.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49319 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850Ab0GOJUI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jul 2010 05:20:08 -0400
In-Reply-To: <6cb5020f769580a1f431ed5bb8709b6a.squirrel@thechecks.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Check <paul@thechecks.ca>
Cc: linux-ide@vger.kernel.org

Hello,

On 07/15/2010 02:43 AM, Paul Check wrote:
> Ok, well we didn't have to wait long. Once again one of my drives failed
> to appear. This time it was a different drive than the times before.
>
> I have attached the output from dmesg. Can you tell me from this output
> what the problem is?

SStatus and SControl are behaving erratically.  I'm not yet sure why
that's happening yet.

[    2.562157] ata4.01: SATA link up <unknown> (SStatus 300 SControl 123)

Hmm... it looks like SStatus and SControl are swapped here.  Maybe
there's a race condition in SIDPR code.  I'll look into it a bit more.

Thanks.

-- 
tejun
