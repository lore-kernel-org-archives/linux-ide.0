From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 14/15] ahci: separate out ahci_do_softreset()
Date: Thu, 12 Jul 2007 16:26:51 -0400
Message-ID: <46968E8B.8040805@garzik.org>
References: <11832872562351-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55749 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757876AbXGLU0x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:26:53 -0400
In-Reply-To: <11832872562351-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out ahci_do_softreset() which takes @pmp as its last
> argument.  This will be used to implement ahci_pmp_softreset().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ditto


