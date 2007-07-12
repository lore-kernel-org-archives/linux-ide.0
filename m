From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 07/15] sata_sil24: separate out sil24_do_softreset()
Date: Thu, 12 Jul 2007 16:26:01 -0400
Message-ID: <46968E59.1070202@garzik.org>
References: <11832872551548-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55715 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757453AbXGLU0E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 16:26:04 -0400
In-Reply-To: <11832872551548-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> Separate out sil24_do_softreset() which takes @pmp as its last
> argument.  This will be used to implement sil24_pmp_softreset().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ditto last comment


