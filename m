From: Jim Paris <jim@jtan.com>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 15:17:15 -0500
Message-ID: <20080108201715.GA20226@jim.sh>
References: <20080108192352.GA9110@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:54307 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbYAHURU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Jan 2008 15:17:20 -0500
Content-Disposition: inline
In-Reply-To: <20080108192352.GA9110@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-ide@vger.kernel.org

Andi Kleen wrote:
> 
> Is there a workaround for the long ugly boot messages on sees
> with libata and qemu (0.9.0 CVS 070719)? It boots eventually, but it looks 
> quite ugly.
> 
> I suppose that's a qemu device model bug or could it be a Linux
> problem?

I believe this has been fixed in QEMU CVS:

  http://www.mail-archive.com/qemu-devel@nongnu.org/msg11844.html

-jim
