From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: Add a host flag to indicate lack of IORDY capability
Date: Tue, 06 Feb 2007 19:47:06 -0500
Message-ID: <45C9218A.20802@garzik.org>
References: <20070205161515.38b8107d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57010 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933285AbXBGArI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:47:08 -0500
In-Reply-To: <20070205161515.38b8107d@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan wrote:
> This is the first preparation to doing the !IORDY cases properly. Further
> diffs will then add the needed logic to do it right.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

ACK but please rediff&resend, it clashed with some previous driver 
bombing runs


