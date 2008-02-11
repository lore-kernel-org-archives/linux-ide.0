From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Prevent IDE boot ops on NUMA system in mainline
Date: Mon, 11 Feb 2008 09:37:18 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802110936231.2920@woody.linux-foundation.org>
References: <20080211003520.GA32082@basil.nowhere.org> <alpine.LFD.1.00.0802110929230.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57330 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758656AbYBKRhs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Feb 2008 12:37:48 -0500
In-Reply-To: <alpine.LFD.1.00.0802110929230.2920@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 11 Feb 2008, Linus Torvalds wrote:
> 
> So we should probably make pcibus_to_node() be an inline function for that 
> case

Or, we could just do the ugliest patch ever, namely

	-#define pcibus_to_node(node)   (-1)
	+#define pcibus_to_node(node)   ((int)(long)(node),-1)

Wow. It's so ugly it's almost wraps around and comes out the other sides 
and looks pretty.

		Linus
