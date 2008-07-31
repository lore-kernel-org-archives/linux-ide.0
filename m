From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [bug] 2.6.27-rc1: I/O errors after resume
Date: Thu, 31 Jul 2008 15:31:17 +0200
Message-ID: <200807311531.18377.rjw@sisk.pl>
References: <200807281203.38822.j.schneider@uib.de> <20080730011223.8f04ba20.akpm@linux-foundation.org> <E1KOXpA-00005w-Vl@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55373 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbYGaN2l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 09:28:41 -0400
In-Reply-To: <E1KOXpA-00005w-Vl@pomaz-ex.szeredi.hu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, 31 of July 2008, Miklos Szeredi wrote:
> With 2.6.27-rc1 things break badly after resume on my T60.  Dmesg and
> config attached.  2.6.26 worked fine.

Ugh, lots of stuff in a single message.

Anyway, can you try the current -git and report back, please?  It's possible
that this has been fixed already.

Thanks,
Rafael
