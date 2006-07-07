From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 22/24] jmicron: Jmicron multifunction setup
Date: Fri, 07 Jul 2006 12:35:45 -0400
Message-ID: <44AE8D61.8040602@pobox.com>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361212843-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036122125! 0-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361233826-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361232889-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361243147-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361254139-git-send-email-ala
 n@lxorguk.ukuu.org.uk> <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28648 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932215AbWGGQfs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 12:35:48 -0400
In-Reply-To: <11520361251284-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>

Oh:

For the future, PLEASE put new drivers into a single patch.

It is particularly important these days for 'git rebase' to always 
produce a compileable kernel, and it wastes some cycles during review (I 
caught bugs you fixed in later patches).

	Jeff



