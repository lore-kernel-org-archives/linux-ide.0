From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata exception handling messages at boot on qemu
Date: Tue, 8 Jan 2008 21:04:28 +0000
Message-ID: <20080108210428.63c90f9d@lxorguk.ukuu.org.uk>
References: <20080108192352.GA9110@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34133 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751157AbYAHVGd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 16:06:33 -0500
In-Reply-To: <20080108192352.GA9110@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-ide@vger.kernel.org

On Tue, 8 Jan 2008 20:23:52 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> 
> Is there a workaround for the long ugly boot messages on sees
> with libata and qemu (0.9.0 CVS 070719)? It boots eventually, but it looks 
> quite ugly.
> 
> I suppose that's a qemu device model bug or could it be a Linux
> problem?

libata actually bothers to check things like data directions and device
state. This as far as I can tell is a qemu bug. I did look at the
relevant code but it was so vomitously horrible I didn't investigate in
detail. I believe the Xen qemu fork is ok ?

Alan
