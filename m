From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: IDE - fix various comments remove never changing ifdef
Date: Mon, 16 Aug 2004 20:29:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408162029.43797.bzolnier@elka.pw.edu.pl>
References: <20040815143546.GA6284@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27267 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267863AbUHPTGl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Aug 2004 15:06:41 -0400
In-Reply-To: <20040815143546.GA6284@devserv.devel.redhat.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org

On Sunday 15 August 2004 16:35, Alan Cox wrote:
> No code changes in this patch just documenting

If you want to remove FANCY_STATUS_DUMPS define please make
a separate patch and remove it globally.
