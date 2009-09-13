From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: What's in libata-dev.git?
Date: Sun, 13 Sep 2009 01:01:29 -0600
Message-ID: <4AAC98C9.3050005@gmail.com>
References: <20090911064246.GA8422@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f176.google.com ([209.85.210.176]:40483 "EHLO
	mail-yx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZIMHB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Sep 2009 03:01:29 -0400
In-Reply-To: <20090911064246.GA8422@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 09/11/2009 12:42 AM, Jeff Garzik wrote:
>
> This is a summary of the changes current queued on the #upstream branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
> These will be pushed to Linus in the next day or so, when merges start
> flowing.
>
> linux-ide hackers, speak up is something is obviously wrong or missing.
>
> The only outstanding patch is Robert Hancock's enhance-command-parsing
> patch:  I'm still on the fence about leaving the huge switch table, or
> choosing a better data structure.

I just tried implementing some table-based code to achieve something 
like what the patch I posted was doing. The combined code+data size was 
only marginally smaller (about a 3K increase versus 4K with the switch 
version), the function was about the same number of lines, it would be 
slower (scanning through a table rather than the compiler-generated jump 
table, though it's not like it's used on a hot path anyway) and it's 
also less flexible. Particularly with some weird commands (like the way 
they seem to be heading with the DATA SET MANAGEMENT command where the 
feature register is being used as a bitmask instead of a simple command 
code), it would be a lot simpler to implement that in a switch statement 
rather than having to modify an entire table structure to accommodate it.

So essentially my advocated patch is unchanged after that experiment. It 
may not be the prettiest thing in the world, but I'm not sure it really 
gets much better..
