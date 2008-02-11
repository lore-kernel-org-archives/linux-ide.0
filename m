From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_ninja32: setup changes
Date: Mon, 11 Feb 2008 14:31:32 -0500
Message-ID: <47B0A294.3000000@garzik.org>
References: <20080208152510.06d9af0a@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55307 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889AbYBKTbj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:31:39 -0500
In-Reply-To: <20080208152510.06d9af0a@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Forcibly set more of the configuration at init time. This seems to fix at
> least one problem reported. We don't know what most of these bits do, but
> we do know what windows stuffs there.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied


