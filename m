From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Date: Wed, 13 Dec 2006 00:40:30 +0000
Message-ID: <20061213004030.599907a2@localhost.localdomain>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:34977 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964831AbWLMAca (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Dec 2006 19:32:30 -0500
In-Reply-To: <200612130148.34539.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 01:48:34 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Behold!  This is the driver for the Toshiba TC86C001 GOKU-S IDE controller,
> completely reworked from the original brain-damaged Toshiba's 2.4 version.

Actually un-nack the PCI quirk. While it is true the native mode is
relevant because of the way the BAR values work we know legacy bar values
are never "& 8" so the test is sufficient [but should be commented about
the assumption]

Alan
