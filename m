From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bug 163753] Strange ATA HD configuration
Date: Wed, 12 Nov 2008 18:48:21 +0000
Message-ID: <20081112184821.3bd8d0db@lxorguk.ukuu.org.uk>
References: <008c01c944ea$5d600660$8c00000a@aageneral.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58245 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752203AbYKLSsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 13:48:16 -0500
In-Reply-To: <008c01c944ea$5d600660$8c00000a@aageneral.ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian POPA <adrianp@aageneral.ro>
Cc: jgarzic@pobox.com, Lionel.Bouton@inet6.fr, linux-ide@vger.kernel.org

On Wed, 12 Nov 2008 19:16:09 +0200
"Adrian POPA" <adrianp@aageneral.ro> wrote:

> Hi
> I have reported this bug quite a while but it was marked as Won't fix
> However, I have a patch that you can test and which I am using since then.
> Is no big deal and maybe it can be included in new builds. All builds (last
> 2.6.22-15.40) 

The cable detection code has been entirely rewritten since 2.6.22

Alan
